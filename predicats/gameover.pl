:- ensure_loaded(../main).




gameover(Winner) :- board(Board), winner(Board,Winner),!.
gameover('Draw') :- board(Board),countPawn(Board,Player1,Res1),countPawn(Board,Player2,Res2), Res1==Res2. %à poursuivre