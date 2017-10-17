# prolog-project
Othello ia in prolog

## Matrix.pl

### createMatrix(I_X, I_Y, O_Matrix).
Create a matrix of dims(I_X, I_Y) into O_Matrix (as List(List)).

### matrix_row(I_Matrix, I_RowNum, O_Row).
Take a matrix and a rowNum as input parameters and return the mathing row (as List).

### matrix_column(I_Matrix, I_ColNum, O_Row).
Take a matrix and a columnNum as input parameters and return the matching column (as List).

### matrix_element(I_Matrix, I_X, I_Y, O_Element).
Get the element at the position I_Matrix[I_X\][I_Y].

### matrix_diag(I_Matrix, I_start_x, I_start_y, 'LT-RB' | 'RT-LB', length, O_diagonal).
Get the matrix that starts from the position [I_start_x\][I_start_y] of length = length into O_diagonal.
LT-RB => start from left-top to right-bottom
RT-LB => start from right-top to left-bottom