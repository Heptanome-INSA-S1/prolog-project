simulateMove(Board, Player, Move, NextRoundBoard) :-
    copy_term(Board, NewBoard),
    matrix_element(NewBoard, Move, Player),
    findIndexTransformation(NewBoard, Move, Indicies),
    reversePawns(NewBoard, Indicies, NextRoundBoard).