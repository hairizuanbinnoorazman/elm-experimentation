module Main exposing (main)

import Browser
import Html exposing (Html, button, div, h1, li, ol, text)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Decoder, decodeString, float, int, list, null, string)
import Json.Decode.Pipeline exposing (hardcoded, optional, optionalAt, required, requiredAt)
import String exposing (fromInt)



-- MAIN


main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    { zmodel : ZModel
    , nyaa : Int
    }


type ZModel
    = Failure String
    | Loading
    | Success String


type alias User =
    { name : String
    , occupation : String
    , children :
        List Child
    , animal : AllAnimals
    }


type alias AllAnimals =
    { dog :
        List Animal
    , rabbit :
        List Animal
    }


type alias Child =
    { name : String
    , school : String
    }


type alias Animal =
    { name : String
    , types : String
    , affliation : String
    , countOfUsers : Int
    }


type alias Miaoza =
    { hahax : List String
    }


zzhahax : Miaoza
zzhahax =
    { hahax =
        [ "cacac"
        , "caca"
        , "kjnajknxjkakc"
        ]
    }


printMogul xxx =
    li [] [ text xxx ]


convertToList : Miaoza -> Html Msg
convertToList miaoza =
    div []
        [ h1 [] [ text "acac" ]
        , ol [] (List.map printMogul miaoza.hahax)
        ]



-- , animals :
--     { dogs :
--         List
--             { name : String
--             }
--     , rabbit :
--         List
--             { name : String
--             }
--     }
-- }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { zmodel = Loading
      , nyaa = 0
      }
    , Cmd.batch
        [ getBasicDetails
        ]
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fulltext ->
                    ( { model | zmodel = Success fulltext.occupation }, Cmd.none )

                Err zzz ->
                    ( { model | zmodel = Success (Debug.toString zzz) }, Cmd.none )

        Increment ->
            ( { model | nyaa = model.nyaa + 1 }, Cmd.none )

        Decrement ->
            ( { model | nyaa = model.nyaa - 1 }, Cmd.none )

        Zoro ->
            ( model, Cmd.batch [ getBasicDetails ] )


getBasicDetails : Cmd Msg
getBasicDetails =
    Http.get
        { url = "http://localhost:5000/complexjson"
        , expect = Http.expectJson GotText userDecoder
        }


allAnimalsDecoder : Decoder AllAnimals
allAnimalsDecoder =
    Decode.succeed AllAnimals
        |> optional "dog" (list animalDecoder) []
        |> optional "rabbit" (list animalDecoder) []


animalDecoder : Decoder Animal
animalDecoder =
    Decode.succeed Animal
        |> required "name" string
        |> optional "types" string "undefined animal type"
        |> optional "affliation" string "undefined affliation"
        |> optional "countOfUsers" int 0


childDecoder : Decoder Child
childDecoder =
    Decode.succeed Child
        |> required "name" string
        |> required "school" string


emptyAllAnimals : AllAnimals
emptyAllAnimals =
    { dog = []
    , rabbit = []
    }


userDecoder : Decoder User
userDecoder =
    Decode.succeed User
        |> required "name" string
        |> optional "occupation" string "Undefined"
        |> optional "children" (list childDecoder) []
        |> optional "animals" allAnimalsDecoder emptyAllAnimals


type Msg
    = GotText (Result Http.Error User)
    | Increment
    | Decrement
    | Zoro


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "cacacc" ]
        , case model.zmodel of
            Failure zzz ->
                text ("I was unable to load your book." ++ zzz)

            Loading ->
                text "Loading..."

            Success fullText ->
                div [] [ text fullText ]
        , div [] [ text (fromInt model.nyaa) ]
        , button [ onClick Decrement ] [ text "-" ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Zoro ] [ text "Refresh this value" ]
        , convertToList zzhahax
        ]
