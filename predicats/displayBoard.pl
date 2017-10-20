%%%% Display the Board (matrix)
% Input: I_Matrix as parameter
% Decommenter I_Matrix pour tester le bon fonctionnement de l'afficage.


displayBoard:-
   %%%% I_Matrix = [[n,n,n,n,n,n],[b,b,b,b,b,b],[n,n,n,n,n,n],[b,b,b,b,b,b],[n,n,n,n,n,n],[b,b,b,b,b,b]],
    board(I_Matrix),
    writeln('  a b c d e f '),
    writeln('  -----------'),
    write('1|'),printVal(I_Matrix,0,0),write(' '),printVal(I_Matrix,0,1),write(' '),printVal(I_Matrix,0,2),write(' '),printVal(I_Matrix,0,3),write(' '),printVal(I_Matrix,0,4),write(' '),printVal(I_Matrix,0,5),writeln('|'),
    write('2|'),printVal(I_Matrix,1,0),write(' '),printVal(I_Matrix,1,1),write(' '),printVal(I_Matrix,1,2),write(' '),printVal(I_Matrix,1,3),write(' '),printVal(I_Matrix,1,4),write(' '),printVal(I_Matrix,1,5),writeln('|'),
    write('3|'),printVal(I_Matrix,2,0),write(' '),printVal(I_Matrix,2,1),write(' '),printVal(I_Matrix,2,2),write(' '),printVal(I_Matrix,2,3),write(' '),printVal(I_Matrix,2,4),write(' '),printVal(I_Matrix,2,5),writeln('|'),
    write('4|'),printVal(I_Matrix,3,0),write(' '),printVal(I_Matrix,3,1),write(' '),printVal(I_Matrix,3,2),write(' '),printVal(I_Matrix,3,3),write(' '),printVal(I_Matrix,3,4),write(' '),printVal(I_Matrix,3,5),writeln('|'),
    write('5|'),printVal(I_Matrix,4,0),write(' '),printVal(I_Matrix,4,1),write(' '),printVal(I_Matrix,4,2),write(' '),printVal(I_Matrix,4,3),write(' '),printVal(I_Matrix,4,4),write(' '),printVal(I_Matrix,4,5),writeln('|'),
    write('6|'),printVal(I_Matrix,5,0),write(' '),printVal(I_Matrix,5,1),write(' '),printVal(I_Matrix,5,2),write(' '),printVal(I_Matrix,5,3),write(' '),printVal(I_Matrix,5,4),write(' '),printVal(I_Matrix,5,5),writeln('|'),
    writeln(' ------------'),

    writeln(''),writeln('*****************'), !.
