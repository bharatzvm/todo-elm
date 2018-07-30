module Todo exposing (..)

import Html exposing (Html, Attribute, beginnerProgram, div, text, ul, li, input, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick, on, keyCode)
import Json.Decode as Json
import Html.Attributes exposing (..)


type alias Task =
    { task : String
    , status : Bool
    , id : Int
    }


type alias Tasks =
    List Task


type alias Model =
    { tasks : Tasks
    , newInput : String
    , taskCount : Int
    }


type Msg
    = Add
    | TemporaryInput String
    | Delete Int
    | Done
    | Todo


main : Program Never Model Msg
main =
    beginnerProgram
        { model = Model [] "" 0
        , view = view
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        TemporaryInput task ->
            { model | newInput = task }

        Add ->
            let
                taskCount =
                    model.taskCount + 1

                newTask =
                    Task model.newInput True taskCount
            in
                { model | newInput = "", tasks = List.append model.tasks [ newTask ], taskCount = taskCount }

        Delete x ->
            { model
                | tasks = List.filter (\task -> task.id /= x) model.tasks
            }

        _ ->
            model


view : Model -> Html Msg
view model =
    div []
        [ ul []
            (List.map
                showTask
                model.tasks
            )
        , newTask model
        ]


showTask : Task -> Html Msg
showTask task =
    li []
        [ text task.task
        , button [ onClick (Delete task.id) ] [ text "-" ]
        ]


newTask : Model -> Html Msg
newTask model =
    div []
        [ input
            [ type_ "text"
            , placeholder "Add Task"
            , onInput TemporaryInput
            , value model.newInput
            , onKeyUp Add
            ]
            []
        , button [ onClick Add ] [ text "Add" ]
        ]


onKeyUp : Msg -> Attribute Msg
onKeyUp msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail "not ENTER"
    in
        on "keydown" (Json.andThen isEnter keyCode)
