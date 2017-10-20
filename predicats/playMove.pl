playMove(Board, Player, Move, NewBoard) :-
    Board = NewBoard,
    matrix_element(NewBoard, Move, Player).
