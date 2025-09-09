{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Frontend where

import Data.Text (Text)
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
  , _frontend_body = home
  }

home :: DomBuilder t m => m ()
home = elClass "div" "min-h-screen bg-gradient-to-br from-slate-50 to-slate-200 flex flex-col" $ do
  -- Navbar
  elClass "nav" "bg-white shadow p-4 flex justify-between items-center" $ do
    elClass "div" "flex items-center space-x-2" $ do
      elAttr "img"
        ( "class" =: "h-8 w-8 rounded-full"
        <> "src"   =: $(static "images/obelisk.jpg")
        <> "alt"   =: "Obelisk logo"
        ) blank
      elClass "span" "text-xl font-bold text-slate-800" $ text "Obelisk"
    elClass "div" "space-x-4" $ do
      elAttr "a"
        ( "class" =: "text-slate-600 hover:text-slate-900 font-medium"
        <> "href" =: "https://github.com/obsidiansystems/obelisk-tailwind-example?tab=readme-ov-file"
        ) $ text "Docs"
      elAttr "a"
        ( "class" =: "text-slate-600 hover:text-slate-900 font-medium"
        <> "href" =: "https://github.com/obsidiansystems/obelisk-tailwind-example"
        ) $ text "GitHub"

  -- Hero section
  elClass "header" "flex-1 flex flex-col items-center justify-center text-center px-6" $ do
    elClass "h1" "text-5xl font-extrabold text-slate-800 mb-4" $
      text "Welcome to Obelisk"
    elClass "p" "text-lg text-slate-600 max-w-2xl mb-8" $
      text "Yes, this is Haskell. Yes, it’s running in your browser. And yes—it looks great with Tailwind CSS."
    elClass "div" "space-x-4" $ do
      elClass "a" "px-6 py-3 bg-blue-600 text-white rounded-lg shadow hover:bg-blue-700 font-medium" $
        text "Get Started"
      elClass "a" "px-6 py-3 bg-white text-blue-600 border border-blue-600 rounded-lg hover:bg-blue-50 font-medium" $
        text "Learn More"

  -- Feature cards
  elClass "section" "grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 p-8 max-w-6xl mx-auto" $ do
    featureCard "⚡️" "Reactive" "Build UIs that respond instantly with Reflex FRP."
    featureCard "🎨" "Beautiful" "Use Tailwind to design fast, modern, responsive pages."
    featureCard "🔒" "Type-Safe" "Leverage Haskell’s type system all the way to the frontend."

  -- Footer
  elClass "footer" "bg-slate-800 text-slate-200 text-center py-4 mt-auto" $ do
    text "❤️ Made with reflex-dom & TailwindCSS"

featureCard
  :: DomBuilder t m
  => Text -> Text -> Text -> m ()
featureCard icon title desc =
  elClass "div" "bg-white rounded-2xl shadow p-6 hover:shadow-lg transition" $ do
    elClass "div" "text-4xl mb-4" $ text icon
    elClass "h3" "text-xl font-semibold mb-2 text-slate-800" $ text title
    elClass "p" "text-slate-600" $ text desc

