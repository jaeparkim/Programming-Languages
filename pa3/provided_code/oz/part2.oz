
/*
    Proglang Assignment 3 Part 1 Relations File

    This file is where you should implement your code for part 2. 
*/

functor
import
    Helper at 'part2Helper.ozf'
    Application
    %FD         %You are expected to make use of FD in ManyCore, see http://mozart2.org/mozart-v1/doc-1.4.0/system/node14.html#chapter.fd
    Browser     %For Testing
    System
    Search
define
    %Write your NLP grammar processing here.

    %You can write your constraint program in here.
    %Tokens will be global, you can access it inside of ManyCore, think of Tokens as the input.
    %ManyCore should return a structure (a list of records would work well here) containing enough
    %info to print out a list of solutions in line with the samples provided in the assignment. 
    fun {ManyCore}
        {Browser.browse Tokens} %Tokens is accessible in here!
        %Call into your NLP grammar processing on Tokens to extract information about definitions and constraints.
        %Use that info to set up and solve the constraint satisfation problem and return your solution.
        fail
    end

    %Print your solutions to standard out.
    %In Oz (not in prolog) you may print your solutions out in any order as long as they are in the format specified in the assignment 3 pdf.
    proc {PrintSolutions Solutions}
        {System.printInfo 'Your Properly Formatted Solutions Here'} 
    end

    %If you plan on modifying any of this, please ensure that your program is still able to extract the tokens from the file provided at the command line.
    Args = {Application.getArgs plain}
    Tokens = {Helper.tokenize {List.nth Args 1}} %Tokens is global and hence accessable from your ManyCore process.
    {PrintSolutions {Search.base.all ManyCore}}
    %{Application.exit 0} %Uncomment this for your final sumbission.
end