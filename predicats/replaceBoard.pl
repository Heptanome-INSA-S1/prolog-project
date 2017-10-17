
%%%% Remove old board/save new on in the knowledge base
replaceBoard(Board,NewBoard) :- retract(board(Board)), assert(board(NewBoard)).