% The game state will be represented by a list of 9 elements
% board([_,_,_,_,_,_,_,_,_]) at the beginning
% eg board([_,_,'x',_,_,_,_,_,_]) after the first round
% eg board([_,_,'x',_,_,_,'o',_,_]) after the second round
% ...
% until someone wins or the board is fully instanciated


:- dynamic board/1. 

%%%% Test is the game is finished %%%
gameover(Winner) :- board(Board), winner(Board,Winner), !.  % There exists a winning configuration: We cut!
gameover('Draw') :- board(Board), isBoardFull(Board). % the Board is fully instanciated (no free variable): Draw.

%%%% Test if a Board is a winning configuration for the player P.
winner(Board, P) :- Board = [P,Q,R,_,_,_,_,_,_], P==Q, Q==R, nonvar(P). % first row
winner(Board, P) :- Board = [_,_,_,P,Q,R,_,_,_], P==Q, Q==R, nonvar(P). % second row
winner(Board, P) :- Board = [_,_,_,_,_,_,P,Q,R], P==Q, Q==R, nonvar(P). % third row
winner(Board, P) :- Board = [P,_,_,Q,_,_,R,_,_], P==Q, Q==R, nonvar(P). % first column
winner(Board, P) :- Board = [_,P,_,_,Q,_,_,R,_], P==Q, Q==R, nonvar(P). % second column
winner(Board, P) :- Board = [_,_,P,_,_,Q,_,_,R], P==Q, Q==R, nonvar(P). % third column
winner(Board, P) :- Board = [P,_,_,_,Q,_,_,_,R], P==Q, Q==R, nonvar(P). % first diagonal
winner(Board, P) :- Board = [_,_,P,_,Q,_,R,_,_], P==Q, Q==R, nonvar(P). % second diagonal

%%%% Recursive predicate that checks if all the elements of the List (a board) 
%%%% are instanciated: true e.g. for [x,x,o,o,x,o,x,x,o] false for [x,x,o,o,_G125,o,x,x,o]
isBoardFull([]).
isBoardFull([H|T]):- nonvar(H), isBoardFull(T).


%%%% Artificial intelligence: choose in a Board the index to play for Player (_)
%%%% This AI plays randomly and does not care who is playing: it chooses a free position
%%%% in the Board (an element which is an free variable).
ia(Board, Index,_) :- repeat, Index is random(9), nth0(Index, Board, Elem), var(Elem), !.

%%%% Recursive predicate for playing the game. 
% The game is over, we use a cut to stop the proof search, and display the winner/board. 
play(_):- gameover(Winner), !, write('Game is Over. Winner: '), writeln(Winner), displayBoard.
% The game is not over, we play the next turn
play(Player):-  write('New turn for:'), writeln(Player),
    		board(Board), % instanciate the board from the knowledge base 
       	    displayBoard, % print it
            ia(Board, Move,Player), % ask the AI for a move, that is, an index for the Player 
    	    playMove(Board,Move,NewBoard,Player), % Play the move and get the result in a new Board
		    applyIt(Board, NewBoard), % Remove the old board from the KB and store the new one
    	    changePlayer(Player,NextPlayer), % Change the player before next turn
            play(NextPlayer). % next turn!

%%%% Play a Move, the new Board will be the same, but one value will be instanciated with the Move
playMove(Board,Move,NewBoard,Player) :- Board=NewBoard,  nth0(Move,NewBoard,Player).

%%%% Remove old board/save new on in the knowledge base
applyIt(Board,NewBoard) :- retract(board(Board)), assert(board(NewBoard)).

%%%% Predicate to get the next player
changePlayer('x','o').
changePlayer('o','x').

%%%% Print the value of the board at index N:
% if its a variable, print ? and x or o otherwise.
printVal(N) :- board(B), nth0(N,B,Val), var(Val), write('?'), !.
printVal(N) :- board(B), nth0(N,B,Val), write(Val).

%%%% Display the board
displayBoard:-
    writeln('*----------*'),
    printVal(0), printVal(1), printVal(2), writeln(''),
    printVal(3), printVal(4), printVal(5), writeln(''),
    printVal(6), printVal(7), printVal(8), writeln(''),
    writeln('*----------*').
    
%%%%% Start the game! 
init :- length(Board,9), assert(board(Board)), play('x').