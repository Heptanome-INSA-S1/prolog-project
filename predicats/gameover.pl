:- ensure_loaded(../main).



winner(Board,P) :- board(Board),countPawn(Board,P,Res),countPawn(Board,Player2,Res2),Res>Res2,canNotPlay(Player2),canNotPlay(P).
								   

gameover(Winner) :- board(Board), winner(Board,Winner),!.
gameover('Draw') :- board(Board),isBoardFull(Board),countPawn(Board,Player1,Res1),countPawn(Board,Player2,Res2), Res1==Res2.
gameover('Draw') :- board(Board),canNotPlay(Player2),canNotPlay(Player1),countPawn(Board,Player1,Res1),countPawn(Board,Player2,Res2), Res1==Res2.
