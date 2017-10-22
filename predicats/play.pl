%%%% Recursive predicate for playing the game.

% The game is over, we use a cut to stop the proof search, and display the winner/board.
play(_):-
	gameover(Winner), !, write('Game is Over. Winner: '), writeln(Winner), displayBoard, !.

% The game is not over, we play the next turn
play(Player):-
    board(Board), % instanciate the board from the knowledge base
	write('New turn for: '), write(Player),
	displayBoard,
	ia(Board, Player, Move),
	playMove(Board, Player, Move, BoardWithPawn),
	findIndexTransformation(BoardWithPawn, Move, Indicies),
	reversePawns(BoardWithPawn, Indicies, NewBoard),
	replaceBoard(Board, NewBoard),
	matrix_display(NewBoard, 0),!.