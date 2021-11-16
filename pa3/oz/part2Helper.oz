
%This file contains the tokenizer for atomizing spec files%

functor
import
    Open
export
    tokenize:Tokenize
define
    fun {SplitPuntuation S}
        case {List.reverse S} of
            46|Tail then [{List.reverse Tail} "."]
        []  44|Tail then [{List.reverse Tail} ","]
        []  13|Tail then {SplitPuntuation {List.reverse Tail}}
        else
            [S]
        end
    end

    %Read a file into a list of lines made out of an atom for each word
    %Even if words in the file are capitalized, atoms comming out of Tokenize will be fully lowercase, this is meant to help with your grammer
    fun {Tokenize Filename}
        local File Content LcContent Lines SplitLines PuncSplitLines in
            File = {New Open.file init(name:Filename flags:[read])}
            {File read(list:Content size:all)}
            {File close}
            LcContent = {List.map Content Char.toLower} 
            Lines = {String.tokens LcContent &\n} %Lines
            SplitLines = {List.map Lines fun {$ Line} {String.tokens Line & } end} %Lines, Words
            PuncSplitLines = {List.map SplitLines fun {$ Line} {List.map Line SplitPuntuation} end} %Lines, Words, SplitWords
            {List.map PuncSplitLines fun {$ Blocks} {List.flatten {List.map Blocks fun {$ Block} {List.map Block String.toAtom} end}} end}
        end
    end
end