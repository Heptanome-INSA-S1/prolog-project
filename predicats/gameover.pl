:- ensure_loaded([countPawn, canNotPlay, isBoardFull]).

winner(Board,'B') :- board(Board),countPawn(Board, WhiteCount, BlackCount),WhiteCount>BlackCount,canNotPlay(Board, 'W'),canNotPlay(Board, 'B').
winner(Board,'W') :- board(Board),countPawn(Board, WhiteCount, BlackCount),WhiteCount<BlackCount,canNotPlay(Board, 'B'),canNotPlay(Board, 'W').

gameover(Winner) :- board(Board), winner(Board,Winner),!.
gameover('Draw') :- board(Board),isBoardFull(Board),countPawn(Board, WhiteCount, BlackCount),WhiteCount==BlackCount.
gameover('Draw') :- board(Board),canNotPlay(Player2),canNotPlay(Player1),countPawn(Board, WhiteCount, BlackCount),WhiteCount==BlackCount.
