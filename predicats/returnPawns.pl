reversePawn(W, 'B') :- nonvar(W), W == 'W', !.
reversePawn(B, 'W') :- nonvar(B), B == 'B', !.
reversePawn(_, _) :- !.

reversePawns(From, Coordinates, To) :-
    matrix_dims(From, [X,Y]),
    LastX is X - 1,
    LastY is Y - 1,
    findall(
        Pawn,
        (
            between(0, LastX, I),
            between(0, LastY, J),
            matrix_element(From, [I,J], El),
            reversePawn(El, ReverseEl),
            if(member([I,J], Coordinates), ReverseEl, El, Pawn )
        ),
        ListTo
    ),
    list2matrix(ListTo, Y, To).
