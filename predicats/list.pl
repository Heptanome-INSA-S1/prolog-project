:- ensure_loaded([printVal]).

%--------------------- list_append ----------------------------
% append a list to another
% list_append([a], [b,c], Concat).
% Concat = [a,b,c].

not_in([], _).
not_in([X], Y) :- X \== Y.
not_in([H|T], Y) :- H \== Y, not_in(T, Y).

list_append([], List, List).
list_append([Head|Tail], List, [Head|TailConcat]) :- list_append(Tail, List, TailConcat).

length_(Length, List) :- length(List, Length).

each([H], Function) :-
	call(Function, H).

each([X|T], Function) :-
	call(Function, X),
	each(T, Function), !.

each_no_last([_], _).
each_no_last([X|T], Function) :-
	call(Function, X),
	each_no_last(T, Function), !.

each_count([], _, 0).
each_count([H|T], Predicate, Count) :-
	call(Predicate, H),
	each_count(T, Predicate, CountMinus1),
	Count is CountMinus1 + 1, !.
each_count([_|T], Predicate, Count) :-
	each_count(T, Predicate, Count).


list_all(List, Predicate) :-
	length(List, Length),
	each_count(List, Predicate, Length).

msublist(List, [Start, End], Sublist):-
  length(Prefix, Start),
  append(Prefix, Rest, List),
  Start =< End,
  Length is End - Start,
  length(Sublist, Length),
  append(Sublist, _, Rest).

indexOf([Element|_], Element, 0). % We found the element
indexOf([_|Tail], Element, Index):-
indexOf(Tail, Element, Index1), % Check in the tail of the list
    Index is Index1 + 1.

lastIndexOfRec([H | T], N, Idx, Acc, Ret) :- Idx2 is Idx + 1, (H == N, !, lastIndexOfRec(T, N, Idx2, Idx, Ret); lastIndexOfRec(T, N, Idx2, Acc, Ret)).
lastIndexOfRec([], _, _, Acc, Acc).

lastIndexOf(List, Needle, Ret) :- lastIndexOfRec(List, Needle, 0, -1, Ret), Ret > -1.

list_display(List) :-
    each_no_last(List, printValWithSpace),
    length(List, Length),
    LastIndex is Length - 1,
    indexOf(List, Element, LastIndex),
    printVal(Element), !.