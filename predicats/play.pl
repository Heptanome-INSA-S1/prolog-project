%%%% Recursive predicate for playing the game.

% The game is over, we use a cut to stop the proof search, and display the winner/board.
play(_):-
	gameover(Winner), !,
	write('Game is Over. Winner: '), writeln(Winner),
	displayBoard,
	 !.

% The player can play
play(Player):-
  board(Board), % instanciate the board from the knowledge base
  canPlay(Board, Player),
 % displayBoard, % print it
 % write('New turn for:'), writeln(Player),
  getMove(Board, Player, Move), % ask the AI for a move, that is, an index for the Player
  playMove(Board, Player, Move, PlayedBoard),
  findIndexTransformation(PlayedBoard, Move, Indices),
  reversePawns(PlayedBoard, Indices, NewBoard),
  replaceBoard(Board, NewBoard), % Remove the old board from the KB and store the new one
  changePlayer(Player,NextPlayer), % Change the player before next turn
  play(NextPlayer). % next turn!

% The player cannot play
play(Player):-
  board(Board), % instanciate the board from the knowledge base
 % write('Player '), write(Player), writeln(' cannot play'),
  changePlayer(Player, NextPlayer),
  canPlay(Board, NextPlayer),
  play(NextPlayer).
