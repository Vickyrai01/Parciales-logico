jockey(valdivieso).
jockey(leguisamo).
jockey(lezcano).
jockey(baratucci).
jockey(falero).

mide(valdivieso, 155).
mide(leguisamo, 161).
mide(lezcano, 149).
mide(baratucci, 153).
mide(falero, 157).

pesa(valdivieso, 52).
pesa(leguisamo, 49).
pesa(lezcano, 50).
pesa(baratucci, 55).
pesa(falero, 52).

caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yastro).

caballeriaDe(valdivieso, elTute).
caballeriaDe(falero, elTute).
caballeriaDe(lezcano, lasHormigas).
caballeriaDe(baratucci, elCharabon).
caballeriaDe(leguisamo, elCharabon).

caballeria(elTute).
caballeria(lasHormigas).
caballeria(elCharabon).

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoDeOro).
gano(matBoy, granPremioCriadores).


prefiere(botafogo, baratucci).
prefiere(botafogo, Jockey):-
    pesa(Jockey, Peso),
    Peso < 52.

prefiere(oldMan, Jockey):-              
    jockey(Jockey),
    atom_length(Jockey, Longitud),
    Longitud > 7.

prefiere(energica, Jockey):-
    jockey(Jockey),
    not(prefiere(botafogo, Jockey)).
prefiere(matBoy, Jockey):-
    mide(Jockey, Altura),
    Altura > 170.

prefiereMasDeUnJockey(Caballo):-
    prefiere(Caballo, UnJockey),
    prefiere(Caballo, OtroJockey),
    UnJockey \= OtroJockey.

noPrefierenANingunoDe(Caballeria, Caballo):-
    caballo(Caballo),
    caballeria(Caballeria),
    not((caballeriaDe(Jockey, Caballeria), prefiere(Caballo, Jockey))).

esPiolin(Jockey):-
    jockey(Jockey),
    forall( ganoPremioImportante(Caballo), prefiere(Caballo, Jockey)).

ganoPremioImportante(Caballo):-
    gano(Caballo, Premio), 
    esPremioImportante(Premio).

esPremioImportante(granPremioNacional).    
esPremioImportante(granPremioRepublica).

crin(botafogo, negro).
crin(oldMan, marron).
crin(energica, gris).
crin(energica, negro).
crin(matBoy, marron).
crin(matBoy, blanco).
crin(yastro, blanco).
crin(yastro, marron).

puedeComprar(Persona, Caballos):-
    prefiere(Persona, Color),
    findall(Caballo, crin(Caballo, Color), Caballos).
    