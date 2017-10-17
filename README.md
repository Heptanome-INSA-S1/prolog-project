# prolog-project
Othello ia in prolog

## Matrix.pl

Implementation:

- [x] createMatrix
- [x] matrix_row
- [x] matrix_column
- [x] matrix_element
- [ ] matrix_diag
- [x] matrix_count
- [x] matrix_any
- [x] matrix_all  

### createMatrix(I_X, I_Y, O_Matrix).
Create a matrix of dims(I_X, I_Y) into O_Matrix (as List(List)).

Example:
```prolog
?- createMatrix(4,4, Matrix).
Matrix = [[_12706, _12712, _12718, _12724], [_12730, _12736, _12742, _12748], [_12754, _12760, _12766, _12772], [_12778, _12784, _12790, _12796]].
```

### matrix_row(I_Matrix, I_RowNum, O_Row).
Take a matrix and a rowNum as input parameters and return the mathing row (as List).
```prolog
?- matrix_row([[1,2,3], [4,5,6], [7,8,9]], 0, Row).
Row = [1, 2, 3].
```

### matrix_column(I_Matrix, I_ColNum, O_Row).
Take a matrix and a columnNum as input parameters and return the matching column (as List).
```prolog
?- matrix_column([[1,2,3], [4,5,6], [7,8,9]], 0, Row).
Row = [1, 4, 7].
```

### matrix_element(I_Matrix, I_X, I_Y, O_Element).
Get the element at the position I_Matrix[I_X\][I_Y].
```prolog
?- matrix_element([[1,2,3], [4,5,6], [7,8,9]], 0, 2, Element).
Element = 3
```

### matrix_diag(I_Matrix, I_start_x, I_start_y, 'LT-RB' | 'RT-LB', length, O_diagonal).
Get the matrix that starts from the position [I_start_x\][I_start_y] of length = length into O_diagonal.
LT-RB => start from left-top to right-bottom
RT-LB => start from right-top to left-bottom

### matrix_count(I_Matrix, Predicate, Count).
Get the number of times where predicate of x is true on the matrix

Example :
```prolog
?- matrix_count([[2,3,4],[6,7,8]], even, X).
X = 4.
```

### matrix_any(I_Matrix, Predicate).
Is true when at least one element of I_Matrix validate the predicate.

Example :
```prolog
?- matrix_any([[1,2,3], [4,5,6], [7,8,9]], even).
true.
```

### matrix_all(I_Matrix, Predicate).
Is true when all the elements of matrix validate the element

Example :
```prolog
?- matrix_all([[1,2,3], [4,5,6], [7,8,9]], even).
false.

?- matrix_all([[2,4,6], [8,10,12], [14,16,18]], even).
true.
```