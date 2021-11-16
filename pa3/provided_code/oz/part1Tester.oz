/*
    Proglang Assignment 3 Part 1 Test File

    This file is for verifying that your rules work as intended. If you have implemented your rules correctly, all of these tests will pass.
    Note that these are just sample tests and not the tests that will be used for grading, to ensure your rules are correct you should add 
    your own tests as you see fit to ensure your relations work. 
*/

functor
import
    System
    Search
    Browser 
    Application
    Relations at 'relations.ozf'
define
    %Takes a test function evaluating to a bool and prints if the test failed or passed, exceptions will be printed to the Browser
    proc {PrintTestResult Test}
        try
            if {Test} then
                {System.showInfo "Test Passed"}
            else
                {System.showInfo "Test Failed"}
            end
        catch E then
            {System.showInfo 'Test Failed, exception thrown'}
            {Browser.browse '** '#E#' **'} %In order to see this, you must comment out {Application.exit 0} at the bottom of this file.
        end 
    end 

    %Utility used to compare lists of ancestors and descendants returned by search in an arbitrary order.
    %Returns true if two lists match up element-wise after sorting
    fun {CompareLists L1 L2}
        if {Not {List.length L1} == {List.length L1}} then
            fail 
        else 
            {List.all {List.zip {List.sort L1 Value.'<'} {List.sort L2 Value.'<'} fun {$ E1 E2} E1==E2 end} fun {$ X} X end}
        end
    end 
    
    {System.showInfo "Test 1: Edward VIII and George VI are siblings"}
    {PrintTestResult fun {$} {List.member george_vi {Search.base.all proc {$ Sibling} {Relations.siblings edward_viii Sibling} end}} end}
    {System.showInfo "Test 2: Anne Princess-Royal, and Lady Sarah are first cousins"}
    {PrintTestResult fun {$} {List.member lady_sarah {Search.base.all proc {$ Cousin} {Relations.firstCousins princess_anne_royal Cousin} end}} end}
    {System.showInfo "Test 3: Victoria is an ancestor of Prince Charles"}
    {PrintTestResult fun {$} {List.member victoria {Search.base.all proc {$ Ancestor} {Relations.hasAncestor prince_charles Ancestor} end}} end}
    {System.showInfo "Test 4: Mary of Teck is not a descendant of Edward VII"}
    {PrintTestResult fun {$} {Not {List.member mary_of_teck {Search.base.all proc {$ Decendant} {Relations.hasDescendant edward_vii Decendant} end}}} end}
    {System.showInfo "Test 5: George V's ancestors are Victoria, Prince Albert, Edward VII, and Alexandra"}
    {PrintTestResult fun {$} {CompareLists {List.nth {Search.base.all proc {$ AncestorList} {Relations.listAncestors george_v AncestorList} end} 1} [victoria prince_albert edward_vii alexandra]} end}
    {System.showInfo "Test 6: George VI's descendants are Elizabeth II, Princess Margaret, David Earl-of-Snowdon, Lady Sarah, Prince Charles, Anne Princess-Royal, Prince Andrew, and Prince Edward"}
    {PrintTestResult fun {$} {CompareLists {List.nth {Search.base.all proc {$ DecendantList} {Relations.listDescendants george_vi DecendantList} end} 1} [elizabeth_ii princess_margaret david_earl_of_snowdon lady_sarah prince_charles princess_anne_royal prince_andrew prince_edward]} end}
    {System.showInfo "Test 7: Edward VIII is the heir to George V"}
    {PrintTestResult fun {$} {List.member edward_viii {Search.base.all proc {$ Heir} {Relations.hasHeir george_v Heir} end}} end}
    {System.showInfo "Test 8: Both Edward VIII and George VI are successors to George V"}
    {PrintTestResult fun {$} {CompareLists {Search.base.all proc {$ Successor} {Relations.hasSuccessor george_v Successor} end} [edward_viii george_vi]} end}
    {System.showInfo "Test 9: Empress Victoria (of Germany) is not the successor to Victoria, even though she is Victoria's heir"}
    %This code actually reads victoria is not on the list of people who's heirs are their successors
    {PrintTestResult fun {$} {Not {List.member victoria {Search.base.all proc {$ Person} {Relations.heirIsSuccessor Person} end}}} end}
    {Application.exit 0} %Comment out this line if testing with browser to see exceptions 
end
