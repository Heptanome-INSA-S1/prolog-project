:- ensure_loaded([
    '../predicats/for',
    '../predicats/list',
    '../predicats/matrix',
    '../predicats/canNotPlay',
    '../predicats/changePlayer',
    '../predicats/countPawn',
    '../predicats/displayBoard',
    '../predicats/findIndexTransformation',
    '../predicats/gameover',
    '../predicats/getNumberPawnReturned',
    '../predicats/ia',
    '../predicats/isBoardFull',
    '../predicats/isValidAction',
    '../predicats/play',
    '../predicats/playMove',
    '../predicats/printVal',
    '../predicats/replaceBoard',
    '../predicats/returnPawns',
    '../predicats/if'
]).

:- ensure_loaded([
    list_test,
    matrix_test,
    findIndexTransformation_test
]).

% Debug mod ------------------------

debug(false).

% ----------------------------------

log(X) :- debug(DebugOn), DebugOn, write('log: '), write(X), nl, !.
log(_).

even(X) :- X mod 2 =:= 0.

:- dynamic board/1.


mustBeTrue(_, X, _) :-
    X, !.

mustBeTrue(Name, _, ErrorMsg) :-
    write('  Test: '),
    write(Name),
    write(' failed because : '),
    write(ErrorMsg),
    nl, !.

mustBeFalse(Name, X, ErrorMsg) :-
    X,
    write('  Test: '),
    write(Name),
    write(' failed because : '),
    write(ErrorMsg),
    nl, !.

mustBeFalse(_, _, _) :- !.

expected(_, X, Expected, Given) :-
    X, Given == Expected, !.

expected(Name, X, Expected, Given) :-
    X, Expected \== Given, write('  Test: '), write(Name), write(' failed, expected: '), write(Expected), write(', given: '), write(Given), nl, !.

expected(Name, _, _, _) :-
    write('  Test: '), write(Name), write(' has crashed'), nl, !.

unexpected(Name, X, Output) :-
    X, write('  Test: '), write(Name), write(' failed, because: '), write(Output), write(' was found but was not expected.'), nl, !.

unexpected(_,_,_) :- !.


run_unit_tests :-

    writeln('-------------------------'),
    writeln('  Check validators ------'),
    expected('Valid test', true, a,a),
    expected('This test must failed', true, a, b),

    unexpected('Valid test', false, _),
    unexpected('This test must failed', true, d),
    writeln('-------------------------'),
    writeln('Start tests -------------'),

    list_tests,
    matrix_tests,
    findIndexTransformation_tests,

    writeln('End tests ---------------'),

    !.

run_unit_tests :- write('/ ! \\ Some tests are not working'), nl, !.
