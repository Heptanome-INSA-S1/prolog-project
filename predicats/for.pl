for(I,I, _).

for(I, J, Function) :-
    I < J,
    Function,
    NewI is I + 1,
    for(NewI, J, Function).