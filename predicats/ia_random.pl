%IA 1 : joue aléatoirement.

choose([], []).
choose(List, Elt) :-
	length(List, Length),
	random(0, Length, Index),
	nth0(Index, List, Elt).

ia_random(Board,Player,Move) :-
	matrix_get_possibilities(Board, Player,List),choose(List,Move).
