#!/bin/bash
./delete.sh

# stage 1 compile
java -cp "salsa1.1.6.jar:." salsac.SalsaCompiler src/*.salsa 
# stage 2 compile
javac -classpath "salsa1.1.6.jar:." src/*.java 


#################################################################
rm -f downloads/*
rm -f server/*

## Run the compiled code ##

# mkdir "downloads"
java -cp "salsa1.1.6.jar:." wwc.naming.WWCNamingServer -p 3030 > downloads/namingServer.txt &
server=$!
java -cp "salsa1.1.6.jar:." wwc.messaging.Theater 4040 > downloads/theater1.txt &
theater1=$!
java -cp "salsa1.1.6.jar:." wwc.messaging.Theater 4041 > downloads/theater2.txt &
theater2=$!
java -cp "salsa1.1.6.jar:." wwc.messaging.Theater 4042 > downloads/theater3.txt &
theater3=$!
java -cp "salsa1.1.6.jar:." src.Client $1 &
client=$!

## Wait for execution to terminate ##

echo "Waiting 5 seconds."
echo
read -t 5 -p ""

## terminate the processes we launched ##
kill $server 2> /dev/null
kill $theater1 2> /dev/null
kill $theater2 2> /dev/null
kill $theater3 2> /dev/null
kill $client 2> /dev/null

echo 
echo "Execution terminated."

