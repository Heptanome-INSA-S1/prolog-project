%IA 2 : joue le coup qui donne le plus de pion à chaque tour.

get_max(Board, Player,[I], MaxCount, I) :-
    getNumberPawnReturned(Board, Player, I, MaxCount).


get_max(Board, Player,[I|T], MaxCount, BestMove) :-
    getNumberPawnReturned(Board, Player, I, MaxHead),
    get_max(Board, Player, T, MaxTail, MoveTail),
    if(MaxHead > MaxTail, MaxHead, MaxTail, MaxCount),
    if(MaxHead > MaxTail, I, MoveTail, BestMove).
    

ia_greedy(Board,Player,BestMove) :-
	matrix_get_possibilities(Board, Player,ListMove),
	get_max(Board,Player,ListMove,MaxCount,BestMove).
