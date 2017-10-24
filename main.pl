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
    predicats/ia_random,
    predicats/ia_greedy,
    predicats/ia_min_max,
    predicats/simulate_move,
    predicats/ia_depth,
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

debug(false).

wait :- debug(X), X, get_single_char(_), !.
wait.

% We initialize the start of the game.
init :-
    createMatrix(6, 6, Matrix),
    playMove(Matrix, 'B', [2,2], MA),
    playMove(MA, 'B', [3,3], MB),
    playMove(MB, 'W', [2,3], MC),
    playMove(MC, 'W', [3,2], Board),
    assert(board(Board)),
    play('B').

getMove(Board, 'W', Move) :-
    ia_random(Board, 'W', Move), wait.

getMove(Board, 'B', Move) :-
    ia_min_max(Board, 'B', Move), wait.