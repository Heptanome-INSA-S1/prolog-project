:- ensure_loaded(../main).


winner(Board,P) :- board(Board),countPawn(Board,P,Res),countPawn(Board,Player2,Res2),Res>Res2,canNotPlay(Player2).
								   

gameover(Winner) :- board(Board), winner(Board,Winner),!.
gameover('Draw') :- board(Board),countPawn(Board,Player1,Res1),countPawn(Board,Player2,Res2), Res1==Res2. %à poursuivre