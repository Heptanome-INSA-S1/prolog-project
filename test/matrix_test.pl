matrix_tests :-

    % list2matrix
    list2matrix_tests,

    % matrix2list
    matrix2list_tests,

    % matrix_row
    matrix_row_tests,

    % matrix_diag
    matrix_diag_tests,

    % test matrix_right_same
    matrix_right_same_tests,

    % test matrix_left_same
    matrix_left_same_tests,

    % test matrix_bottom_same
    matrix_bottom_same_tests,

    % test matrix_top_same
    matrix_top_same_tests,

    % test matrix_left_top_same
    matrix_left_top_same_tests,

    % test matrix_left_bottom_same
    matrix_left_bottom_same_tests,

    % test matrix_right_top_same
    matrix_right_top_same_tests,

    % test matrix_right_bottom_same
    matrix_right_bottom_same_tests,

    % test matrix_dims
    matrix_dims_tests,

    log('End matrix tests'),

    !.

list2matrix_tests :-
    expected(
        'list2matrix (1)',
        list2matrix([a,b,c,d,e,f], 3, L2M_Res1),
        [[a,b,c], [d,e,f]],
        L2M_Res1
    ),
    expected(
        'list2matrix (2)',
        list2matrix([a,b,c,d,e,f], 2, L2M_Res2),
        [[a,b], [c,d], [e,f]],
        L2M_Res2
    ),
    log('End list2matrix tests'),
    !.

matrix2list_tests :-
    expected(
        'matrix2list (1)',
        matrix2list([[a,b], [c,d], [e,f]], M2L_Res1),
        [a,b,c,d,e,f],
        M2L_Res1
    ),
    expected(
        'matrix2list (2)',
        matrix2list([[a,b,c],[d,e,f]], M2L_Res2),
        [a,b,c,d,e,f],
        M2L_Res2
    ),
    expected(
        'matrix2list (3)',
        matrix2list([[]], M2L_Res3),
        [],
        M2L_Res3
    ),
    log('End matrix2list tests'),
    !.

matrix_row_tests :-
    expected(
        'matrix_row (1)',
        matrix_row([[a,b], [c,d], [e,f]], 0, MatrixRow_Res1),
        [a,b],
        MatrixRow_Res1
    ),
    expected(
        'matrix_row (2)',
        matrix_row([[a,b], [c,d], [e,f]], 1, MatrixRow_Res2),
        [c,d],
        MatrixRow_Res2
    ),
    expected(
        'matrix_row (3)',
        matrix_row([[a,b,c],[d,e,f]], 1, MatrixRow_Res3),
        [d,e,f],
        MatrixRow_Res3
    ),
    unexpected(
        'matrix_row (4)',
        matrix_row([[a,b,c],[d,e,f]], 2, MatrixRow_Res4),
        MatrixRow_Res4
    ),
    expected(
        'matrix_row (5)',
        matrix_row([[]], 0, MatrixRow_Res5),
        [],
        MatrixRow_Res5
    ),
    log('End matrix_row tests'),
    !.

matrix_diag_tests :-
    expected(
        'matrix_diag (1)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [0,0], 'RightBottom', MD_RB_1),
        [a,e,i],
        MD_RB_1
    ),
    expected(
        'matrix_diag (2)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [0,1], 'RightBottom', MD_RB_2),
        [b,f],
        MD_RB_2
    ),
    expected(
        'matrix_diag (3)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [0,2], 'RightBottom', MD_RB_3),
        [c],
        MD_RB_3
    ),
    unexpected(
        'matrix_diag (4)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [0,3], 'RightBottom', MD_RB_4),
        MD_RB_4
    ),
    expected(
        'matrix_diag (5)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [0,2], 'LeftBottom', MD_RB_5),
        [c,e,g],
        MD_RB_5
    ),
    expected(
        'matrix_diag (6)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [1,2], 'LeftBottom', MD_RB_6),
        [f,h],
        MD_RB_6
    ),
    expected(
        'matrix_diag (7)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [2,2], 'LeftBottom', MD_RB_7),
        [i],
        MD_RB_7
    ),
    expected(
        'matrix_diag (8)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [2,2], 'LeftBottom', MD_RB_8),
        [i],
        MD_RB_8
    ),
    expected(
        'matrix_diag (9)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [2,2], 'LeftTop', MD_RB_9),
        [i,e,a],
        MD_RB_9
    ),
    expected(
        'matrix_diag (10)',
        matrix_diag([[a,b,c], [d,e,f], [g,h,i]], [2,1], 'LeftTop', MD_RB_10),
        [h,d],
        MD_RB_10
    ),
    log('End matrix_diag_tests'),
    !.

matrix_right_same_tests :-
    expected('matrix_right_same (1)', matrix_right_same([[a,b,a]], [0,0], RS_1), [0,2], RS_1),
    expected('matrix_right_same (2)', matrix_right_same([[a,a,a]], [0,0], RS_2), [0,1], RS_2),
    unexpected('matrix_right_same (3)', matrix_right_same([[a,_,a]], [0,0], RS_3), RS_3),
    log('End matrix_right_same tests'), !.

matrix_left_same_tests :-
    expected('matrix_left_same (1)', matrix_left_same([[a,b,a]], [0,2], LS_1), [0,0], LS_1),
    expected('matrix_left_same (2)', matrix_left_same([[a,a,a]], [0,2], LS_2), [0,1], LS_2),
    unexpected('matrix_left_same (3)', matrix_left_same([[a,_,a]], [0,2], LS_3), LS_3),
    unexpected('matrix_left_same (4)', matrix_left_same([[_,_,a]], [0,2], LS_4), LS_4),
    expected('matrix_left_same (5)', matrix_left_same([[_,a,a]], [0,2], LS_5), [0,1], LS_5),
    log('End matrix_left_same tests'), !.

matrix_bottom_same_tests :-
    expected('matrix_bottom_same (1)', matrix_bottom_same([[a],[b],[a]], [0,0], BS_1), [2,0], BS_1),
    expected('matrix_bottom_same (2)', matrix_bottom_same([[a],[a],[a]], [0,0], BS_2), [1,0], BS_2),
    unexpected('matrix_bottom_same (3)', matrix_bottom_same([[a],[_],[a]], [0,0], BS_3), BS_3),
    log('End matrix_bottom_same tests'),  !.

matrix_top_same_tests :-
    expected('matrix_top_same (1)', matrix_top_same([[a],[b],[a]], [2,0], TS_1), [0,0], TS_1),
    expected('matrix_top_same (2)', matrix_top_same([[a],[a],[a]], [2,0], TS_2), [1,0], TS_2),
    unexpected('matrix_top_same (3)', matrix_top_same([[a],[_],[a]], [0,0], TS_3), TS_3),
    log('End matrix_top_same tests'), !.

matrix_left_top_same_tests :-
    expected('matrix_left_top_same (1)', matrix_left_top_same([[w,_,_], [_,b,_], [_,_,w]], [2,2], LTS_1), [0,0], LTS_1),
    expected('matrix_left_top_same (2)', matrix_left_top_same([[w,_,_], [_,w,_], [_,_,w]], [2,2], LTS_2), [1,1], LTS_2),
    unexpected('matrix_left_top_same (3)', matrix_left_top_same([[w,_,_], [_,_,_], [_,_,w]], [2,2], LTS_3), LTS_3),
    log('End matrix_left_top_same tests'),  !.

matrix_left_bottom_same_tests :-
    expected('matrix_left_bottom_same (1)', matrix_left_bottom_same([[_,_,w], [_,b,_], [w,_,_]], [0,2], O1), [2,0], O1),
    expected('matrix_left_bottom_same (2)', matrix_left_bottom_same([[_,_,w], [_,w,_], [w,_,_]], [0,2], O2), [1,1], O2),
    unexpected('matrix_left_bottom_same (3)', matrix_left_bottom_same([[_,_,w], [_,_,_], [w,_,_]], [2,2], O3), O3),
    log('End matrix_left_bottom_same tests'),  !.

matrix_right_top_same_tests :-
    expected('matrix_right_top_same (1)', matrix_right_top_same([[w,_,w], [_,b,_], [w,_,w]], [2,0], RTS_1), [0,2], RTS_1),
    expected('matrix_right_top_same (2)', matrix_right_top_same([[_,_,w], [_,w,_], [w,_,_]], [2,0], RTS_2), [1,1], RTS_2),
    unexpected('matrix_right_top_same (3)', matrix_right_top_same([[_,_,w], [_,_,_], [w,_,_]], [2,0], RTS_3), RTS_3),
    log('End matrix_right_top_same tests'), !.

matrix_right_bottom_same_tests :-
    expected('matrix_right_bottom_same (1)', matrix_right_bottom_same([[w,_,w], [_,b,_], [w,_,w]], [0,0], RTS_1), [2,2], RTS_1),
    expected('matrix_right_bottom_same (2)', matrix_right_bottom_same([[w,_,w], [_,w,_], [w,_,_]], [0,0], RTS_2), [1,1], RTS_2),
    unexpected('matrix_right_bottom_same (3)', matrix_right_bottom_same([[w,_,w], [_,_,_], [w,_,_]], [0,0], RTS_3), RTS_3),
    log('End matrix_right_bottom_same tests'), !.

matrix_dims_tests :-
    expected('matrix_dims (1)', matrix_dims([[a,b,c], [d,e,f]], Dims1), [2,3], Dims1),
    expected('matrix_dims (1)', matrix_dims([[a,b],[c,d],[e,f]], Dims2), [3,2], Dims2),
    log('End matrix_dims tests'), !.