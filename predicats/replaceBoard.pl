% We remove the old board from the knoledge base and we save the new one.
replaceBoard(Board,NewBoard) :- retract(board(Board)), assert(board(NewBoard)).