module Main exposing (main)

import Array exposing (..)
import Html exposing (Html, br, span, table, td, text, th, tr)
import Html.Attributes exposing (attribute, class, id)


uni : Int -> String
uni n =
    String.fromChar (Char.fromCode n)


em : String -> Int -> String
em c n =
    if n == 1 then
        c ++ uni 0x0301

    else if n == 2 then
        c ++ uni 0x0300

    else
        c


tie : List String -> String
tie pair =
    String.join (uni 0x035F) pair


omega : String
omega =
    uni 0x03C9


schwa : String
schwa =
    uni 0x0259


char :
    { character
        | name : List String
        , species : String
        , sex : String
        , extra : Html msg
    }
    -> Html.Html msg
char character =
    let
        name =
            Array.fromList character.name

        species =
            character.species

        sex =
            character.sex

        extra =
            character.extra
    in
    tr
        [ class "character"
        , id (Maybe.withDefault "n/a" (Array.get 0 name))
        , attribute "sex" sex
        ]
        [ td [ id "name" ]
            [ span [ class "name" ] [ text (Maybe.withDefault "N/A" (Array.get 0 name)) ]
            , br [] []
            , span [ class "pro" ] [ text (Maybe.withDefault "N/A" (Array.get 1 name)) ]
            ]
        , td [ id "species" ] [ text species ]
        , td [ id "extra" ] [ extra ]
        ]


main : Html.Html msg
main =
    table [ id "characters" ]
        [ tr []
            [ th [] [ text "Name" ]
            , th [] [ text "Species" ]
            , th [] [ text "Extra" ]
            ]
        , char
            { name =
                [ "Hound"
                , "H" ++ tie [ em "a" 1, "u" ] ++ "nd"
                ]
            , species = "Changeling"
            , sex = "Female"
            , extra = text "Shapeshifts into a large, black Wolf"
            }
        , char
            { name =
                [ "Morrigan"
                , "M" ++ em omega 1 ++ "r" ++ schwa ++ "g" ++ em "y" 2 ++ "n"
                ]
            , species = "Reaper"
            , sex = "Female"
            , extra = text "Wields a scythe"
            }
        ]
