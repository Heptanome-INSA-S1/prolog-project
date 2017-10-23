% We import all files needed
:- ensure_loaded([
    predicats/for,
    predicats/list,
    predicats/matrix,
    predicats/canNotPlay,
    predicats/changePlayer,
    predicats/countPawn,
    predicats/findIndexTransformation,
    predicats/displayBoard,
    predicats/gameover,
    predicats/getNumberPawnReturned,
    predicats/ia,
    predicats/ia2,
    predicats/ia3,
    predicats/isBoardFull,
    predicats/isValidAction,
    predicats/play,
    predicats/playMove,
    predicats/printVal,
    predicats/replaceBoard,
    predicats/returnPawns,
    predicats/if
    ]).

% We declare a dynamic variable wich will represent the board of the game
:- dynamic board/1.

wait :- get_single_char(_).

% We initialize the start of the game.
init :-
    createMatrix(6, 6, Matrix),
    playMove(Matrix, 'B', [2,2], MA),
    playMove(MA, 'B', [3,3], MB),
    playMove(MB, 'W', [2,3], MC),
    playMove(MC, 'W', [3,2], Board),
    assert(board(Board)),
    play('B').
