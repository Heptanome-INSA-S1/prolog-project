:- ensure_loaded([gameover, displayBoard, ia1, playMove, replace, changePlayer]).

%%%% Recursive predicate for playing the game. 

% The game is over, we use a cut to stop the proof search, and display the winner/board. 
play(_):- 
	gameover(O_Winner), !, write('Game is Over. Winner: '), writeln(Winner), displayBoard.

% The game is not over, we play the next turn
play(I_Player):-  
	write('New turn for:'), writeln(Player),
	board(Board), % instanciate the board from the knowledge base 
	displayBoard, % print it
	ia1(I_Board, I_Player, O_Move), % ask the AI for a move, that is, an index for the Player 
	playMove(I_Board,I_Move,I_Player,O_NewBoard,), % Play the move and get the result in a new Board
	replace(I_Board, I_NewBoard), % Remove the old board from the KB and store the new one
	changePlayer(I_CurrentPlayer,I_NextPlayer), % Change the player before next turn
	play(NextPlayer). % next turn!