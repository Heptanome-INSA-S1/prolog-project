isWhite(X) :- nonvar(X),X == 'W'.
isBlack(X) :- nonvar(X),X == 'B'.

countPawn(Board, WhiteCount, BlackCount) :- 
    matrix_count(Board, isBlack, BlackCount),
    matrix_count(Board, isWhite, WhiteCount).
