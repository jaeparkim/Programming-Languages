
functor
export
    parentOf:ParentOf
    married:Married
    birthYear:BirthYear
    monarch:Monarch
define
    proc {ParentOf Parent Child}
        choice
            Parent=victoria
            Child=empress_victoria
        []  Parent=victoria
            Child=edward_vii
        []  Parent=victoria
            Child=princess_alice
        []  Parent=victoria
            Child=princess_helena
        []  Parent=victoria
            Child=princess_louise
        []  Parent=victoria
            Child=prince_arthur
        []  Parent=victoria
            Child=prince_leopold
        []  Parent=victoria
            Child=princess_beatrice
        []  Parent=prince_albert
            Child=empress_victoria
        []  Parent=prince_albert
            Child=edward_vii
        []  Parent=prince_albert
            Child=princess_alice
        []  Parent=prince_albert
            Child=princess_helena
        []  Parent=prince_albert
            Child=princess_louise
        []  Parent=prince_albert
            Child=prince_arthur
        []  Parent=prince_albert
            Child=prince_leopold
        []  Parent=prince_albert
            Child=princess_beatrice
        []  Parent=edward_vii
            Child=prince_albert_victor
        []  Parent=edward_vii
            Child=george_v
        []  Parent=edward_vii
            Child=princess_louise_royal
        []  Parent=edward_vii
            Child=princess_victoria
        []  Parent=edward_vii
            Child=princess_maud
        []  Parent=alexandra
            Child=prince_albert_victor
        []  Parent=alexandra
            Child=george_v
        []  Parent=alexandra
            Child=princess_louise_royal
        []  Parent=alexandra
            Child=princess_victoria
        []  Parent=alexandra
            Child=princess_maud
        []  Parent=george_v
            Child=edward_viii
        []  Parent=george_v
            Child=george_vi
        []  Parent=george_v
            Child=princess_mary_royal
        []  Parent=george_v
            Child=prince_henry
        []  Parent=george_v
            Child=prince_george
        []  Parent=george_v
            Child=prince_john
        []  Parent=mary_of_teck
            Child=edward_viii
        []  Parent=mary_of_teck
            Child=george_vi
        []  Parent=mary_of_teck
            Child=princess_mary_royal
        []  Parent=mary_of_teck
            Child=prince_henry
        []  Parent=mary_of_teck
            Child=prince_george
        []  Parent=mary_of_teck
            Child=prince_john
        []  Parent=george_vi
            Child=elizabeth_ii
        []  Parent=george_vi
            Child=princess_margaret
        []  Parent=elizabeth_bowes_lyon
            Child=elizabeth_ii
        []  Parent=elizabeth_bowes_lyon
            Child=princess_margaret
        []  Parent=elizabeth_ii
            Child=prince_charles
        []  Parent=elizabeth_ii
            Child=princess_anne_royal
        []  Parent=elizabeth_ii
            Child=prince_andrew
        []  Parent=elizabeth_ii
            Child=prince_edward
        []  Parent=princess_margaret
            Child=david_earl_of_snowdon
        []  Parent=princess_margaret
            Child=lady_sarah
        []  Parent=antony_earl_of_snowdon
            Child=david_earl_of_snowdon
        []  Parent=antony_earl_of_snowdon
            Child=lady_sarah
        end
    end

    proc {Married Wife Husband}
        choice
            Wife=victoria
            Husband=prince_albert
        []  Wife=alexandra
            Husband=edward_vii
        []  Wife=mary_of_teck
            Husband=george_v
        []  Wife=elizabeth_bowes_lyon
            Husband=george_vi
        []  Wife=elizabeth_ii
            Husband=prince_philip
        end 
    end

    proc {BirthYear Person Year}
        choice
            Person=victoria
            Year=1819
        []  Person=prince_albert
            Year=1819
        []  Person=empress_victoria
            Year=1840
        []  Person=edward_vii
            Year=1841
        []  Person=princess_alice
            Year=1843
        []  Person=prince_alfred
            Year=1844
        []  Person=princess_helena
            Year=1846
        []  Person=princess_louise
            Year=1848
        []  Person=prince_arthur
            Year=1850
        []  Person=edward_vii
            Year=1841
        []  Person=prince_leopold
            Year=1853
        []  Person=princess_beatrice
            Year=1857
        []  Person=alexandra
            Year=1844
        []  Person=prince_albert_victor
            Year=1864
        []  Person=george_v
            Year=1865
        []  Person=princess_louise_royal
            Year=1867
        []  Person=princess_victoria
            Year=1868
        []  Person=princess_maud
            Year=1869
        []  Person=mary_of_teck
            Year=1867
        []  Person=edward_viii
            Year=1894
        []  Person=george_vi
            Year=1895
        []  Person=princess_mary_royal
            Year=1897
        []  Person=prince_henry
            Year=1900
        []  Person=prince_george
            Year=1902
        []  Person=prince_john
            Year=1905
        []  Person=elizabeth_bowes_lyon
            Year=1900
        []  Person=elizabeth_ii
            Year=1926
        []  Person=princess_margaret
            Year=1930
        []  Person=prince_philip
            Year=1921
        []  Person=antony_earl_of_snowdon
            Year=1930
        []  Person=prince_charles
            Year=1948
        []  Person=princess_anne_royal
            Year=1950
        []  Person=prince_andrew
            Year=1960
        []  Person=prince_edward
            Year=1964
        []  Person=david_earl_of_snowdon
            Year=1961
        []  Person=lady_sarah
            Year=1964
        end 
    end

    proc {Monarch Person}
        choice
            Person=victoria
        []  Person=edward_vii
        []  Person=george_v
        []  Person=edward_viii
        []  Person=george_vi
        []  Person=elizabeth_ii
        end
    end
end