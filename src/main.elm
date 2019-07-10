module Main exposing (JsonModel(..), JsonMsg(..), Model(..), Msg(..), User, getUserDetails, init, main, subscriptions, update, userDecoder, view)

import Browser
import Debug
import Html exposing (Html, div, pre, text)
import Http
import Json.Decode exposing (Decoder, at, field, int, map, map2, string)
import String exposing (fromInt)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Model
    = Failure String
    | Loading
    | Success String
    | JsonSuccess User


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
    ( Loading
    , Http.get
        { url = "http://localhost:5000"
        , expect = Http.expectString GotText
        }
    )


getUserDetails : Cmd JsonMsg
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
    | GotUserx (Result Http.Error User)


type JsonMsg
    = GotUser (Result Http.Error User)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err zzz ->
                    ( Failure (Debug.toString zzz), Cmd.none )

        GotUserx result ->
            case result of
                Ok user ->
                    ( JsonSuccess user, Cmd.none )

                Err zzz ->
                    ( Failure (Debug.toString zzz), Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "acacac" ]
        , case model of
            Failure zzz ->
                text ("I was unable to load your book." ++ zzz)

            Loading ->
                text "Loading..."

            Success fullText ->
                pre [] [ text fullText ]

            JsonSuccess aaa ->
                div [] [ text aaa.name ]
        ]
