:- ensure_loaded([matrix, list]).

take(N, List, Front):- length(Front, N), append(Front, _, List).

%Right 
findIndexTransformationOnRight(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_right_same(I_Board, [I_X, I_Y], [I_X, O_Y]), StartIndex is I_Y + 1, EndIndex is O_Y - 1,
	findall([I_X,Y],(between(StartIndex,EndIndex,Y)),O_ListIndex).

%Left
findIndexTransformationOnLeft(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_left_same(I_Board, [I_X, I_Y], [I_X, O_Y]), StartIndex is O_Y + 1 , EndIndex is I_Y - 1,
	findall([I_X,Y],(between(StartIndex,EndIndex,Y)),O_ListIndex).

%Top
findIndexTransformationOnTop(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_top_same(I_Board, [I_X, I_Y], [O_X, I_Y]), StartIndex is O_X + 1, EndIndex is I_X - 1,
	findall([X,I_Y],(between(StartIndex,EndIndex,X)),O_ListIndex).

%Bottom
findIndexTransformationOnBottom(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_bottom_same(I_Board, [I_X, I_Y], [O_X, I_Y]),
	StartIndex is I_X + 1,
	EndIndex is O_X - 1,
	findall([X,I_Y],(between(StartIndex,EndIndex,X)),O_ListIndex).

% LeftBottom
findIndexTransformationOnLeftBottom(I_Board, [I_X, I_Y], O_ListIndex) :-
    matrix_left_bottom_same(I_Board, [I_X, I_Y], [OtherX, _]),
    Length is OtherX - I_X - 1,
    findall([X,Y],(between(1, Length, Offset), X is I_X + Offset, Y is I_Y - Offset), O_ListIndex).

% LeftTop
findIndexTransformationOnLeftTop(I_Board, [I_X, I_Y], O_ListIndex) :-
    matrix_left_top_same(I_Board, [I_X, I_Y], [OtherX, OtherY]),
    Length is I_X - OtherX - 1,
    findall([X,Y],(between(1, Length, Offset), X is OtherX + Offset, Y is OtherY + Offset), O_ListIndex).

% RightBottom
findIndexTransformationOnRightBottom(I_Board, [I_X, I_Y], O_ListIndex) :-
    matrix_right_bottom_same(I_Board, [I_X, I_Y], [OtherX, _]),
    Length is OtherX - I_X - 1,
    findall([X,Y],(between(1, Length, Offset), X is I_X + Offset, Y is I_Y + Offset), O_ListIndex).

% RightTop
findIndexTransformationOnRightTop(I_Board, [I_X, I_Y], O_ListIndex) :-
    matrix_right_top_same(I_Board, [I_X, I_Y], [OtherX, _]),
    Length is I_X - OtherX - 1,
    findall([X,Y],(between(1, Length, Offset), X is I_X - Offset, Y is I_Y + Offset), O_ListIndex).

findIndexTransformation(I_Board, [I_X, I_Y], O_ListIndex) :-
    if( findIndexTransformationOnRight(I_Board, [I_X,I_Y], ResA), ResA, [], IndiciesOnRight),
    if( findIndexTransformationOnLeft(I_Board, [I_X,I_Y], ResB), ResB, [], IndiciesOnLeft),
    if( findIndexTransformationOnTop(I_Board, [I_X,I_Y], ResC), ResC, [], IndiciesOnTop),
    if( findIndexTransformationOnBottom(I_Board, [I_X,I_Y], ResD), ResD, [], IndiciesOnBottom),
    if( findIndexTransformationOnLeftBottom(I_Board, [I_X,I_Y], ResE), ResE, [], IndiciesOnLeftBottom),
    if( findIndexTransformationOnLeftTop(I_Board, [I_X,I_Y], ResF), ResF, [], IndiciesOnLeftTop),
    if( findIndexTransformationOnRightBottom(I_Board, [I_X,I_Y], ResG), ResG, [], IndiciesOnRightBottom),
    if( findIndexTransformationOnRightTop(I_Board, [I_X,I_Y], ResH), ResH, [], IndiciesOnRightTop),

     append(IndiciesOnRight, [], TempA),
     append(IndiciesOnLeft, TempA, TempB),
     append(IndiciesOnTop, TempB, TempC),
     append(IndiciesOnBottom, TempC, TempD),
     append(IndiciesOnLeftBottom, TempD, TempE),
     append(IndiciesOnLeftTop, TempE, TempF),
     append(IndiciesOnRightBottom, TempF, TempG),
     append(IndiciesOnRightTop, TempG, O_ListIndex),
     !.



