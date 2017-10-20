

Pawn(Board, Index) :- nth0(Index, Board, Elem), nonvar(Elem). 

getPawns(Board,Player,Pawns) :- 


nearPawn(Board,Index,Color) :-
	nth0(Index, Board, Elem),
	var(Elem),
	(nth0(Index2, Board, Elem2),
	Elem2==Color,
	(Index2 is Index+1; Index2 is index-1; Index2 is index+7; Index2 is index+8; Index2 is index+9; Index2 is index-7; Index2 is index-8; Index2 is index-9 )).

ia(Board,Player1,Player2,Move) :- repeat, Move is random(36), nearPawn(Board,Move,Player2), var(Move), !. %pas encore finit