progenitor(homero, bart).
progenitor(homero, lisa).
progenitor(homero, maggie).
progenitor(abe, homero).
progenitor(abe, jose).
progenitor(jose, pepe).
progenitor(mona, homero).
progenitor(jacqueline, marge).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(marge, maggie).

hermanos(UnaPersona, OtraPersona):-
    progenitor(UnProgenitor, UnaPersona),
    progenitor(UnProgenitor, OtraPersona),
    UnaPersona \= OtraPersona.

tio(Tio, Persona):-
    progenitor(Progenitor, Persona),
    hermanos(Tio, Progenitor).

primo(UnaPersona, OtraPersona):-
    progenitor(UnProgenitor, UnaPersona),
    progenitor(OtroProgenitor, OtraPersona),
    /*UnProgenitor \= OtroProgenitor,*/
    hermanos(UnProgenitor,OtroProgenitor).

abuelo(Abuelo, Nieto):-
    progenitor(Padre, Nieto),
    progenitor(Abuelo, Padre).
