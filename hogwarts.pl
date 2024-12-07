leImporta(gryffindor, coraje).
leImporta(slytherin, orgullo).
leImporta(slytherin, inteligencia).
leImporta(ravenclaw, inteligencia).
leImporta(ravenclaw, responsabilidad).
leImporta(hufflepuff, amistad).

casa(gryffindor).
casa(hufflepuff).
casa(slytherin).
casa(ravenclaw).

sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).

cualidades(harry,[coraje, amistad, orgullo, inteligencia]).
cualidades(draco,[inteligencia, orgullo]).
cualidades(hermione,[inteligencia, orgullo, responsabilidad]).

odiaA(slytherin, harry).
odiaA(hufflepuff, draco).


mago(Mago):- sangre(Mago, _).

permiteEntrar(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    Casa \= slytherin.

permiteEntrar(slytherin, Mago):-
    sangre(Mago, Sangre),
    Sangre \= impura.

tieneCaracterApropiadoPara(Casa, Mago):-
    mago(Mago),
    casa(Casa),
    forall(leImporta(Casa, Cualidad), tiene(Cualidad,Mago)).

tiene(Cualidad, Mago):-
    cualidades(Mago, Cualidades),
    member(Cualidad, Cualidades).

puedeQuedarEn(gryffindor, hermione).
puedeQuedarEn(Casa, Mago):-
    tieneCaracterApropiadoPara(Casa, Mago),
    permiteEntrar(Casa, Mago),
    not(odiaA(Casa, Mago)).



esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).    
esDe(draco, slytherin).    
esDe(luna, ravenclaw).


hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, irA(seccionRestringida)).
hizo(harry, irA(bosque)).
hizo(harry, irA(tercerPiso)).
hizo(draco, irA(mazmorras)).
hizo(ron, buenaAccion(50, ganarAlAjedrezMagico)).
hizo(hermione, buenaAccion(50, salvarASusAmigos)).
hizo(harry, buenaAccion(60, ganarleAVoldemort)).
hizo(cedric, buenaAccion(100, ganarAlQuidditch)).

hizoAlgunaAccion(Mago):-
  hizo(Mago, _).
hizoAlgoMalo(Mago):-
  hizo(Mago, Accion),
  puntajeQueGenera(Accion, Puntaje),
  Puntaje < 0.

puntajeQueGenera(fueraDeCama, -50).
puntajeQueGenera(irA(Lugar), PuntajeQueResta):-
  lugarProhibido(Lugar, Puntos),
  PuntajeQueResta is Puntos * -1.
puntajeQueGenera(buenaAccion(Puntaje, _), Puntaje).

lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).
lugarProhibido(tercerPiso, 75).

esBuenAlumno(Mago):-
  hizoAlgunaAccion(Mago),
  not(hizoAlgoMalo(Mago)).
esRecurrente(Accion):-
    hizo(Accion, UnMago),
    hizo(Accion, OtroMago),
    UnMago \= OtroMago.

puntajeDe(Casa, Puntaje):-
    casa(Casa),
    findall(Puntos, (esDe(Mago, Casa), puntosQueObtuvoCon(_, Mago, Puntos)), PuntosTotales),
    sumlist(PuntosTotales, Puntaje).

puntosQueObtuvoCon(Accion, Mago, Puntos):-
    hizo(Mago, Accion),
    puntajeQueGenera(Accion, Puntos).
    
    
    
    


    
    
    
    
    
    
