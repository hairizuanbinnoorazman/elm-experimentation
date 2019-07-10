module Main exposing (Model, Msg(..), half, init, lol, main, renderList, update, view, zola, zzz)

import Browser
import Html exposing (Attribute, Html, div, input, li, text, ul)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)
import List exposing (map, range)
import String exposing (fromFloat, fromInt, toFloat)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- Initialize


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "aaa" }


half : Float -> Float
half n =
    n / 2


zzz : String -> String -> String
zzz hehe hehe2 =
    hehe ++ " <space> " ++ hehe2


lol : Int -> Html zzz
lol nyaa =
    div [] [ text (fromInt nyaa) ]


renderList : List String -> Html msg
renderList lst =
    ul []
        (map (\l -> li [] [ text l ]) lst)


zola : Float -> Html msg
zola aa =
    div [] [ text (fromFloat aa) ]



-- Update


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        , div [] [ text (zzz model.content (String.reverse model.content ++ "jkcknajkcna  knckla")) ]
        , renderList [ "caca", "caca12" ]
        , div [] (map lol (range 1 10))
        , zola (Maybe.withDefault 10.1 (toFloat "3.14"))
        ]
