%	IA 3 : joue le coup qui maximise 
%	( nombre de pion gagné - nombre de pion perdu au prochain coup de l'IA
%		( si  l'IA adverse joue le coup qui donne lui donne le plus de pion )
%	)

:- ensure_loaded([matrix,getNumberPawnReturned]).

%Change le MaxCount et BestMove si Cout>MaxCount
nextMove(Board,Player,ListMove,MaxCount,Count,BestMove,Move) :-
    Count>MaxCount,
    getBestMove(Board,Player,ListMove,Count,Move).
nextMove(Board,Player,ListMove,MaxCount,Count,BestMove,Move) :-
    Count<=MaxCount,
    getBestMove(Board,Player,ListMove,MaxCount,BestMove).

%Calcul pour chaque move un score correspondant 
%au (nombre de pion gagné - nombre de pion perdu), et passe aux autres coups
getFirstBestMove(_,_,[],_,_).
getFirstBestMove(Board,'W',[Move|ListMove],MaxCount,BestMove) :- 
    getNumberPawnReturned(Board,'W',Move,Count),
    CountSecond is 0,
    gestBestMoveWithPrevisionOfSecondMove(Board,'B',Move,CountSecond),
	nextMove(Board,'W',ListMove,MaxCount,Count-CountSecond,BestMove,Move).
getFirstBestMove(Board,'B',[Move|ListMove],MaxCount,BestMove) :- 
    getNumberPawnReturned(Board,'B',Move,Count),
    CountSecond is 0,
    gestBestMoveWithPrevisionOfSecondMove(Board,'W',Move,CountSecond),
	nextMove(Board,'B',ListMove,MaxCount,Count-CountSecond,BestMove,Move).

%Construit un nouveau Board temporaire et essaye de deviner le coup que pourrais jouer l'IA adverse
gestBestMoveWithPrevisionOfSecondMove(Board,Player,Move,Count) :-
    copy_term(Board,NewBoard),  %à tester !!!!!!!!!!!!!
    matrix_element(NewBoard,Move,Player),
    matrix_get_possibilities(NewBoard,Player,ListSecondMove),
	getSecondBestMove(NewBoard,Player,ListSecondMove,MaxCount,BestMove). 

%Retourne le BestMove de l'adversaire
getSecondBestMove(_,_,[],_,_).
getSecondBestMove(Board,Player,[Move|ListMove],MaxCount,BestMove) :- 
    getNumberPawnReturned(Board,Player,Move,Count),
	nextMove(Board,Player,ListMove,MaxCount,Count,BestMove,Move).

ia2(Board,Player,BestMove) :-
    MaxCount is 0,
	matrix_get_possibilities(Board, Player,ListMove),
	getFirstBestMove(Board,Player,ListMove,MaxCount,BestMove). 
