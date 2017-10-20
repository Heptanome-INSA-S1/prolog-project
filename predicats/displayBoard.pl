%%%% Display the Board (matrix)
% Input: I_Matrix as parameter
% Decommenter I_Matrix pour tester le bon fonctionnement de l'afficage.


displayBoard :-
    board(Board),
    matrix_dims(Board, [_|Length]),
    write('   '),
    msublist([a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z], [0, Length], Header),
    nl, write('   '),
    list_display(Header),
    nl,
    Length_2 is Length * 2 + 1,
    write('  '),
    for(0, Length_2, write('-')),
    nl,
    matrix_display(Board, 0),
    write('  '),
    for(0, Length_2, write('-')),
    nl.