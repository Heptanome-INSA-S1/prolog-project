% We import all files needed
:- ensure_loaded([predicats/matrix, predicats/play]).

% We declare a dynamic variable wich will represent the board of the game
:- dynamic board/1.

% We initialize the start of the game.
init :- createMatrix(10, 10, Board), assert(board(Board)), play('B').
