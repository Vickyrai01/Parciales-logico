%tarea(agente, tarea, ubicacion)
%tareas:
%  ingerir(descripcion, tamaño, cantidad)
%  apresar(malviviente, recompensa)
%  asuntosInternos(agenteInvestigado)
%  vigilar(listaDeNegocios)

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria, havanna]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

vendeAlfajores(havanna).

%jefe(jefe, subordinado)
jefe(jefeSupremo, vega).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).

frecuenta(_, buenosAires).
frecuenta(Agente, Lugar):- trabajaPor(Lugar,Persona).
frecuenta(vega, quilmes).

trabajaPor(Lugar, Persona):- tarea(Agente,_,Lugar).

frecuenta(Agente, marDelPlata):-
    tarea(Agente, vigilar(Lugares),_),
    member(Lugar, Lugares),
    vendeAlfajores(Lugar).

esInaccesible(Lugar):-
    ubicacion(Lugar),
    not(frecuenta(_, Lugar)).

afincado(Agente):-
    tarea(Agente,_,Lugar),
    forall(tarea(Agente,_, OtroLugar), Lugar == OtroLugar).


cadenaDeMando([_]).
cadenaDeMando([Persona1, Persona2|Personas]) :-
    jefe(Persona1, Persona2),
    cadenaDeMando([Persona2|Personas]).
    

agrentePremiado(Agente):-
    puntuacion(Agente, Puntuacion),
    forall(puntuacion(OtroAgente, OtraPuntuacion), Puntuacion >= OtraPuntuacion).

puntuacion(Agente, Puntuacion):-
    trabajaPor(_,Agente),
    findall(PuntosDeTarea, puntosDe(Tarea, Agente, PuntosDeTarea), Puntos),
    sumlist(Puntos, Puntuacion).

puntosDe(Tarea, Agente, Puntos):-
    tarea(Agente, Tarea,_),
    puntua(Tarea, Puntos).

puntua(vigilar(Lugares), Puntos):-
    length(Lugares, Cantidad),
    Puntos is Cantidad * 5.

puntua(ingerir(Tamanio, Cantidad), Puntos):-
    Unidad is Tamanio * Cantidad,
    Puntos is -10 * Unidad.

puntua(apresar(_, Recompensa), Puntos):-
    Puntos is Recompesa // 2.

puntua(asuntosInternos(Agente), Puntos):-
    puntuacion(Agente, Puntuacion),
    Puntos is Puntuacion * 2.



    

    

