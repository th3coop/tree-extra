module TreeExtraTest exposing (suite)

import Expect exposing (Expectation)
import Test exposing (..)
import Tree
import Tree.Extra exposing (..)


s =
    Tree.singleton


t =
    Tree.tree


a =
    t 1 [ t 2 [ s 3, t 4 [ s 5, s 6 ] ] ]


suite : Test
suite =
    describe "The Tree.Extra module"
        [ test "moveSubTree" <|
            \_ ->
                moveSubTree 4 1 a
                    |> Expect.equal (Just (t 1 [ t 2 [ t 3 [] ], t 4 [ t 5 [], t 6 [] ] ]))
        , test "removeSubTree" <|
            \_ ->
                removeSubTree 3 a
                    |> Maybe.andThen (removeSubTree 5)
                    |> Expect.equal (Just (t 1 [ t 2 [ t 4 [ t 6 [] ] ] ]))
        , test "spanningTree" <|
            \_ ->
                spanningTree [ 3, 5 ] a
                    |> Expect.equal (Just (t 2 [ t 3 [], t 4 [ t 5 [], t 6 [] ] ]))
        , test "attach" <|
            let
                x =
                    t 3 [ s 4, s 5 ]
            in
            \_ ->
                attach (<) 6 x a
                    |> Expect.equal (Just (t 1 [ t 2 [ t 3 [], t 4 [ t 5 [], t 6 [] ], t 3 [ t 4 [], t 5 [] ] ] ]))
        , test "depth" <|
            \_ ->
                depth a
                    |> Expect.equal 3
        , test "nodeCount" <|
            \_ ->
                nodeCount a
                    |> Expect.equal 6
        , test "tagWithDepth" <|
            \_ ->
                tagWithDepth a
                    |> Expect.equal (t ( 1, 0 ) [ t ( 2, 1 ) [ t ( 3, 2 ) [], t ( 4, 2 ) [ t ( 5, 3 ) [], t ( 6, 3 ) [] ] ] ])
        ]
