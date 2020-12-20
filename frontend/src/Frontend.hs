{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Frontend where

import Obelisk.Frontend
import Obelisk.Route
import Obelisk.Generated.Static

import Reflex.Dom.Core

import Common.Route

frontend :: Frontend (R FrontendRoute)
frontend = Frontend
  { _frontend_head = do
      elAttr "meta" ("charset" =: "UTF-8") blank
      elAttr "meta" ("name" =: "viewport" <> "contents" =: "width=device-width, initial-scale=1.0") blank
      elAttr "link" ("href" =: $(static "styles.css") <> "type" =: "text/css" <> "rel" =: "stylesheet") blank
  , _frontend_body = do
    divClass "p-6 max-w-sm mx-auto bg-white rounded-xl shadow-md flex items-center space-x-4" $ do
      divClass "flex-shrink-0" $
        elAttr "img" ("class" =: "rounded-full h-12 w-12" <> "src" =: $(static "images/obelisk.jpg") <> "alt" =: "Obelisk in Central Park") blank
      divClass "text-xl font-medium text-black" $ text "obelisk"
      elClass "p" "text-gray-500" $ text "You've got a message!"
  }
