
/*
    Proglang Assignment 3 Part 1 Relations File

    This file is where you should implement your code for part 1 relations.
    You are free to add as many helper processes as you need to this file as long as given names of the replations are not changed.
*/

functor
import
    Search %this will be needed for some of the relations.
    Windsor at 'windsor.ozf'
export
    spouce:Spouce
    childOf:ChildOf
    siblings:Siblings
    firstCousins:FirstCousins
    hasAncestor:HasAncestor
    hasDescendant:HasDescendant
    listAncestors:ListAncestors
    listDescendants:ListDescendants
    hasHeir:HasHeir
    hasSuccessor:HasSuccessor
    heirIsSuccessor:HeirIsSuccessor
define
    proc {Spouce Person Partner}
        choice
            {Windsor.married Person Partner}
        []  {Windsor.married Partner Person}
        end
    end

    proc {ChildOf Child Parent}
        {Windsor.parentOf Parent Child}
    end

    proc {Siblings Person Sibling}
        fail
    end

    proc {FirstCousins Person Cousin}
        fail
    end

    proc {HasAncestor Person Ancestor}
        fail
    end

    proc {HasDescendant Person Descendant}
        fail
    end 

    proc {ListAncestors Person Ancestors}
        fail
    end

    proc {ListDescendants Person Descendants}
        fail
    end

    proc {HasHeir Person Heir}
        fail
    end

    proc {HasSuccessor Person Successor}
        fail
    end

    proc {HeirIsSuccessor Person}
        fail
    end
end 