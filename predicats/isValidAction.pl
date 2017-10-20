isValidAction(I_Board, I_Player, [I_X,I_Y]):-matrix_get_possibilities(I_Board, I_Player, O_ListePossibilities),
	member([I_X,I_Y],O_ListePossibilities).
