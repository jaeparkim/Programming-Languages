# stage 1 compile
java -cp "salsa1.1.6.jar:." salsac.SalsaCompiler src/*.salsa
# stage 2 compile
javac -classpath "salsa1.1.6.jar:." src/*.java

# run
java -cp "salsa1.1.6.jar:." src.Client script1.txt
