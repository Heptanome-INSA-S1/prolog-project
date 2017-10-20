%%%% Recursive predicate for playing the game.

% The game is over, we use a cut to stop the proof search, and display the winner/board. 
play(_):- 
	gameover(Winner), !, write('Game is Over. Winner: '), writeln(Winner), displayBoard.

% The game is not over, we play the next turn
play(Player):-  
	write('New turn for:'), writeln(Player),
	board(Board), % instanciate the board from the knowledge base 
	displayBoard, % print it
	ia(Board, Player, Move), % ask the AI for a move, that is, an index for the Player
	playMove(Board, Player, Move, NewBoard), % Play the move and get the result in a new Board
	replaceBoard(Board, NewBoard), % Remove the old board from the KB and store the new one
	changePlayer(Player,NextPlayer), % Change the player before next turn
	play(NextPlayer). % next turn!