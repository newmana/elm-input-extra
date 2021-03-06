module DropdownDemo exposing (main)

import Html exposing (Html, text, p, label, form, ul, li)
import Html.Attributes exposing (style, for)
import Dropdown


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { selectedValue : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { selectedValue = Nothing
      }
    , Cmd.none
    )


dropdownOptions : Dropdown.Options Msg
dropdownOptions =
    let
        defaultOptions =
            Dropdown.defaultOptions DropdownChanged
    in
        { defaultOptions
            | items =
                [ { value = "1", text = "One", enabled = True }
                , { value = "2", text = "Two", enabled = True }
                ]
            , emptyItem = Just { value = "0", text = "[Please Select]", enabled = True }
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    form []
        [ p []
            [ label []
                [ text "Dropdown: "
                , Dropdown.dropdown
                    dropdownOptions
                    []
                    model.selectedValue
                ]
            ]
        , p []
            [ ul []
                [ li [] [ text "Selected Value: ", text <| Maybe.withDefault "Not Selected" model.selectedValue ] ]
            ]
        ]


type Msg
    = NoOp
    | DropdownChanged (Maybe String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        DropdownChanged selectedValue ->
            ( { model | selectedValue = selectedValue }, Cmd.none )
