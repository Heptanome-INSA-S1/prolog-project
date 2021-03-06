% Matrix librairie

:- ensure_loaded([list]).

mult(A,B, A_times_B) :- A_times_B is A * B.

list2matrix(List, RowSize, Matrix) :-
    length(List, L),
    HowManyRows is L div RowSize,
    length(Matrix, HowManyRows),
    maplist(length_(RowSize), Matrix),
    append(Matrix, List).

matrix2list([], []).
matrix2list([H|T], List) :-
	matrix2list(T, RestList),
	append(H, RestList, List).

% Create a matrix of dims [X,Y] into O_Matrix
createMatrix(I_X, I_Y, Matrix) :- mult(I_X, I_Y, Dim), length(List, Dim), list2matrix(List, I_Y, Matrix ).

% Return the I_RowNum row of the matrix I_Matrix into O_Row
% Parameters :
% 	input: I_Matrix - A matrix
%	input: I_RowNum - The row number (start from 0)
%	output: O_Row - The row at the position I_RowNum (as List).
matrix_row([H|_],0,H) :- !.
matrix_row([_|T], I_RowNum, O_Row) :- 
    I1 is I_RowNum - 1,
    matrix_row(T,I1,O_Row).

% Return the I_ColumnNum row of the matrix I_Matrix into O_Column
% Parameters :
% 	input: I_Matrix - A matrix
%	input: I_ColumnNum - The column number (start from 0)
%	output: O_Column - The colum at the position I_ColumnNum (as List).
matrix_column([], _, []).
matrix_column([CurrentRow|OtherRows], I_ColumnNum, [HeadColumn|TailColumn]) :-
	matrix_row(CurrentRow, I_ColumnNum, HeadColumn),
	matrix_column(OtherRows, I_ColumnNum, TailColumn).

% Return the element as I_Matrix[I_X][I_Y]
% Parameters :
% 	input: I_X - The position in x of the Element
%   input: I_Y - The position in y of the Element
%   output: Element - The element at the position [I_X][I_Y]
matrix_element(I_Matrix, [I_X, I_Y], Element) :- matrix_row(I_Matrix, I_X, Row), indexOf(Row, Element, I_Y), !.

list_elements(I_Liste, I_Element, O_Liste) :-  findall(I,( nth0(I,I_Liste, Element), nonvar(Element), I_Element == Element), O_Liste).

%********************** MATRIX DIAG 'LeftBottom' ************************************************

matrix_diag(I_Matrix, [X,Y], 'LeftBottom', []) :-
    matrix_dims(I_Matrix, [A|_]),
	X >= A,
	Y < 0, !.

matrix_diag(I_Matrix, [X,0], 'LeftBottom', [Element]) :-
	matrix_element(I_Matrix, [X,0], Element), !.

matrix_diag(I_Matrix, [X,Y], 'LeftBottom', [Element]) :-
    matrix_dims(I_Matrix, [A|_]),
    X is A - 1,
	matrix_element(I_Matrix, [X,Y], Element), !.

matrix_diag(I_Matrix, [X,Y], 'LeftBottom', [H|T]) :-
    matrix_element(I_Matrix, [X,Y], H),
    A is X + 1,
    B is Y - 1,
    matrix_diag(I_Matrix, [A,B], 'LeftBottom', T), !.

%********************** MATRIX DIAG 'RightBottom' ************************************************

matrix_diag(I_Matrix, [X,Y], 'RightBottom', []) :-
	matrix_dims(I_Matrix, [A,B]),
	X >= A,
	Y >= B, !.

matrix_diag(I_Matrix, [X,Y], 'RightBottom', [Element]) :-
	matrix_dims(I_Matrix, [A,_]),
	X is A - 1,
	matrix_element(I_Matrix, [X,Y], Element), !.

matrix_diag(I_Matrix, [X,Y], 'RightBottom', [Element]) :-
	matrix_dims(I_Matrix, [_,B]),
	Y is B - 1,
	matrix_element(I_Matrix, [X,Y], Element), !.

matrix_diag(I_Matrix, [X,Y], 'RightBottom', [H|T]) :-
	matrix_element(I_Matrix, [X,Y], H),
	A is X + 1,
	B is Y + 1,
	matrix_diag(I_Matrix, [A,B], 'RightBottom', T).

%********************** MATRIX DIAG 'RightTop' ************************************************

matrix_diag(I_Matrix, [X,Y], 'RightTop', []) :-
	matrix_dims(I_Matrix, [_,B]),
	X < 0 ,
	Y >= B, !.

matrix_diag(I_Matrix, [0,Y], 'RightTop', [Element]) :-
	matrix_element(I_Matrix, [0,Y], Element), !.

matrix_diag(I_Matrix, [X,Y], 'RightTop', [Element]) :-
	matrix_dims(I_Matrix, [_,B]),
	Y is B - 1,
	matrix_element(I_Matrix, [X,Y], Element), !.

matrix_diag(I_Matrix, [X,Y], 'RightTop', [H|T]) :-
	matrix_element(I_Matrix, [X,Y], H),
	A is X - 1,
	B is Y + 1,
	matrix_diag(I_Matrix, [A,B], 'RightTop', T).

%********************** MATRIX DIAG 'LeftTop' ************************************************

matrix_diag(_, [X,Y], 'LeftTop', []) :-
	X < 0,
	Y < 0, !.

matrix_diag(I_Matrix, [0,Y], 'LeftTop', [Element]) :-
	matrix_element(I_Matrix, [0,Y], Element), !.

matrix_diag(I_Matrix, [X,0], 'LeftTop', [Element]) :-
	matrix_element(I_Matrix, [X,0], Element), !.

matrix_diag(I_Matrix, [X,Y], 'LeftTop', [H|T]) :-
	matrix_element(I_Matrix, [X,Y], H),
	A is X - 1,
	B is Y - 1,
	matrix_diag(I_Matrix, [A,B], 'LeftTop', T).

%********************** MATRIX COUNT *********************************************************

matrix_count(I_Matrix, I_Predicate, O_Count) :-
	matrix2list(I_Matrix, List),
	each_count(List, I_Predicate, O_Count).

matrix_any(I_Matrix, I_Predicate) :-
	matrix_count(I_Matrix, I_Predicate, O_Count),
	O_Count =\= 0.

matrix_all(I_Matrix, I_Predicate) :-
	matrix2list(I_Matrix, List),
	length(List, Length),
	each_count(List, I_Predicate, Length).

%===================================== Looking all player's possibilities ============================

% Check a row.

possibilitie_right(I_Row, _,  I_NumRow, I_Start_Index, I_Index, H) :-
	NextIndex is I_Index + 1,
	length(I_Row,L),
	NextIndex < L,
	nth0(NextIndex, I_Row, NextElement),
	var(NextElement),
	I_Index \== I_Start_Index,
	H = [I_NumRow,NextIndex],
	!.

possibilitie_right(I_Row, I_Player, I_NumRow, I_Start_Index, I_Index, O_Possibilitie) :-
	NextIndex is I_Index + 1,
	length(I_Row,L),
	NextIndex < L,
	nth0(NextIndex, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_right(I_Row, I_Player, I_NumRow, I_Start_Index,NextIndex,O_Possibilitie).

possibilitie_left(I_Row, _,  I_NumRow, I_Start_Index, I_Index, H) :-
	NextIndex is I_Index - 1,
	NextIndex >= 0,
	nth0(NextIndex, I_Row, NextElement),
	var(NextElement),
	I_Index \== I_Start_Index,
	H = [I_NumRow,NextIndex],
	!.

possibilitie_left(I_Row, I_Player, I_NumRow, I_Start_Index, I_Index, O_Possibilitie) :-
	NextIndex is I_Index - 1,
	NextIndex >= 0,
	nth0(NextIndex, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_left(I_Row, I_Player, I_NumRow, I_Start_Index,NextIndex,O_Possibilitie).

possibilitie_top(I_Row, _,  I_NumColumn, I_Start_Index, I_Index, H) :-
	NextIndex is I_Index - 1,
	NextIndex >= 0,
	nth0(NextIndex, I_Row, NextElement),
	var(NextElement),
	I_Index \== I_Start_Index,
	H = [NextIndex, I_NumColumn],
	!.

possibilitie_top(I_Row, I_Player, I_NumColumn, I_Start_Index, I_Index, O_Possibilitie) :-
	NextIndex is I_Index - 1,
	NextIndex >= 0,
	nth0(NextIndex, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_top(I_Row, I_Player, I_NumColumn, I_Start_Index,NextIndex,O_Possibilitie).

possibilitie_bottom(I_Row, _,  I_NumColumn, I_Start_Index, I_Index, H) :-
	NextIndex is I_Index + 1,
	length(I_Row,L),
	NextIndex < L,
	nth0(NextIndex, I_Row, NextElement),
	var(NextElement),
	I_Index \== I_Start_Index,
	H = [NextIndex, I_NumColumn],
	!.

possibilitie_bottom(I_Row, I_Player, I_NumColumn, I_Start_Index, I_Index, O_Possibilitie) :-
	NextIndex is I_Index + 1,
	length(I_Row,L),
	NextIndex < L,
	nth0(NextIndex, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_bottom(I_Row, I_Player, I_NumColumn, I_Start_Index,NextIndex,O_Possibilitie).

possibilitie_diag_right_top(I_Row, _,  I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, H) :-
	NextColumn is I_NumColumn + 1,
	NextRow is I_NumRow - 1,
	length(I_Row,C),
	NextColumn < C,
	nth0(NextColumn, I_Row, NextElement),
	var(NextElement),
	I_NumColumn \== I_Start_Column,
	Column is NextColumn + I_ColOffset,
	H = [NextRow, Column],
	!.

possibilitie_diag_right_top(I_Row, I_Player, I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, O_Possibilitie) :-
	NextRow is I_NumRow - 1,
	NextColumn is I_NumColumn + 1,
	length(I_Row,C),
	NextColumn < C,
	nth0(NextColumn, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_diag_right_top(I_Row, I_Player, NextRow, I_ColOffset, I_Start_Column,NextColumn,O_Possibilitie).

possibilitie_diag_right_bottom(I_Row, _,  I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, H) :-
	NextColumn is I_NumColumn + 1,
	NextRow is I_NumRow + 1,
	length(I_Row,C),
	NextColumn < C,
	nth0(NextColumn, I_Row, NextElement),
	var(NextElement),
	I_NumColumn \== I_Start_Column,
	Column is NextColumn + I_ColOffset,
	H = [NextRow, Column],
	!.

possibilitie_diag_right_bottom(I_Row, I_Player, I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, O_Possibilitie) :-
	NextRow is I_NumRow + 1,
	NextColumn is I_NumColumn + 1,
	length(I_Row,C),
	NextColumn < C,
	nth0(NextColumn, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_diag_right_bottom(I_Row, I_Player, NextRow, I_ColOffset, I_Start_Column,NextColumn,O_Possibilitie).

possibilitie_diag_left_top(I_Row, _,  I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, H) :-
	NextColumn is I_NumColumn - 1,
	NextRow is I_NumRow - 1,
	NextColumn >= 0,
	nth0(NextColumn, I_Row, NextElement),
	var(NextElement),
	I_NumColumn \== I_Start_Column,
	Column is NextColumn + I_ColOffset,
	H = [NextRow, Column],
	!.

possibilitie_diag_left_top(I_Row, I_Player, I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, O_Possibilitie) :-
	NextRow is I_NumRow - 1,
	NextColumn is I_NumColumn - 1,
	NextColumn >= 0,
	nth0(NextColumn, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_diag_left_top(I_Row, I_Player, NextRow, I_ColOffset, I_Start_Column,NextColumn,O_Possibilitie).

possibilitie_diag_left_bottom(I_Row, _,  I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, H) :-
	NextColumn is I_NumColumn - 1,
	NextRow is I_NumRow + 1,
	NextColumn >= 0,
	nth0(NextColumn, I_Row, NextElement),
	var(NextElement),
	I_NumColumn \== I_Start_Column,
	Column is NextColumn + I_ColOffset,
	H = [NextRow, Column],
	!.

possibilitie_diag_left_bottom(I_Row, I_Player, I_NumRow, I_ColOffset, I_Start_Column, I_NumColumn, O_Possibilitie) :-
	NextRow is I_NumRow + 1,
	NextColumn is I_NumColumn - 1,
	NextColumn >= 0,
	nth0(NextColumn, I_Row, NextElement),
	nonvar(NextElement),
	I_Player \== NextElement,
	possibilitie_diag_left_bottom(I_Row, I_Player, NextRow, I_ColOffset, I_Start_Column,NextColumn,O_Possibilitie).

% Return the list of possible right actions of the I_Player.

matrix_get_right_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [R,_]),
	MaxRow is R - 1,
	findall(PossibilitiesPerRow,(
		between(0,MaxRow,IndexRow),
		matrix_row(I_Matrix, IndexRow, CurrentRow),
		list_elements(CurrentRow, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(Index, ListPlayer),
			possibilitie_right(CurrentRow, I_Player, IndexRow, Index, Index, Possibilitie)
		), PossibilitiesPerRow)
	), O_Possibilities).

matrix_get_left_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [R,_]),
	MaxRow is R - 1,
	findall(PossibilitiesPerRow,(
		between(0,MaxRow,IndexRow),
		matrix_row(I_Matrix, IndexRow, CurrentRow),
		list_elements(CurrentRow, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(Index, ListPlayer),
			possibilitie_left(CurrentRow, I_Player, IndexRow, Index, Index, Possibilitie)
		), PossibilitiesPerRow)
	), O_Possibilities).

matrix_get_top_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [_, C]),
	MaxCol is C - 1,
	findall(PossibilitiesPerColumn,(
		between(0,MaxCol,IndexColumn),
		matrix_column(I_Matrix, IndexColumn, CurrentColumn),
		list_elements(CurrentColumn, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(Index, ListPlayer),
			possibilitie_top(CurrentColumn, I_Player, IndexColumn, Index, Index, Possibilitie)
		), PossibilitiesPerColumn)
	), O_Possibilities).

matrix_get_bottom_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [_, C]),
	MaxCol is C - 1,
	findall(PossibilitiesPerColumn,(
		between(0,MaxCol,IndexColumn),
		matrix_column(I_Matrix, IndexColumn, CurrentColumn),
		list_elements(CurrentColumn, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(Index, ListPlayer),
			possibilitie_bottom(CurrentColumn, I_Player, IndexColumn, Index, Index, Possibilitie)
		), PossibilitiesPerColumn)
	), O_Possibilities).

matrix_get_diag_right_top_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [R, C]),
	MaxCol is C - 1,
	MaxRow is R - 1,
	findall(PossibilitiesPerColumn,(
		between(0,MaxRow,IndexRow),
		between(0,MaxCol,IndexColumn),
		((IndexColumn == 0, IndexRow \== MaxRow);(IndexRow == MaxRow)),
		matrix_diag(I_Matrix, [IndexRow,IndexColumn], 'RightTop', CurrentDiag),
		list_elements(CurrentDiag, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(IndColumn, ListPlayer),
			IndRow is IndexRow - IndColumn,
			possibilitie_diag_right_top(CurrentDiag, I_Player, IndRow, IndexColumn, IndColumn, IndColumn, Possibilitie)
		), PossibilitiesPerColumn)
	), O_Possibilities).

matrix_get_diag_right_bottom_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [R, C]),
	MaxCol is C - 1,
	MaxRow is R - 1,
	findall(PossibilitiesPerColumn,(
		between(0,MaxRow,IndexRow),
		between(0,MaxCol,IndexColumn),
		((IndexRow == 0, IndexColumn \== 0);(IndexColumn == 0)),
		matrix_diag(I_Matrix, [IndexRow,IndexColumn], 'RightBottom', CurrentDiag),
		list_elements(CurrentDiag, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(IndColumn, ListPlayer),
			IndRow is IndexRow + IndColumn, 
			possibilitie_diag_right_bottom(CurrentDiag, I_Player, IndRow,IndexColumn, IndColumn, IndColumn, Possibilitie)
		), PossibilitiesPerColumn)
	), O_Possibilities).

matrix_get_diag_left_top_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [R, C]),
	MaxCol is C - 1,
	MaxRow is R - 1,
	findall(PossibilitiesPerColumn,(
		between(0,MaxRow,IndexRow),
		between(0,MaxCol,IndexColumn),
		((IndexRow == 0, IndexColumn \== 0);(IndexColumn == 0)),
		matrix_diag(I_Matrix, [IndexRow,IndexColumn], 'RightBottom', CurrentDiag),
		list_elements(CurrentDiag, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(IndColumn, ListPlayer),
			IndRow is IndexRow + IndColumn,
			possibilitie_diag_left_top(CurrentDiag, I_Player, IndRow, IndexColumn, IndColumn, IndColumn, Possibilitie)
		), PossibilitiesPerColumn)
	), O_Possibilities).

matrix_get_diag_left_bottom_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_dims(I_Matrix, [R, C]),
	MaxCol is C - 1,
	MaxRow is R - 1,
	findall(PossibilitiesPerColumn,(
		between(0,MaxRow,IndexRow),
		between(0,MaxCol,IndexColumn),
		((IndexColumn == 0, IndexRow \== MaxRow);(IndexRow == MaxRow)),
		matrix_diag(I_Matrix, [IndexRow,IndexColumn], 'RightTop', CurrentDiag),
		list_elements(CurrentDiag, I_Player, ListPlayer),
		findall(Possibilitie,(
			member(IndColumn, ListPlayer),
			IndRow is IndexRow - IndColumn,
			possibilitie_diag_left_bottom(CurrentDiag, I_Player, IndRow, IndexColumn, IndColumn, IndColumn, Possibilitie)
		), PossibilitiesPerColumn)
	), O_Possibilities).

matrix_get_possibilities(I_Matrix, I_Player, O_Possibilities) :-
	matrix_get_right_possibilities(I_Matrix, I_Player, PossRight),
	matrix_get_left_possibilities(I_Matrix, I_Player, PossLeft),
	matrix_get_top_possibilities(I_Matrix, I_Player, PossTop),
	matrix_get_bottom_possibilities(I_Matrix, I_Player, PossBottom),
	matrix_get_diag_left_top_possibilities(I_Matrix,I_Player, PossDiagLeftTop),
	matrix_get_diag_left_bottom_possibilities(I_Matrix,I_Player, PossDiagLeftBottom),
	matrix_get_diag_right_top_possibilities(I_Matrix,I_Player, PossDiagRightTop),
	matrix_get_diag_right_bottom_possibilities(I_Matrix,I_Player, PossDiagRightBottom),
	append(PossRight, PossLeft, PossRow),
	append(PossTop, PossBottom, PossColumn),
	append(PossDiagLeftTop, PossDiagLeftBottom, PossDiagLeft),
	append(PossDiagRightTop, PossDiagRightBottom, PossDiagRight),
	append(PossRow, PossColumn, PossLine),
	append(PossDiagLeft, PossDiagRight, PossDiag),
	append(PossLine, PossDiag, Possibilities),
	delete(Possibilities, [], PossibilitiesLessVoid),
	matrix2list(PossibilitiesLessVoid, PossibilitiesToList),
	list_to_set(PossibilitiesToList, O_Possibilities).



matrix_right_same(I_Matrix, [I_X, I_Y], [I_X, O_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_row(I_Matrix, I_X, Row),
	indexOf(Row, Element1, O_Y),
	nonvar(Element1), 
	Element0 == Element1,
	O_Y > I_Y,
	msublist(Row, [I_Y, O_Y], Sublist),
	list_all(Sublist, nonvar), !.

matrix_left_same(I_Matrix, [I_X, I_Y], [I_X, O_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element),
	matrix_row(I_Matrix, I_X, Row),
	msublist(Row, [0, I_Y], SubRow),
	lastIndexOf(SubRow, Element, O_Y),
	msublist(Row, [O_Y, I_Y], SubRow2),
	list_all(SubRow2, nonvar), !.

matrix_top_same(I_Matrix, [I_X, I_Y], [O_X, I_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element),
	matrix_column(I_Matrix, I_Y, Column),
	msublist(Column, [0, I_X], SubCol),
	lastIndexOf(SubCol, Element, O_X),
	msublist(SubCol, [O_X, I_X], SubCol2),
	list_all(SubCol2, nonvar), !.

matrix_bottom_same(I_Matrix, [I_X, I_Y], [O_X, I_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_column(I_Matrix, I_Y, Column),
	indexOf(Column, Element1, O_X),
	nonvar(Element1), 
	Element0 == Element1,
	O_X > I_X,
	msublist(Column, [I_X, O_X], Sublist),
	list_all(Sublist, nonvar), !.

matrix_left_bottom_same(I_Matrix, [I_X, I_Y], [O_X, O_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_diag(I_Matrix, [I_X, I_Y], 'LeftBottom', Diag),
	indexOf(Diag, Element1, Offset),
	nonvar(Element1),
	Element0 == Element1,
	Offset > 0,
	msublist(Diag, [0, Offset], Sublist),
	list_all(Sublist, nonvar),
	O_X is Offset + I_X,
    O_Y is I_Y - Offset, !.

matrix_right_bottom_same(I_Matrix, [I_X, I_Y], [O_X, O_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_diag(I_Matrix, [I_X, I_Y], 'RightBottom', Diag),
	indexOf(Diag, Element1, Offset),
	nonvar(Element1),
	Element0 == Element1,
	Offset > 0,
	msublist(Diag, [0, Offset], Sublist),
	list_all(Sublist, nonvar),
	O_X is Offset + I_X,
	O_Y is Offset + I_Y, !.

matrix_left_top_same(I_Matrix, [I_X, I_Y], [O_X, O_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_diag(I_Matrix, [I_X, I_Y], 'LeftTop', Diag),
	indexOf(Diag, Element1, Offset),
	nonvar(Element1),
	Element0 == Element1,
	Offset > 0,
	msublist(Diag, [0, Offset], Sublist),
	list_all(Sublist, nonvar),
	O_X is I_X - Offset,
	O_Y is I_Y - Offset, !.

matrix_right_top_same(I_Matrix, [I_X, I_Y], [O_X, O_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_diag(I_Matrix, [I_X, I_Y], 'RightTop', Diag),
	indexOf(Diag, Element1, Offset),
	nonvar(Element1),
	Element0 == Element1,
	Offset > 0,
	msublist(Diag, [0, Offset], Sublist),
	list_all(Sublist, nonvar),
	O_X is I_X - Offset,
	O_Y is I_Y + Offset, !.


%--------------------------------- matrix_dims --------------------------------------------------
% matrix_dims(I_Matrix, [X,Y]).
% matrix_dims([[1,2,3], [4,5,6]], Dims).
% Dims = [2,3].

matrix_dims(I_Matrix, [X,Y]) :-
	matrix_row(I_Matrix, 0, Row),
	matrix_column(I_Matrix, 0, Column),
	length(Row, Y),
	length(Column, X).

matrix_display([Row], X) :-
    write(X), write(' |'),
    list_display(Row),
    write('|'),
    nl.

matrix_display([Row|Tail], X) :-
    write(X), write(' |'),
    list_display(Row),
    write('|'),
    nl,
    NewX is X + 1,
    matrix_display(Tail, NewX).

matrix_each_coordinates(Matrix, Coordinates) :-
    matrix_dims(Matrix, [Row, Cols]),
    LastX is Row - 1,
    LastY is Cols - 1,
    findall([X,Y], (between(0, LastX, X), between(0, LastY, Y)), Coordinates).

