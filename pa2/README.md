# Lambda Calculus Interpreter w/ functional programming

http://cs.rpi.edu/academics/courses/fall21/csci4430/pa2/pa2.pdf

### Contributors
Jae Park and Roland Rao

### Features
1. Create Directory Servers with specified UAN and UAL
2. Create File Servers with specified UAN and UAL
3. Take a file and split it up amongst active File Servers in blocks of 64 characters each. Files are split up concurrently and are stored on the file system in the appropriate file servers' dedicated folder. Files are distributed in a round robin fashion with the file servers in alphabetical order.
4. Retrieves a file by requesting the file's metadata from the directory server and using it to query the file servers for their portion of the file. The blocks are returned to the client and are organized in the HashMap fileBuilding. The blocks are then concatenated and downloaded to the downloads folder.
5. After all instructions are ran the client will delete and dereference the File Servers and Directory Server so that SALSA can begin to garbage collect those actors.

### Bugs (as of Oct 30, 2021)
1. In very rare circumstances, if the speed of the computer is lacking, the quit method can complete before all instructions are carried out. This causes the dereference of file servers and the directory server which are still in use. This causes null exceptions and other issues with SALSA that cause the program to not work as expected. Given that the program is going to be run in an isolated environment we don't believe that this issue wil present itself in testing.


### Run 

```bash
$ ./delete
$ ./run.sh script1.txt
$ ./run.sh script2.txt
$ ./run.sh script3.txt
```

### Notes
Because we have worked with the older version of FileUtility.java, we have included it
in our submission under src/

