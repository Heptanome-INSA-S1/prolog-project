:- ensure_loaded(isBoardFull).

canNotPlay(Board, _) :- isBoardFull(Board).
canNotPlay(Board, Player) :- matrix_get_possibilities(Board, Player, Liste), length(Liste, L), L == 0.