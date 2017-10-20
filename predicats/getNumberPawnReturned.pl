get_or_zero(Predicate, Z, Z) :-
    Predicate.
get_or_zero(_, _, 0).

getNumberPawnReturned(CurentBoard, Player, [X_Move,  Y_Move],Count) :-
    playMove(CurentBoard, Player, [X_Move, Y_Move],Board),
    get_or_zero(matrix_right_same(Board, [X_Move, Y_Move], [_, YRight]), YRight - Y_Move - 1, Res1),
%    write('Res1: '), writeln(Res1),
    get_or_zero(matrix_left_same(Board, [X_Move,  Y_Move], [_,YLeft]), Y_Move - YLeft - 1, Res2),
%    write('Res2: '), writeln(Res2),
    get_or_zero(matrix_top_same(Board, [X_Move,  Y_Move], [XTop,_]), X_Move - XTop - 1, Res3),
%    write('Res3: '), writeln(Res3),
    get_or_zero(matrix_bottom_same(Board,[X_Move,  Y_Move],[XBottom,_]), XBottom - X_Move - 1, Res4),
%    write('Res4: '), writeln(Res4),
    
    %pas besoin des 2 coordonnées on reste sur le Y
    get_or_zero(matrix_left_top_same(Board,[X_Move,  Y_Move],[_,YLeftTop]), Y_Move - YLeftTop - 1, Res5),
%    write('Res5: '), writeln(Res5),
    get_or_zero(matrix_left_bottom_same(Board,[X_Move,  Y_Move],[_,YLeftBottom]), Y_Move - YLeftBottom - 1, Res6),
%    write('Res6: '), writeln(Res6),
    get_or_zero(matrix_right_top_same(Board,[X_Move,  Y_Move],[_,YRightTop]), YRightTop - Y_Move - 1, Res7),
%    write('Res7: '), writeln(Res7),
    get_or_zero(matrix_right_bottom_same(Board,[X_Move,  Y_Move],[_,YRightBottom]), YRightBottom - Y_Move - 1, Res8),
%    write('Res8: '), writeln(Res8),
    
    Count is Res1 + Res2 + Res3 + Res4 + Res5 + Res6 + Res7 + Res8, !.
