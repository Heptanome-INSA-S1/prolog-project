findIndexTransformation_tests :-


    % Same row right
    expected('findIndexTransformation (1)', findIndexTransformationOnRight([['W', 'B', 'B','W']], [0,0], O), [[0,1], [0,2]], O),
    expected('findIndexTransformation (2)', findIndexTransformationOnRight([['W', 'B', 'W','W']], [0,0], O2), [[0,1]], O2),
    unexpected('findIndexTransformation (3)', findIndexTransformationOnRight([['W', _, 'W','W']], [0,0], O3), O3),
    unexpected('findIndexTransformation (4)', findIndexTransformationOnRight([[_, 'W', 'B',_]], [0,1], O4), O4),

    % Same row left
    expected('findIndexTransformation (5)', findIndexTransformationOnLeft([['W', 'B', 'B','W']], [0,3], O5), [[0,1], [0,2]], O5),
    expected('findIndexTransformation (6)', findIndexTransformationOnLeft([['W', 'W', 'B','W']], [0,3], O6), [[0,2]], O6),
    unexpected('findIndexTransformation (7)', findIndexTransformationOnLeft([['W', _, 'W','W']], [0,0], O7), O7),
    unexpected('findIndexTransformation (8)', findIndexTransformationOnLeft([[_, 'W', 'B',_]], [0,1], O8), O8),

    % Same column bottom
    expected('findIndexTransformation (9)', findIndexTransformationOnBottom([['W'], ['B'], ['B'],['W']], [0,0], O9), [[1,0],[2,0]], O9),
    expected('findIndexTransformation (10)', findIndexTransformationOnBottom([['W'], ['W'], ['B'],['W']], [1,0], O10), [[2,0]], O10),
    unexpected('findIndexTransformation (11)', findIndexTransformationOnBottom([['W'], [_], ['B'],['W']], [0,0], O11), O11),
    expected('findIndexTransformation (12)', findIndexTransformationOnBottom([['W'], ['W'], ['B'],['W']], [0,0], O12), [], O12),

    % Same column top
    expected('findIndexTransformation (13)', findIndexTransformationOnTop([['W'], ['B'], ['B'],['W']], [3,0], O13), [[1,0],[2,0]], O13),
    expected('findIndexTransformation (14)', findIndexTransformationOnTop([['W'], ['W'], ['B'],['W']], [3,0], O14), [[2,0]], O14),
    unexpected('findIndexTransformation (15)', findIndexTransformationOnTop([['W'], ['W'], [_],['W']], [3,0], O15), O15),
    expected('findIndexTransformation (16)', findIndexTransformationOnTop([['W'], ['B'], ['W'],['W']], [3,0], O16), [], O16),

    % Same left bottom
    expected(
        'findIndexTransformation (17)',
        findIndexTransformationOnLeftBottom(
        [ [_,_,'W'],
          [_,'B',_],
          ['W',_,_] ], [0,2], O17
        ),
        [[1,1]],
        O17
    ),
    expected(
        'findIndexTransformation (18)',
        findIndexTransformationOnLeftBottom(
        [ [_,_,_,'W'],
          [_,_,'B',_],
          [_,'W',_,_],
          ['W',_,_,_] ], [0,3], O18
        ),
        [[1,2]],
        O18
    ),
    expected(
        'findIndexTransformation (19)',
        findIndexTransformationOnLeftBottom(
        [ [_,_,_,'W'],
          [_,_,'B',_],
          [_,'B',_,_],
          ['W',_,_,_] ], [0,3], O19
        ),
        [[1,2], [2,1]],
        O19
    ),
    expected(
        'findIndexTransformation (20)',
        findIndexTransformationOnLeftBottom(
        [ [_,_,_,'W'],
          [_,_,'W',_],
          [_,'B',_,_],
          ['W',_,_,_] ], [0,3], O20
        ),
        [],
        O20
    ),
    unexpected(
        'findIndexTransformation (21)',
        findIndexTransformationOnLeftBottom(
        [ [_,_,_,'W'],
          [_,_,_,_],
          [_,'B',_,_],
          ['W',_,_,_] ], [0,3], O21
        ),
        O21
    ),

    % Matrix left top

    expected(
        'findIndexTransformation (22)',
        findIndexTransformationOnLeftTop(
        [ ['W',_,_,_],
          [_,'B',_,_],
          [_,_,'B',_],
          [_,_,_,'W'] ], [3,3], O22
        ),
        [[1,1], [2,2]],
        O22
    ),
    expected(
        'findIndexTransformation (23)',
        findIndexTransformationOnLeftTop(
        [ ['W','W',_,_],
          [_,'B','B',_],
          [_,_,'B','W'],
          [_,_,_,'W'] ], [2,3], O23
        ),
        [[1,2]],
        O23
    ),
    unexpected(
        'findIndexTransformation (24)',
        findIndexTransformationOnLeftTop(
        [ ['W','W',_,_],
          [_,'B',_,_],
          [_,_,'B','W'],
          [_,_,_,'W'] ], [2,3], O24
        ),
        O24
    ),

    % Matrix right bottom

    expected(
        'findIndexTransformation (25)',
        findIndexTransformationOnRightBottom(
        [ ['W','W',_,_],
          [_,'B',_,_],
          [_,_,'B','W'],
          [_,_,_,'W'] ], [0,0], O25
        ),
        [[1,1], [2,2]],
        O25
    ),
    expected(
        'findIndexTransformation (26)',
        findIndexTransformationOnRightBottom(
        [ ['W','W',_,_],
          [_,'B','B',_],
          [_,_,'B','W'],
          [_,_,_,'W'] ], [0,1], O26
        ),
        [[1,2]],
        O26
    ),
    unexpected(
        'findIndexTransformation (27)',
        findIndexTransformationOnRightBottom(
        [ ['W','W',_,_],
          [_,'B',_,_],
          [_,_,'B','W'],
          [_,_,_,'W'] ], [0,1], O27
        ),
        O27
    ),

    % Matrix right top
    expected(
        'findIndexTransformation (28)',
        findIndexTransformationOnRightTop(
        [ ['W','W',_,'W'],
          [_,'B','B',_],
          [_,'B','B','W'],
          ['W',_,_,'W'] ], [3,0], O28
        ),
        [[2,1], [1,2]],
        O28
    ),
    expected(
        'findIndexTransformation (29)',
        findIndexTransformationOnRightTop(
        [ ['W','W', 'W' ,'W'],
          [ _ ,'B','B', _ ],
          ['W','B','B','W'],
          ['W', _ , _ ,'W'] ], [2,0], O29
        ),
        [[1,1]],
        O29
    ),

    unexpected(
        'findIndexTransformation (30)',
        findIndexTransformationOnRightTop(
        [ ['W','W', 'W' ,'W'],
          [ _ , _ ,'B', _ ],
          ['W','B','B','W'],
          ['W', _ , _ ,'W'] ], [2,0], O30
        ),
        O30
    ),

    % findIndexTransformation
    expected(
        'findIndexTransformation (31)',
        findIndexTransformation(
                [ ['W','B','B','W'],
                  ['B','B','B',_],
                  ['B',_,'B','W'],
                  ['W',_,_,'W'] ], [0,0], O31
                ),
        [[1, 1], [2, 2], [1, 0], [2, 0], [0, 1], [0, 2]],
        O31
    ),
    expected(
        'findIndexTransformation (32)',
        findIndexTransformation(
                [ [ _ , _ , _ , _ , _ , _ ],
                  [ _ , _ , _ ,'B', _ , _ ],
                  [ _ ,'B', _ ,'W', _ ,'B'],
                  [ _ , _ ,'W','W', _ , _ ],
                  ['B','W','W','B', _ ,'B'],
                  [ _ , _ , _ , _ , _ , _ ] ], [4,3], O32
                ),
        [[1, 1], [2, 2], [1, 0], [2, 0], [0, 1], [0, 2]],
        O32
    ),


    log('End findIndexTransformation_tests'),
    !.