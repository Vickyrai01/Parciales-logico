anioActual(2015).


%festival(nombre, lugar, bandas, precioBase). [miranda, paulMasCarne, muse]

%lugar(nombre, capacidad).

festival(lulapaluza, lugar(hipodromo,40000),[miranda, paulMasCarne, muse] , 500).
festival(mostrosDelRock, lugar(granRex, 10000), [kiss, judasPriest, blackSabbath], 1000).
festival(personalFest, lugar(geba, 5000), [tanBionica, miranda, muse, pharrellWilliams], 300).
festival(cosquinRock, lugar(aerodromo, 2500), [erucaSativa, laRenga], 400).

%banda(nombre, año, nacionalidad, popularidad).

banda(paulMasCarne,1960, uk, 70).
banda(muse,1994, uk, 45).
banda(kiss,1973, us, 63).
banda(erucaSativa,2007, ar, 60).
banda(judasPriest,1969, uk, 91).
banda(tanBionica,2012, ar, 71).
banda(miranda,2001, ar, 38).
banda(laRenga,1988, ar, 70).
banda(blackSabbath,1968, uk, 96).
banda(pharrellWilliams,2014, us, 85).

%entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).

% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).

entradasVendidas(lulapaluza,campo, 600).
entradasVendidas(lulapaluza,plateaGeneral(zona1), 200).
entradasVendidas(lulapaluza,plateaGeneral(zona2), 300).
entradasVendidas(lulapaluza,plateaNumerada(10),25).


entradasVendidas(mostrosDelRock,campo,20000).
entradasVendidas(mostrosDelRock,plateaNumerada(1),40).
entradasVendidas(mostrosDelRock,plateaNumerada(2),0).
% … y asi para todas las filas

entradasVendidas(mostrosDelRock,plateaNumerada(10),25).
entradasVendidas(mostrosDelRock,plateaGeneral(zona1),300).
entradasVendidas(mostrosDelRock,plateaGeneral(zona2),500).

plusZona(hipodromo, zona1, 55).
plusZona(hipodromo, zona2, 20).
plusZona(granRex, zona1, 45).
plusZona(granRex, zona2, 30).
plusZona(aerodromo, zona1, 25).

estaDeModa(Banda):-
    esReciente(Banda),
    popularidad(Banda, Popularidad),
    Popularidad > 70.

esReciente(Banda):-
    banda(Banda, Anio, _,_),
    anioActual(AnioActual),
    AnioActual - Anio =< 5.

popularidad(Banda, Popularidad):- banda(Banda,_,_,Popularidad).

esCareta(Festival):-
    bandasParticipantes(Festival, Bandas),
    hayBandasCaretas(Bandas).

esCareta(Festival):-
    bandasParticipantes(Festival, Bandas),
    member(miranda, Bandas).

esCareta(Festival):-
    esFestival(Festival),
    not((entradasVendidas(Festival, Entrada,_),
    entradaRazonable(Festival, Entrada))).
    

hayBandasCaretas(Bandas):-
    member(Banda, Bandas),
    member(OtraBanda, Bandas),
    Banda \= OtraBanda,
    estaDeModa(Banda),
    estaDeModa(OtraBanda).
    
entradaRazonable(Festival, Entrada):-
    entradasVendidas(Festival, Entrada,_),
    precio(Festival, Entrada, Precio),
    cumpleCondicion(Festival, Entrada, Precio).

cumpleCondicion(Festival, plateaGeneral(Zona), Precio):-
    plusSegun(Festival, plateaGeneral(Zona), Plus),
    PrecioConDescuento is Precio * 0.1,
    Plus =< PrecioConDescuento.

cumpleCondicion(Festival,campo, Precio):-
    popularidadTotal(Festival, Popularidad),
    Precio < Popularidad.

cumpleCondicion(Festival, plateaNumerada(_), Precio):-
    bandasParticipantes(Festival, Bandas),    
    not((member(Banda, Bandas), estaDeModa(Banda))),
    Precio < 750.

cumpleCondicion(Festival, plateaNumerada(_), Precio):-
    festival(Festival, lugar(_, Capacidad),_,_),
    popularidadTotal(Festival, Popularidad),
    Precio < Capacidad / Popularidad.

precio(Festival, TipoEntrada, Precio):- 
    festival(Festival, _,_, PrecioBase),
    plusSegun(Festival, TipoEntrada, Plus),
    Precio is PrecioBase + Plus.

plusSegun(_,campo, 0).
plusSegun(Festival, plateaNumerada(Fila), Plus):-
    entradasVendidas(Festival,plateaNumerada(Fila),_),
    Plus is 200 / Fila.
plusSegun(Festival, plateaGeneral(Zona), Plus):- 
    festival(Festival,lugar(Lugar,_),_,_),
    plusZona(Lugar, Zona, Plus).

popularidadTotal(Festival, Popularidad):-
    esFestival(Festival),
    findall(Fama, famaDeParticipates(_, Festival, Fama), Famas),
    sumlist(Famas, Popularidad).

famaDeParticipates(Banda, Festival, Fama):-
    bandasParticipantes(Festival, Bandas),
    member(Banda, Bandas),
    popularidad(Banda, Fama).
    
esFestival(Festival):- festival(Festival,_,_,_).
bandasParticipantes(Festival, Bandas):-festival(Festival,_,Bandas,_).

nacanpop(Festival):-
    tieneBandasNacionales(Festival),
    entradasVendidas(Festival,Entrada,_),
    entradaRazonable(Festival, Entrada).

tieneBandasNacionales(Festival):-
    bandasParticipantes(Festival, Bandas),
    forall(member(Banda, Bandas), esNacional(Banda)).

esNacional(Banda):- banda(Banda,_,ar,_).

recaudacion(Festival, Recaudacion):-
    esFestival(Festival),
    findall(Precio, precioTotalDe(_,Festival, Precio), Precios),
    sumlist(Precios, Recaudacion).
    
precioTotalDe(Entrada, Festival, Total):-
    entradasVendidas(Festival, Entrada, Cantidad),
    precio(Festival, Entrada, Precio),
    Total is Cantidad * Precio.

