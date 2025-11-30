{-# LANGUAGE NamedFieldPuns #-}
module Deque (Deque, mkDeque, pop, push, shift, unshift) where

import Data.IORef

data Node a =
  Node
    { value :: a
    , next :: IORef (Maybe (Node a))
    , prev :: IORef (Maybe (Node a))
    }

mkNode :: a -> IO (Node a)
mkNode value = do
  next <- newIORef Nothing
  prev <- newIORef Nothing
  return Node {value, next, prev}

data Deque a =
  Deque
    { firstNode :: IORef (Maybe (Node a))
    , lastNode  :: IORef (Maybe (Node a))}

mkDeque :: IO (Deque a)
mkDeque = do
  firstNode <- newIORef Nothing
  lastNode <- newIORef Nothing
  return Deque {firstNode = firstNode, lastNode = lastNode}

pop :: Deque a -> IO (Maybe a)
pop deque = do
  lastNode' <- readIORef $ lastNode deque
  case lastNode' of
    Nothing -> return Nothing
    Just node -> do
      let value' = (value node)
      prevNode <- readIORef (prev node)
      case prevNode of
        Nothing -> do
          writeIORef (firstNode deque) Nothing
        Just a -> do
          writeIORef (next a) Nothing
      writeIORef (lastNode deque) prevNode
      return $ Just value'

push :: Deque a -> a -> IO ()
push deque x = do
  lastNode' <- readIORef $ lastNode deque
  newNode <- mkNode x
  case lastNode' of
    Nothing -> writeIORef (firstNode deque) (Just newNode)
    Just node -> do
      writeIORef (next node) (Just newNode)
      writeIORef (prev newNode) (Just node)
  writeIORef (lastNode deque) (Just newNode)

unshift :: Deque a -> a -> IO ()
unshift deque x = do
  firstNode' <- readIORef $ firstNode deque
  newNode <- mkNode x
  case firstNode' of
    Nothing -> writeIORef (lastNode deque) (Just newNode)
    Just node -> do
      writeIORef (prev node) (Just newNode)
      writeIORef (next newNode) (Just node)
  writeIORef (firstNode deque) (Just newNode)

shift :: Deque a -> IO (Maybe a)
shift deque = do
  firstNode' <- readIORef $ firstNode deque
  case firstNode' of
    Nothing -> return Nothing
    Just node -> do
      let value' = (value node)
      nextNode <- readIORef (next node)
      case nextNode of
        Nothing -> do
          writeIORef (firstNode deque) Nothing
          writeIORef (lastNode deque) Nothing
        Just node -> do
          writeIORef (firstNode deque) (Just node)
          writeIORef (prev node) Nothing
      return $ Just value'
