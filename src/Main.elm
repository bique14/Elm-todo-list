port module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


port sendTodo : String -> Cmd msg


type Msg
    = NoOp
    | Add
    | UpdateText String


type alias Model =
    { text : String
    , list : List String
    , state : State
    }


type State
    = Init


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { text = "", list = [], state = Init }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( model.state, msg ) of
        ( _, UpdateText s ) ->
            ( { model | text = s }, Cmd.none )

        ( _, Add ) ->
            ( { model | list = model.list ++ [ model.text ] }, sendTodo model.text )

        _ ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "m-2" ]
        [ input
            [ class "border border-black rounded px-2 py-1 w-8/12"
            , placeholder "type"
            , onInput UpdateText
            ]
            []
        , button [ class "bg-blue-500 text-white rounded px-2 py-1 mx-2 w-20", onClick Add ] [ text "add" ]
        , viewTodoList model.list
        ]


viewTodoList : List String -> Html Msg
viewTodoList ls =
    div []
        (List.map
            (\todo ->
                div []
                    [ text todo
                    ]
            )
            ls
        )
