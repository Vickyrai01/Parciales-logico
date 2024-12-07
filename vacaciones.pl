viaja(dodain, pehuenia).
viaja(dodain, sanMartin).
viaja(dodain, esquel).
viaja(dodain, sarmiento).
viaja(dodain, camarones).
viaja(dodain, playasDoradas).
viaja(alf, bariloche).
viaja(alf, sanMartin).
viaja(alf, elBolson).
viaja(nico, marDelPlata).
viaja(vale, calafate).
viaja(vale, elBolson).

viaja(martu, Destino):- viaja(nico, Destino).
viaja(martu, Destino):-viaja(alf, Destino).

% Por principio de universo cerrado, no modelo ni a juan ni carlos

%atraccion(lugar, tipoDeAtraccion).
atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).
atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoDeAgua(moquehue, true, 14)).
atraccion(pehuenia, cuerpoDeAgua(alumine, true, 19)).


tuvoVacacionesCopadas(Persona):-
    viaja(Persona,_),
    forall(viaja(Persona, Lugar), tieneAlgunaAtraccionCopada(Lugar)).


tieneAlgunaAtraccionCopada(Lugar):-
    atraccion(Lugar, Atraccion),
    esCopada(Atraccion).

esCopada(cerro(_,Metros)):- Metros >= 2000.
esCopada(cuerpoDeAgua(_,true,_)).
esCopada(cuerpoDeAgua(_,_,Temperatura)):- Temperatura > 20.
esCopada(playa(Baja,Alta)):-
    DiferenciaDeMareas is Alta - Baja,
    DiferenciaDeMareas < 5.
esCopada(parqueNacional(_)).
esCopada(excursion(Nombre)):- atom_length(Nombre, 7).

noSeCruzaron(UnaPersona, OtraPersona):-
    viaja(UnaPersona,_),
    viaja(OtraPersona,_),
    UnaPersona \= OtraPersona.
    forall((viaja(UnaPersona, UnLugar), viaja(OtraPersona, OtroLugar)), UnLugar \= OtroLugar).

costo(sarmiento, 100).
costo(esquel, 150).
costo(pehuenia, 180).
costo(sanMartin, 150).
costo(camarones, 135).
costo(playasDoradas, 170).
costo(bariloche, 140).
costo(calafate, 240).
costo(elBolson, 145).
costo(marDelPlata, 140).


tuvoVacacionesGasoleras(Persona):-
    viaja(Persona,_),
    forall(viaja(Persona, Destino), esDestinoGasolero(Destino)).

esDestinoGasolero(Destino):-
    costo(Destino, Costo),
    Costo < 160.