{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE EmptyCase #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}

module Common.Route where

import Data.Functor.Identity (Identity)
import Data.Kind (Type)
import Data.Text (Text)

import Obelisk.Route
import Obelisk.Route.TH

data BackendRoute :: Type -> Type where
  -- | Used to handle unparseable routes.
  BackendRoute_Missing :: BackendRoute ()
  -- You can define any routes that will be handled specially by the backend here.
  -- i.e. These do not serve the frontend, but do something different, such as serving static files.

data FrontendRoute :: Type -> Type where
  FrontendRoute_Main :: FrontendRoute ()
  -- This type is used to define frontend routes, i.e. ones for which the backend will serve the frontend.

concat <$> mapM deriveRouteComponent
  [ ''BackendRoute
  , ''FrontendRoute
  ]

fullRouteEncoder
  :: Encoder (Either Text) Identity (R (FullRoute BackendRoute FrontendRoute)) PageName
fullRouteEncoder = mkFullRouteEncoder
  (FullRoute_Backend BackendRoute_Missing :/ ())
  (\case
      BackendRoute_Missing -> PathSegment "missing" $ unitEncoder mempty)
  (\case
      FrontendRoute_Main -> PathEnd $ unitEncoder mempty)

-- | Like 'fullRouteEncoder', but fails at runtime instead of in the type
-- system if the route encoding is invalid. Entry points use this directly
-- in v2 (there is no @checkEncoder@ call at the entry point anymore).
checkedFullRouteEncoder :: Encoder Identity Identity (R (FullRoute BackendRoute FrontendRoute)) PageName
checkedFullRouteEncoder = case checkEncoder fullRouteEncoder of
  Left e -> error $ show e
  Right x -> x

