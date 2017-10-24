getBestMove(Board, Player, MovaA, MoveB, BestMove) :-
    getNumberPawnReturned(Board, Player, MoveA, CountA),
    getNumberPawnReturned(Board, Player, MoveB, CountB),
    if(CountA > CountB, MoveA, MoveB, BestMove).