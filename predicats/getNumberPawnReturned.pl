:- ensure_loaded(matrix).

get_or_zero(Predicate, Z, Z) :-
    Predicate.
get_or_zero(_, _, 0).

getNumberPawnReturned(Board,Player,[X_Move,  Y_Move],Count) :- 
    get_or_zero(matrix_right_same(Board, Player, [X_Move, Y_Move], [_, YRight]), YRight-YMove, Res1),
    get_or_zero(matrix_left_same(Board,[X_Move,  Y_Move],[_,YLeft]), Y_Move-YLeft, Res2),
    get_or_zero(matrix_top_same(Board,[X_Move,  Y_Move],[XTop,_]), XTop-X_Move, Res3),
    get_or_zero(matrix_bottom_same(Board,[X_Move,  Y_Move],[XBottom,_]), X_Move-XBottom, Res4),
    
    %pas besoin des 2 coordonnées on reste sur le Y
    get_or_zero(matrix_left_top_same(Board,[X_Move,  Y_Move],[_,YLeftTop]), Y_Move-YLeftTop, Res5),
    get_or_zero(matrix_left_bottom_same(Board,[X_Move,  Y_Move],[_,YLeftBottom]), Y_Move-YLeftBottom, Res6),
    get_or_zero(matrix_right_top_same(Board,[X_Move,  Y_Move],[_,YRightTop]), YRightTop-Y_Move, Res7),
    get_or_zero(matrix_right_bottom_same(Board,[X_Move,  Y_Move],[_,YRightBottom]), YRightBottom-Y_Move, Res8),
    
    Count is Res1 + Res2 + Res3 + Res4 + Res5 + Res6 + Res7 + Res8.
