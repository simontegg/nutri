module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String exposing (trim, length, isEmpty, toLower, toUpper, any, all)
import Char exposing (isDigit, isLower, isUpper)


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- INIT


init : (Person, Cmd Msg)
init = 
    (Person "" 0 0 False, Cmd.none)



-- MODEL


type alias Person =
  { name : String
  , age : Int
  , weight : Int
  , validate : Bool
  }



-- UPDATE


type Msg
    = Name String
    | Age String
    | Weight String

update : Msg -> Person -> (Person, Cmd Msg)
update msg person =
  case msg of
    Name name ->
      ({ person | name = name, validate = True }, Cmd.none)

    Age age ->
      ({ person | age = toInt age, validate = True }, Cmd.none)

    Weight weight ->
      ({ person | weight = toInt weight, validate = True }, Cmd.none)


-- VIEW


view : Person -> Html Msg
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "number", placeholder "Age", onInput Age ] []
    , input [ type_ "number", placeholder "Weight", onInput Weight ] []
    , button [] [ text "Submit" ]
    , viewValidation model
    ]


toInt str =
  String.toInt str |> Result.toMaybe |> Maybe.withDefault 0


viewValidation : Person -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.validate then
        if True then
          ("green", "Sweet")
        else ("green", "OK")
      else ("white", "")
  in
    div [ style [("color", color)] ] [ text message ]



-- SUBSCRIPTIONS


subscriptions : Person -> Sub Msg
subscriptions model =
  Sub.none



