module Todo exposing (..)

import Html exposing (Html, beginnerProgram, div, text, ul, li)


type alias Task =
    { task : String
    , status : Bool
    }


type alias Tasks =
    List Task


type alias Model =
    Tasks


type Msg
    = Add
    | Delete
    | Done
    | Todo


main : Program Never Model Msg
main =
    beginnerProgram
        { model = [ Task "A" True, Task "AB" True, Task "ABC" True, Task "ABCD" True, Task "ABCDE" True ]
        , view = view
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    div []
        [ ul []
            (List.map
                showTask
                model
            )
        ]


showTask : Task -> Html Msg
showTask task =
    li []
        [ text task.task ]
