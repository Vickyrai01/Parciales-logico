cree(gabriel, campanita).
cree(gabriel, elMagoDeOz).
cree(gabriel, cavenaghi).
cree(juan,conejoDePascua).
cree(macarena,reyesMagos).
cree(macarena,capria).
cree(macarena,campanita).

persona(Persona):- cree(Persona,_).
/*
suenia(persona, serCantante(cantDiscos)).
suenia(persona, futbolista(equipo)).
suenia(persona, ganarLoteriaCon(serieDeNumero)).

*/
suenia(gabriel, ganarLoteriaCon([5,9])).
suenia(gabriel, futbolista(arsenal)).
suenia(cantante, serCantante(100000)).
suenia(macarena, serCantante(10000)).

esAmbiciosa(Persona):-
    dificultadTotalDeSuenio(Persona, Dificultad),
    Dificultad > 20.

dificultadTotalDeSuenio(Persona, DificultadTotal):-
    persona(Persona),
    findall(Dificultad, dificultadDeUnSuenio(Persona, Dificultad), Dificultades),
    sumlist(Dificultades, DificultadTotal).

dificultadDeUnSuenio(Persona, Dificultad):-
    suenia(Persona, Suenio),
    dificultadDe(Suenio, Dificultad).


dificultadDe(serCantante(Cantidad),Dificultad):- criterio(Cantidad, Dificultad).
dificultadDe(ganarLoteriaCon(Numeros), Dificultad):-
    length(Numeros, CantidadDeNumeros),
    Dificultad is 10 * CantidadDeNumeros.

dificultadDe(futbolista(Equipo), Dificultad):-
    dificultadSegunEquipo(Equipo, Dificultad).

dificultadSegunEquipo(Equipo, 3):- esEquipoChico(Equipo).
dificultadSegunEquipo(Equipo, 16):- not(esEquipoChico(Equipo)).

esEquipoChico(arsenal).
esEquipoChico(aldosivi).

criterio(Cantidad,6):-Cantidad > 500000.
criterio(Cantidad,4):-Cantidad =< 500000.

tieneQuimica(Persona, Personaje):-
    cree(Persona, Personaje),
    cumpleCriterioDe(Persona, Personaje).

cumpleCriterioDe(Persona, campanita):-
    dificultadDeUnSuenio(Persona, Dificultad),
    Dificultad < 5.

cumpleCriterioDe(Persona, Personaje):-
    Personaje \= campanita,
    not(esAmbiciosa(Persona)),
    forall(suenia(Persona, Suenio), esPuro(Suenio)).

esPuro(futbolista(_)).
esPuro(cantante(CantDiscos)):-CantDiscos < 200000.

amigue(campanita,reyesMagos).
amigue(reyesMagos,campanita).
amigue(conejoPascua,campanita).
amigue(campanita,conejoPascua).
amigue(conejoPascua,cavenaghi).
amigue(cavenaghi,conejoPascua).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoPascua).

puedeAlegrar(Personaje,Persona):-
    suenia(Persona,_),
    tieneQuimica(Personaje,Persona),
    personajeOBackUpNoEnfermos(Personaje).

personajeOBackUpNoEnfermos(Personaje):-
    not(enfermo(Personaje)).

personajeOBackUpNoEnfermos(Personaje):-
    personajeBackUp(Personaje, BackUp),
    not(enfermo(BackUp)).

personajeBackUp(Principal, BackUp):-
    amigue(Principal, Otro),
    personajeBackUp(Otro, BackUp).

personajeBackUp(Principal, BackUp):-
    amigue(Principal, BackUp).
