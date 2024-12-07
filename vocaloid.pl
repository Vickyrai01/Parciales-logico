canta(megurineLuka, cancion(foreverYoung, 5)).
canta(hatsuneMiku, cancion(tellYourWorld, 4)).
canta(gumi, cancion(foreverYoung, 4)).
canta(gumi, cancion(tellYourWorld, 5)).
canta(seeU, cancion(novemberRain, 6)).
canta(seeU, cancion(nightFever, 5)).

vocaloid(Vocaloid):- canta(Vocaloid,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

esNovedoso(Vocaloid):-
    sabeAlMenosDosCanciones(Vocaloid),
    duracionDeTodasSusCanciones(Vocaloid, Duracion),
    Duracion < 15.

sabeAlMenosDosCanciones(Vocaloid):-
    canta(Vocaloid, UnaCancion),
    canta(Vocaloid, OtraCancion),
    UnaCancion \= OtraCancion.

duracionDeTodasSusCanciones(Vocaloid, Cantidad):-
    vocaloid(Vocaloid),
    findall(Duracion, tiempoDeCancion(Duracion, Vocaloid), DuracionDeCanciones),
    sumlist(DuracionDeCanciones, Cantidad).

tiempoDeCancion(TiempoCancion, Vocaloid):-
    canta(Vocaloid, Cancion),
    tiempo(Cancion, TiempoCancion).

tiempo(cancion(_, TiempoCancion), TiempoCancion).

esAcelerado(Vocaloid):-
    vocaloid(Vocaloid),
    not((tiempoDeCancion(Tiempo, Vocaloid), Tiempo > 4)).

/*
Conciertos:
concierto(nombreConcierto, pais, cantidadDeFama, tipoDeConcierto)
gigante(cantMinimasDeCanciones, duracionMinimaDeTotalDeTodasLasCanciones)
mediano(duracionMaximaDeTotalDeCanciones)
pequenio(duracionMinimaDeAlgunaCancion)
*/

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).
    
    
puedeParticiparEn(_,hatsuneMiku).  
puedeParticiparEn(Concierto, Vocaloid):-
    Vocaloid \= hatsuneMiku,
    tipoDeConcierto(Concierto, TipoDeConcierto),
    cumpleConLosRequisitosDe(TipoDeConcierto, Vocaloid).


cumpleConLosRequisitosDe(gigante(CantMinimasCanciones, DuracionTotalMinima), Vocaloid):-
    duracionDeTodasSusCanciones(Vocaloid, Cantidad),
    cantidadDeCanciones(CantCanciones, Vocaloid),
    CantMinimasCanciones =< CantCanciones,
    DuracionTotalMinima =< Cantidad.

cumpleConLosRequisitosDe(mediano(DuracionMaxima), Vocaloid):-
    duracionDeTodasSusCanciones(Vocaloid, Cantidad),
    Cantidad =< DuracionMaxima.

cumpleConLosRequisitosDe(pequenio(DuracionMinimaDeCancion)):-
    tiempoDeCancion(Tiempo, Vocaloid),
    Tiempo >= DuracionMinimaDeCancion.

cantidadDeCanciones(Cantidad, Vocaloid):-
    findall(Cancion, canta(Cantante, Cancion), Canciones),
    length(Canciones, Cantidad).


tipoDeConcierto(concierto(_,_,_,TipoDeConcierto), TipoDeConcierto).


esElMasFamoso(Vocaloid):-
    nivelDeFamaTotal(Vocaloid, Fama),
    forall(nivelDeFamaTotal(_, OtraFama),  Fama >= OtraFama).
    
nivelDeFamaTotal(Vocaloid, Nivel):-
    famaDeSusConciertos(Vocaloid, Fama),
    cantidadDeCanciones(Cantidad, Vocaloid),
    Nivel is Fama * Cantidad.

famaDeSusConciertos(Vocaloid, Fama):-
    vocaloid(Vocaloid),
    findall(FamaDeConcierto, famaDeConciertoPara(Vocaloid,FamaDeConcierto), FamasDeConciertos),
    sumlist(FamasDeConciertos, Fama).

famaDeConciertoPara(Vocaloid,Fama):-
    puedeParticiparEn(Concierto, Vocaloid),
    famaDe(Concierto, Fama).

famaDe(concierto(Concierto,_,FamaDeConcierto,_), FamaDeConcierto).
        
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).


unicoParticipanteEntreConocidos(Cantante,Concierto):- 
    puedeParticiparEn(Cantante, Concierto),
    not((conocido(Cantante, OtroCantante), 
    puedeParticiparEn(OtroCantante, Concierto))).

conocido(Cantante, OtroCantante) :- conoce(Cantante, OtroCantante).
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, UnCantante), 
    conocido(UnCantante, OtroCantante).