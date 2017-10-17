:- ensure_loaded(predicats).

:- dynamic board/1.

init :- createMatrix(10, 10, Board), assert(board(Board)), play('B').
