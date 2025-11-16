module Main exposing (main)
import Html exposing (Html, table, tbody, text, th, thead, tr)
import Html.Attributes exposing (id)
import List exposing (head, map, reverse, singleton, sortBy)
import Maybe exposing (withDefault)
import Pre exposing (Character, char, em, group, omega, schwa)
import String exposing (join, words)
data : List Character
data =
    [ { names =
            { name = "morrigan"
            , pronunciation =
                [ "m"
                , omega |> em 1
                , "r"
                , schwa
                , "g"
                , "y" |> em 2
                , "n"
                ]
                    |> join ""
            }
      , species = "reaper"
      , sex = "female"
      , extra = "Wields a scythe"
      }
    , { names =
            { name = "hound"
            , pronunciation =
                [ "h"
                , [ "a", "u" ] |> group 0
                , "n"
                , "d"
                ]
                    |> join ""
            }
      , species = "changeling"
      , sex = "female"
      , extra = "Shapeshifts into a large, black Wolf"
      }
    ]
sortedChars : List Character
sortedChars =
    data
        |> sortBy
            (\c ->
                c.names.name
                    |> words
                    |> reverse
                    |> head
                    |> withDefault ""
            )
body : List (Html msg)
body =
    sortedChars
        |> map char
main : Html msg
main =
    [ ([ "Name"
            |> text
            |> singleton
            |> th []
       , "Species"
            |> text
            |> singleton
            |> th []
       , "Extra"
            |> text
            |> singleton
            |> th []
       ]
        |> tr []
      )
        |> singleton
        |> thead []
    , body
        |> tbody []
    ]
        |> table
            ("characters"
                |> id
                |> singleton
            )
