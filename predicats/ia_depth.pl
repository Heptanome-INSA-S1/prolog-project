get_max_first_player(Board, Player,[I], MaxCount, I) :-
    getNumberPawnReturned(Board, Player, I, MaxWon),
    get_max_second_player(I, Board, Player, _, MaxLoose),
    MaxCount is MaxWon - MaxLoose.

get_max_first_player(Board, Player,[I|T], MaxCount, BestMove) :-
    getNumberPawnReturned(Board, Player, I, MaxHead),
    get_max_second_player(I, Board, Player, _, MaxLoose),
    get_max(Board, Player, T, MaxTail, MoveTail),
    if(MaxHead - MaxLoose > MaxTail  , MaxHead - MaxLoose, MaxTail,  MaxCount),
    if(MaxHead - MaxLoose   > MaxTail,                  I, MoveTail, BestMove).

get_max_second_player(CurrentMove, Board, Player, BestCounter, MaxCount) :-
    simulateMove(Board, Player, CurrentMove, NextRoundBoard),
    canPlay(NextRoundBoard, NextPlayer),
    ia_random(NextRoundBoard, NextPlayer, BestCounter),
    getNumberPawnReturned(NextRoundBoard, NextPlayer, BestCounter, MaxCount).

% Adversary ai cannot play
get_max_second_player(_, _, _, [], 0).

ia_depth(Board, Player, BestMove, 0) :-
    ia_minx_max(Board, Player, BestMove).


ia_depth(Board,Player,BestMove, Depth) :-
	matrix_get_possibilities(Board, Player,ListMove),
	get_max_first_player(Board,Player,ListMove,_,BestMove).
