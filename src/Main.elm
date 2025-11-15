module Main exposing (main)
import Array exposing (..)
import Html exposing (br, code, span, table, td, text, th, tr)
import Html.Attributes exposing (attribute, class, id)
uni : Int -> String
uni n =
    String.fromChar (Char.fromCode n)
dot : String
dot =
    uni 0xB7
acute : String -> String
acute =
    \c -> c ++ uni 0x301
grave : String -> String
grave =
    \c -> c ++ uni 0x300
macron : String -> String
macron =
    \c -> c ++ uni 0x304
--umlaut:String->String
--umlaut=\c->c++uni(0x308)
omega : String
omega =
    uni 0x3C9
schwa : String
schwa =
    uni 0x259
--ethel:String
--ethel=uni(0x153)
em : Int -> String -> String
em n c =
    case n of
        1 ->
            acute c
        2 ->
            grave c
        3 ->
            macron c
        _ ->
            c
group : Int -> String -> String -> String
group n a b =
    "["
        ++ String.join
            (if n > 0 then
                em n dot
             else
                dot
            )
            [ a, b ]
        ++ "]"
char :
    { character
        | names :
            { name : String
            , pro : String
            }
        , species : String
        , sex : String
        , extra : String
    }
    -> Html.Html msg
char character =
    tr
        [ class "character"
        , attribute "sex" character.sex
        ]
        [ td
            [ id "name" ]
            [ span
                [ class "name" ]
                [ text character.names.name ]
            , br [] []
            , code
                [ class "pro" ]
                [ text ("<" ++ character.names.pro ++ ">") ]
            ]
        , td
            [ id "species" ]
            [ text character.species ]
        , td
            [ id "extra" ]
            [ text character.extra ]
        ]
main : Html.Html msg
main =
    table [ id "characters" ]
        [ tr
            []
            [ th [] [ text "Name" ]
            , th [] [ text "Species" ]
            , th [] [ text "Extra" ]
            ]
        , char
            { names =
                { name = "Hound"
                , pro = "H" ++ group 0 "a" "u" ++ "n" ++ "d"
                }
            , species = "Changeling"
            , sex = "Female"
            , extra = "Shapeshifts into a large, black Wolf"
            }
        , char
            { names =
                { name = "Morrigan"
                , pro = "M" ++ em 1 omega ++ "r" ++ em 3 schwa ++ "g" ++ em 2 "y" ++ "n"
                }
            , species = "Reaper"
            , sex = "Female"
            , extra = "Wields a scythe"
            }
        ]
