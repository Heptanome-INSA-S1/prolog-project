winner(Board,'W') :- board(Board),countPawn(Board, WhiteCount, BlackCount),WhiteCount>BlackCount,canNotPlay(Board, 'W'),canNotPlay(Board, 'B').
winner(Board,'B') :- board(Board),countPawn(Board, WhiteCount, BlackCount),WhiteCount<BlackCount,canNotPlay(Board, 'B'),canNotPlay(Board, 'W').

gameover(Winner) :- board(Board), winner(Board,Winner),!.
gameover('Draw') :- board(Board),canNotPlay(Board, 'W'),canNotPlay(Board, 'B'),countPawn(Board, WhiteCount, BlackCount),WhiteCount==BlackCount, !.