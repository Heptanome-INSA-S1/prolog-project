%IA 2 : joue le coup qui donne le plus de pion à chaque tour.

nextMove(Board,Player,ListMove,MaxCount,Count,BestMove,Move) :-
    Count>MaxCount,
    getBestMove(Board,Player,ListMove,Count,Move).

nextMove(Board,Player,ListMove,MaxCount,Count,BestMove,Move) :-
    Count =< MaxCount,
    getBestMove(Board,Player,ListMove,MaxCount,BestMove).

getBestMove(Board,Player,[],_,_).
getBestMove(Board,Player,[Move|ListMove],MaxCount,BestMove) :- 
    getNumberPawnReturned(Board,Player,Move,Count),
	nextMove(Board,Player,ListMove,MaxCount,Count,BestMove,Move).
    

ia2(Board,Player,BestMove) :-
    MaxCount is 0,
	matrix_get_possibilities(Board, Player,ListMove),
	getBestMove(Board,Player,ListMove,MaxCount,BestMove). 
