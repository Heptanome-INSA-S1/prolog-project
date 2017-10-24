%	IA 3 : joue le coup qui maximise 
%	( nombre de pion gagné - nombre de pion perdu au prochain coup de l'IA
%		( si  l'IA adverse joue le coup qui donne lui donne le plus de pion )
%	)

:- ensure_loaded([matrix,getNumberPawnReturned]).


get_max_first_player(Board, Player,[I], MaxCount, I) :-
    getNumberPawnReturned(Board, Player, I, MaxCount).


get_max_first_player(Board, Player,[I|T], MaxCount, BestMove) :-
    getNumberPawnReturned(Board, Player, I, MaxHead),
    change_player_and_get_max_second_player(Board, Player, I, BCount),
    get_max(Board, Player, T, MaxTail, MoveTail),
    if(MaxHead - BCount > MaxTail, MaxHead - BCount, MaxTail, MaxCount),
    if(MaxHead - BCount > MaxTail, I, MoveTail, BestMove).

    
get_max_second_player(Board, Player,[I], MaxCount, I) :-
    getNumberPawnReturned(Board, Player, I, MaxCount).

get_max_second_player(Board, Player,[I|T], MaxCount, BestMove) :-
    getNumberPawnReturned(Board, Player, I, MaxHead),
    get_max(Board, Player, T, MaxTail, MoveTail),
    if(MaxHead > MaxTail, MaxHead, MaxTail, MaxCount),
    if(MaxHead > MaxTail, I, MoveTail, BestMove).
	
change_player_and_get_max_second_player(Board,Player,Move,MaxCount) :-
	changePlayer(Player,NextPlayer),
	copy_term(Board,PlayedBoard),
	matrix_element(PlayedBoard,Move,Player),
	findIndexTransformation(PlayedBoard, Move, Indices),
	reversePawns(PlayedBoard, Indices, NewBoard),
    matrix_get_possibilities(NewBoard,NextPlayer,ListSecondMove),
	get_max_second_player(NewBoard,NextPlayer,ListSecondMove,MaxCount,_).
	
	
ia3(Board,Player,BestMove) :-
	matrix_get_possibilities(Board, Player,ListMove),
	get_max_first_player(Board,Player,ListMove,_,BestMove).
