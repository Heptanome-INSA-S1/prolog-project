playMove(Board,Player,Move,NewBoard) :- Board=NewBoard,  nth0(Move,NewBoard,Player).
