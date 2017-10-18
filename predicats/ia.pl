

nearPawn(Board,index,color) :-
	nth0(index, Board, Elem),
	(nth0(index2, Board, Elem2), Elem2==color, (index2 is index+1; index2 is index-1; index2 is index+7; index2 is index+8; index2 is index+9;index2 is index-7; index2 is index-8; index2 is index-9 ).

ia(Board,Player,Move) :- repeat, Move is random(64), nearPawn(Board,Move,'Noir'), var(Move), !.