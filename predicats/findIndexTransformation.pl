:- ensure_loaded([matrix]).
:- ensure_loaded(list).

take(N, List, Front):- length(Front, N), append(Front, _, List).

%Right 
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_right_same(I_Board, [I_X, I_Y], [I_X, O_Y]), StartIndex is I_Y+1, EndIndex is O_Y-1,
	findall([I_X,Y],(between(StartIndex,EndIndex,Y)),O_ListIndex).

%Left
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_left_same(I_Board, [I_X, I_Y], [I_X, O_Y]), StartIndex is O_Y+1 , EndIndex is I_Y-1,
	findall([I_X,Y],(between(StartIndex,EndIndex,Y)),O_ListIndex).

%Top
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_top_same(I_Board, [I_X, I_Y], [O_X, I_Y]), StartIndex is O_X+1, EndIndex is I_X-1,
	findall([X,I_Y],(between(StartIndex,EndIndex,X)),O_ListIndex).

%Bottom
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_bottom_same(I_Board, [I_X, I_Y], [O_X, I_Y]), StartIndex is I_X+1, EndIndex is O_X-1,
	findall([X,I_Y],(between(StartIndex,EndIndex,X)),O_ListIndex).

%Left bottom
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_left_bottom_same(I_Board, [I_X, I_Y], [O_X, O_Y]),
	StartX is I_X+1,
	StartY is O_Y+1,
	EndX is O_X-1,
	EndY is I_Y-1,
	matrix_diag(I_Board, [I_X,I_Y], 'LeftBottom', O_R),
	msublist(O_R,[StartX, O_X], O_ListIndex)
	.

%RightBottom
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_right_bottom_same(I_Board, [I_X, I_Y], [O_X, O_Y]),
	StartX is I_X+1,
	StartY is I_Y+1,
	EndX is O_X-1,
	EndY is O_Y-1,
	matrix_diag(I_Board, [I_X,I_Y], 'RightBottom', O_R),
	msublist(O_R,[StartX, O_X], O_ListIndex)
	.

%RightTop
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_right_top_same(I_Board, [I_X, I_Y], [O_X, O_Y]),
	Start is O_X+1,
	matrix_diag(I_Board, [I_X,I_Y], 'RightTop', O_R),
	msublist(O_R,[Start, I_X], O_ListIndex)
	.

%LeftTop
findIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex):-
	matrix_left_top_same(I_Board, [I_X, I_Y], [O_X, O_Y]),
	Start is O_X+1,write(Start),
	matrix_diag(I_Board, [I_X,I_Y], 'LeftTop', O_R),
	msublist(O_R,[Start, I_X], O_ListIndex)
	.