% Relaciona al dueño con el nombre del juguete
%y la cantidad de años que lo ha tenido
duenio(andy, woody, 8).
duenio(andy, jessie, 3).
duenio(andy, buzz, 3).

% Relaciona al juguete con su nombre
% los juguetes son de la forma:
% deTrapo(tematica)
% deAccion(tematica, partes)
% miniFiguras(tematica, cantidadDeFiguras)
% caraDePapa(partes)

juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa, caraDePapa([ original(pieIzquierdo),
original(pieDerecho),
repuesto(nariz) ])).

% Dice si un juguete es raro
esRaro(deAccion(stacyMalibu, 1, [sombrero])).
% Dice si una persona es coleccionista
esColeccionista(sam).


tematica(deTrapo(Tematica), Tematica).
tematica(deAccion(Tematica,_), Tematica).
tematica(miniFiguras(Tematica,_), Tematica).
tematica(caraDePapa(_), caraDePapa).

esDePlastico(Juguete):-
    juguete(Juguete,TipoDeJuguete),
    contienePlastico(TipoDeJuguete).

contienePlastico(miniFiguras(_,_)).
contienePlastico(caraDePapa(_)).

esDeColeccion(Juguete):-
    juguete(_, Juguete),
    esTematicaDeColeccion(Juguete).
  
esTematicaDeColeccion(Tematica):-
    esRaro(Tematica),
    tematicaColeccionable(Tematica).

esTematicaDeColeccion(deTrapo(_)).

tematicaColeccionable(deAccion(_,_)).
tematicaColeccionable(caraDePapa(_)).


amigoFiel(Duenio, Juguete):-
    duenio(Duenio, Juguete, Anios),
    not(esDePlastico(Juguete)),
    forall(duenio(Duenio,_, OtrosAnios), Anios >= OtrosAnios).

superValioso(Juguete):-
    duenio(Duenio, Juguete,_),
    esDeColeccion(Juguete),
    not(esColeccionista(Duenio)),
    contieneSoloPiezasOriginales(Juguete).

contieneSoloPiezasOriginales(Juguete):-
    juguete(Juguete, Tematica),
    contieneOriginales(Tematica).

contieneOriginales(deTrapo(_)).
contieneOriginales(miniFiguras(_,_)).
contieneOriginales(deAccion(_, Piezas)):- sonOriginales(Piezas).
contieneOriginales(caraDePapa(Piezas)):-  sonOriginales(Piezas).

sonOriginales(Piezas):- not(member(repuesto(_), Piezas)).

duoDinamico(Duenio, Juguete, OtroJuguete):-
    sonDe(Duenio, Juguete, OtroJuguete),
    hacenBuenaPareja(Juguete, OtroJuguete).


sonDe(Duenio, Juguete, OtroJuguete):-
    duenio(Duenio, Juguete,_),
    duenio(Duenio, OtroJuguete,_),
    Juguete \= OtroJuguete.

hacenBuenaPareja(buzz,woody).
hacenBuenaPareja(Juguete, OtroJuguete):-
    tematicaDe(Juguete, Tematica),
    tematicaDe(OtroJuguete, Tematica).

tematicaDe(Juguete, Tematica):-
    juguete(Juguete, TipoDeJuguete),
    tematica(TipoDeJuguete, Tematica).



/*
felicidad(Duenio, FelicidadTotal):-
    duenio(Duenio,_,_),
    findall(Felicidad, felicidadDe(_, Duenio, Felicidad), ListaFelicidad),
    sumlist(ListaFelicidad, Felicidad).

felicidadDe(Juguete, Duenio, Felicidad):-
    duenio(Duenio, Juguete,_),
    cantidadDeFelicidad(Juguete, Felicidad).

cantidadDeFelicidad(miniFiguras(_, Cantidad), Felicidad):- Felicidad is Cantidad * 20.
cantidadDeFelicidad(caraDePapa(Piezas), Felicidad):-
    cantidadDe(Repuestos, Piezas, Repuestos),
    cantidadDe(original(_), Piezas, Originales),
    Felicidad is Repuestos + Originales.

cantidadDeFelicidad(deTrapo(_), 100).
cantidadDeFelicidad(Tematica, ):-
    tematica()

*/