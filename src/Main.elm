module Main exposing (main)
import Array exposing (..)
import Html exposing (br, span, table, td, text, th, tr)
import Html.Attributes exposing (attribute, class, id)
uni : Int -> String
uni =
    \n -> String.fromChar (Char.fromCode n)
em : Int -> String -> String
em n c =
    case n of
        1 ->
            c ++ uni 0x301
        2 ->
            c ++ uni 0x300
        _ ->
            c
tie : List String -> Int -> String
tie pair emph =
    let
        tiebar : String
        tiebar =
            uni 0xB7
    in
    "["
        ++ String.join
            (if emph > 0 then
                em emph tiebar
             else
                tiebar
            )
            pair
        ++ "]"
omega : String
omega =
    uni 0x3C9
schwa : String
schwa =
    uni 0x259
char :
    { character
        | name : List String
        , species : String
        , sex : String
        , extra : String
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
        , attribute "sex" sex
        ]
        [ td [ id "name" ]
            [ span [ class "name" ] [ text (Maybe.withDefault "N/A" (Array.get 0 name)) ]
            , br [] []
            , span [ class "pro" ] [ text (Maybe.withDefault "N/A" (Array.get 1 name)) ]
            ]
        , td [ id "species" ] [ text species ]
        , td [ id "extra" ] [ text extra ]
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
                , "H" ++ tie [ "a", "u" ] 1 ++ "n" ++ "d"
                ]
            , species = "Changeling"
            , sex = "Female"
            , extra = "Shapeshifts into a large, black Wolf"
            }
        , char
            { name =
                [ "Morrigan"
                , "M" ++ em 1 omega ++ "r" ++ schwa ++ "g" ++ em 2 "y" ++ "n"
                ]
            , species = "Reaper"
            , sex = "Female"
            , extra = "Wields a scythe"
            }
        ]
