module Main exposing (JsonModel(..), Msg(..), User, getUserDetails, init, main, subscriptions, update, userDecoder, view)

import Browser
import Debug
import Html exposing (Html, div, pre, text)
import Http
import Json.Decode exposing (Decoder, at, field, int, map, map2, string)
import String exposing (fromInt)
import ZZZ



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { zmodel : ZModel
    , jmodel : JsonModel
    }


type ZModel
    = Failure String
    | Loading
    | Success String


type JsonModel
    = JFailure String
    | JLoading
    | JSuccess User


type alias User =
    { name : String
    , age : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { zmodel = Loading
      , jmodel = JLoading
      }
    , Cmd.batch
        [ getBasicDetails
        , getUserDetails
        ]
    )


getBasicDetails : Cmd Msg
getBasicDetails =
    Http.get
        { url = "http://localhost:5000"
        , expect = Http.expectString GotText
        }


getUserDetails : Cmd Msg
getUserDetails =
    Http.get
        { url = "http://localhost:5000/json"
        , expect = Http.expectJson GotUser userDecoder
        }


userDecoder : Decoder User
userDecoder =
    map2
        User
        (at [ "name" ] string)
        (at [ "age" ] int)



-- UPDATE


type Msg
    = GotText (Result Http.Error String)
    | GotUser (Result Http.Error User)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fulltext ->
                    ( { model | zmodel = Success fulltext }, Cmd.none )

                Err zzz ->
                    ( { model | zmodel = Success (Debug.toString zzz) }, Cmd.none )

        GotUser result ->
            case result of
                Ok user ->
                    -- The | operator serve to mean update the field -> so it's more like take current model and update jmodel with JSuccess and user
                    ( { model | jmodel = JSuccess user }, Cmd.none )

                Err zzza ->
                    ( { model | jmodel = JFailure (Debug.toString zzza) }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "acacac" ]
        , case model.zmodel of
            Failure zzz ->
                text ("I was unable to load your book." ++ zzz)

            Loading ->
                text "Loading..."

            Success fullText ->
                pre [] [ text fullText ]
        , case model.jmodel of
            JFailure zzza ->
                text ("I was unable to load the bloody json." ++ zzza)

            JLoading ->
                text "Loading..."

            JSuccess user ->
                div [] [ text (user.name ++ " is " ++ String.fromInt user.age ++ " years old") ]
        , ZZZ.zzz
        ]
