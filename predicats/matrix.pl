% Matrix librairie

even(Number) :- Number mod 2 =:= 0.

append([], List, List).
append([Head|Tail], List, [Head|TailConcat]):-append(Tail, List, TailConcat).

mult(A,B, A_times_B) :- A_times_B is A * B.

length_(Length, List) :- length(List, Length).

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

indexOf([Element|_], Element, 0). % We found the element
indexOf([_|Tail], Element, Index):-
  indexOf(Tail, Element, Index1), % Check in the tail of the list
  Index is Index1 + 1.

each([H], Function) :- 
	call(Function, H).

each([X|T], Function) :- 
	call(Function, X),
	each(T, Function), !.

each_count([], _, 0).
each_count([H|T], Predicate, Count) :-  
	call(Predicate, H),
	each_count(T, Predicate, CountMinus1),
	Count is CountMinus1 + 1, !.
each_count([_|T], Predicate, Count) :- 
	each_count(T, Predicate, Count).


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

% Looking all player's possibilities

%possibilitie_right(_, Index, Index) :- 
%possibilitie_right(I_Row, I_Index, O_Possibilitie) :-


% Return the liste of possible actions of the I_Player.
%matrix_get_possibilities(I_Matrix, I_Player, O_ListPossibilities) :-


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
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_row(I_Matrix, I_X, Row),
	indexOf(Row, Element1, O_Y),
	nonvar(Element1), 
	Element0 == Element1,
	O_Y < I_Y,
	msublist(Row, [O_Y, I_Y], Sublist),
	list_all(Sublist, nonvar), !.

matrix_top_same(I_Matrix, [I_X, I_Y], [O_X, I_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_column(I_Matrix, I_Y, Column),
	indexOf(Column, Element1, O_X),
	nonvar(Element1), 
	Element0 == Element1,
	O_X < I_X,
	msublist(Column, [O_X, I_X], Sublist),
	list_all(Sublist, nonvar), !.

matrix_bottom_same(I_Matrix, [I_X, I_Y], [O_X, I_Y]) :-
	matrix_element(I_Matrix, [I_X, I_Y], Element0),
	matrix_column(I_Matrix, I_Y, Column),
	indexOf(Column, Element1, O_X),
	nonvar(Element1), 
	Element0 == Element1,
	O_X > I_X,
	msublist(Column, [I_X, O_X], Sublist),
	list_all(Sublist, nonvar), !.

matrix_dims(I_Matrix, [X,Y]) :-
	matrix_row(I_Matrix, 0, Row),
	matrix_column(I_Matrix, 0, Column),
	length(Row, Y),
	length(Column, X).

list_all(List, Predicate) :-
	length(List, Length),
	each_count(List, Predicate, Length).

msublist(List, [Start, End], Sublist):-
  length(Prefix, Start),
  append(Prefix, Rest, List),
  Start =< End,
  Length is End - Start,
  length(Sublist, Length),
  append(Sublist, _, Rest).
