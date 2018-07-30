module Todo exposing (..)

import Html exposing (Html, beginnerProgram, div, text, ul, li, input, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


type alias Task =
    { task : String
    , status : Bool
    }


type alias Tasks =
    List Task


type alias Model =
    { tasks : Tasks
    , newInput : String
    }


type Msg
    = Add
    | TemporaryInput String
    | Delete
    | Done
    | Todo


main : Program Never Model Msg
main =
    beginnerProgram
        { model = Model [ Task "A" True, Task "AB" True, Task "ABC" True, Task "ABCD" True, Task "ABCDE" True ] ""

        -- { model = []
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
                newTask =
                    Task model.newInput True
            in
                { tasks = List.append model.tasks [ newTask ]
                , newInput = ""
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
        [ text task.task ]


newTask : Model -> Html Msg
newTask model =
    div []
        [ input
            [ type_ "text"
            , placeholder "Add Task"
            , onInput TemporaryInput
            ]
            []
        , button [ onClick Add ] [ text "Add" ]
        ]
