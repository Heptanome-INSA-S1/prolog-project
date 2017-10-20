%%%% Print the value of the Matrix at the position [X,Y] inside the matrix
% The value should be _ if it's a variable, otherwise n (Black) or b (White)
%
printVal(I_Matrix,I_X,I_Y) :- matrix_element(I_Matrix, [I_X, I_Y], Elem), var(Elem), write(' '),!.
printVal(I_Matrix,I_X,I_Y) :- matrix_element(I_Matrix, [I_X, I_Y], O_Element), write(O_Element).
