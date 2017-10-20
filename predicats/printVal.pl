%%%% Print the value of the Matrix at the position [X,Y] inside the matrix
% The value should be _ if it's a variable, otherwise n (Black) or b (White)
%
printVal(Element) :- var(Element), write(' '), !.
printVal(Element) :- write(Element).

printValWithSpace(Element) :- var(Element), write('  '), !.
printValWithSpace(Element) :- write(Element), write(' ').
