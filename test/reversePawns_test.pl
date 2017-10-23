reversePawns_tests :-
    expected(
        'reversePawns (1)',
        (
            reversePawns(
                [ ['W', _ , _ ],
                  [ _ ,'W','W'],
                  [ _ ,'B', _ ] ],
                  [[0,0], [1,2]],
                  O1
            ),
            matrix2list(O1, ListO1),
            list_novar(ListO1, NovarList01)
        ),
        ['B','W','B','B' ],
        NovarList01
    ),
    log('end reversePawns tests'),
    !.