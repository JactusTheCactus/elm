# Thoughts?
## ELM
### `/Main.elm`
```elm
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
```
### `/Pre.elm`
```elm
module Pre exposing (Character, char, em, group, omega, schwa)
import Char exposing (fromCode)
import Html exposing (Html, br, span, td, text, tr)
import Html.Attributes exposing (attribute, class, id)
import List exposing (map, singleton)
import String exposing (dropLeft, fromChar, join, left, toLower, toUpper, words)
uni : Int -> String
uni n =
    n
        |> fromCode
        |> fromChar
acute : String
acute =
    uni 0x301
grave : String
grave =
    uni 0x300
hacek : String
hacek =
    uni 0x30C
omega : String
omega =
    uni 0x3C9
schwa : String
schwa =
    uni 0x259
em : Int -> String -> String
em n c =
    c
        ++ (case n of
                1 ->
                    acute
                2 ->
                    grave
                3 ->
                    hacek
                _ ->
                    ""
           )
group : Int -> List String -> String
group n list =
    "["
        ++ (list
                |> join
                    (if n > 0 then
                        "-"
                            |> em n
                     else
                        "-"
                    )
           )
        ++ "]"
capitalize : String -> String
capitalize str =
    str
        |> words
        |> map
            (\s ->
                [ s
                    |> left 1
                    |> toUpper
                , s
                    |> dropLeft 1
                    |> toLower
                ]
                    |> join ""
            )
        |> join " "
type alias Character =
    { names :
        { name : String
        , pronunciation : String
        }
    , species : String
    , sex : String
    , extra : String
    }
char : Character -> Html msg
char character =
    tr
        [ "character"
            |> class
        , character.sex
            |> toLower
            |> attribute "data-sex"
        , character.names.name
            |> words
            |> join "-"
            |> toLower
            |> id
        ]
        [ td
            ("names"
                |> class
                |> singleton
            )
            [ (character.names.name
                |> capitalize
                |> text
                |> singleton
              )
                |> span
                    ("name"
                        |> class
                        |> singleton
                    )
            , []
                |> br []
            , (character.names.pronunciation
                |> capitalize
                |> text
                |> singleton
              )
                |> span
                    ("pronunciation"
                        |> class
                        |> singleton
                    )
            ]
        , (character.species
            |> capitalize
            |> text
            |> singleton
          )
            |> td
                ("species"
                    |> class
                    |> singleton
                )
        , (character.extra
            |> text
            |> singleton
          )
            |> td
                ("extra"
                    |> class
                    |> singleton
                )
        ]
```
## PUG
### `/index.pug`
```pug
doctype html
html
	head
		meta(charset="UTF-8")
		title Characters
		link(
			rel="stylesheet"
			href="style.css"
		)
	body
		div#elm
		script(src="elm.js")
		script.
			Elm.Main.init({
				node: document.getElementById("elm")
			});
```
## SCSS
### `/style.scss`
```scss
$fonts: (
	"Noto+Serif:ital,wght@0,100..900;1,100..900",
	"Noto+Sans:ital,wght@0,100..900;1,100..900",
	"Noto+Sans+Mono:wght@100..900",
	"Fira+Code:wght@300..700"
);
@each $font in $fonts {
	@import url("https://fonts.googleapis.com/css2?family=#{$font}&display=swap");
}
@mixin padding($h: null, $v: null, $t: null, $b: null, $l: null, $r: null) {
	@if $h != false {
		@if $l != false {
			padding-left: if($l != null, $l, if($h != null, $h, 0));
		}
		@if $r != false {
			padding-right: if($r != null, $r, if($h != null, $h, 0));
		}
	}
	@if $v != false {
		@if $t != false {
			padding-top: if($t != null, $t, if($v != null, $v, 0));
		}
		@if $b != false {
			padding-bottom: if($b != null, $b, if($v != null, $v, 0));
		}
	}
}
@mixin wrap($pre: "", $post: "") {
	@each $pos, $v in (before: $pre, after: $post) {
		@if $v != "" {
			&::#{$pos} {
				content: $v;
			}
		}
	}
}
@function bgColour($colour) {
	@return calc($colour * 3 / 4);
}
$serif: "Noto Serif", serif;
$sans: "Noto Sans", sans-serif;
$mono: "Fira Code", "Noto Sans Mono", monospace;
body {
	font: 20pt $sans;
	table {
		width: 100%;
		text-align: center;
		&#characters {
			tr {
				th {
					text-decoration: underline;
				}
				&.character {
					&[data-sex^="m"] {
						color: blue;
						background-color: rgb(
							bgColour(255),
							bgColour(255),
							255
						);
						.name::after {
							content: "\2642";
						}
					}
					&[data-sex^="f"] {
						color: red;
						background-color: rgb(
							255,
							bgColour(255),
							bgColour(255)
						);
						.name::after {
							content: "\2640";
						}
					}
					&:not([data-sex^="m"]):not([data-sex^="f"]) {
						color: green;
						background-color: rgb(
							bgColour(255),
							255,
							bgColour(255)
						);
						.name::after {
							content: "\26a5";
						}
					}
					td {
						@include padding($h: calc(1em / 2), $v: false);
						border-radius: calc(1em / pow(2, 2));
						&.names {
							.name {
								font-weight: bold;
							}
							.pronunciation {
								font-family: $sans;
								@include wrap("<", ">");
							}
						}
						&.extra {
							text-align: justify;
						}
					}
				}
			}
		}
	}
}
```
## TS
### `/pug.ts`
```ts
require("fs")
	.writeFileSync(
		"dist/index.html",
		require("pug")
			.renderFile(
				"src/index.pug",
				{}
			)
	)
```
