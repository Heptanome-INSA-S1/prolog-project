list_tests :-
    % msublist
    expected('Sublist1', msublist([a,b,c,d], [0,2], Res1), [a,b], Res1),
    expected('Sublist2', msublist([a,b,c,d], [0,1], Res2), [a], Res2),
    expected('Sublist3', msublist([a,b,c,d], [1,2], Res1_2), [b], Res1_2),
    % unexpected('Sublist3', msublist([], [0,0], O), O),
    % lastIndexOf
    expected('lastIndexOf (1)', lastIndexOf([a,b,c,d,a,e], a, Res4), 4, Res4),
    expected('lastIndexOf (2)', lastIndexOf([a,b,c,d,_,e], a, Res5), 0, Res5),
    unexpected('lastIndexOf (3)', lastIndexOf([a,b,c,d,_,e], z, Res6), Res6),
    % indexOf
    expected('indexOf (1)', indexOf([a,b,a,c], a, Res7), 0, Res7),
    expected('indexOf (2)', indexOf([a,b,a,c], b, Res8), 1, Res8),
    unexpected('indexOf (3)', indexOf([], b, Any1), Any1),
    unexpected('indexOf (4)', indexOf([a,c,d], b, Any2), Any2),
    % not_in
    mustBeTrue('not_in (1)', not_in([a,b,c], d), '"d" is not in [a,b,c]'),
    mustBeTrue('not_in (2)', not_in([], _), 'nothing is in []'),
    mustBeFalse('not_in (3)', not_in([a,b,c,d], a), '"a" is in [a,b,c,d]'),
    % list_all
    mustBeTrue('list_all (1)', list_all([2,4,6,8], even), '2,4,6,8 are all even'),
    mustBeTrue('list_all (2)', list_all([], even), '"" are all even'),
    mustBeFalse('list_all (3)', list_all([2,5,6,8], even), '"5" is not even'),
    % append
    expected('append (1)', append([], [], Res9), [], Res9),
    expected('append (2)', append([a], [], Res10), [a], Res10),
    expected('append (3)', append([], [a], Res11), [a], Res11),
    expected('append (3)', append([c], [a,b], Res12), [c,a,b], Res12),

    !.