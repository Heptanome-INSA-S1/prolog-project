:- ensure_loaded([matrix, findIndexTransformation]).

findAllIndexTransformation(I_Board, [I_X,I_Y], O_ListIndex) :- 
	findall(L, findIndexTransformation(I_Board,[I_X,I_Y],L), R), 
	matrix2list(R, O_ListIndex).
