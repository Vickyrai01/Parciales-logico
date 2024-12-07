persona(bart).
persona(larry).
persona(otto).
persona(marge).

%los magios son functores alMando(nombre, antiguedad), novato(nombre) y elElegido(nombre).
persona(alMando(burns,29)).
persona(alMando(clark,20)).
persona(novato(lenny)).
persona(novato(carl)).
persona(elElegido(homero)).

hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).

salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).

%Los beneficios son funtores confort(descripcion), confort(descripcion, caracteristica), 
% dispersion(descripcion), economico(descripcion, monto).
gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio(burns, dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).

aspiranteAMagio(Persona):- 
    hijo(Persona, Padre),
    esMagio(Padre).

aspiranteAMagio(Persona):-
    salvo(Persona, OtraPersona),
    esMagio(OtraPersona).

esMagio(Persona) :-persona(alMando(Persona, _)).
esMagio(Persona) :-persona(novato(Persona)).
esMagio(Persona) :-persona(elElegido(Persona)).

puedeDarOrdenes(UnMagio, OtroMagio) :-
    persona(alMando(UnMagio, _)),
    magioInferior(UnMagio, OtroMagio).

puedeDarOrdenes(UnMagio, OtroMagio):-
    persona(elElegido(UnMagio)),
    esMagio(OtroMagio).

magioInferior(_, Magio):-
    persona(novato(Magio)).

magioInferior(UnMagio, OtroMagio) :-
    persona(alMando(UnMagio, Numero)),
    persona(alMando(OtroMagio, OtroNumero)),
    OtroNumero < Numero.


sienteEnvidia(Persona, Envidiados):-
    persona(Persona),
    findall(Envidiado, leTieneEnvidia(Persona, Envidiado), Envidiados).

leTieneEnvidia(Persona, Envidiado):-
    aspiranteAMagio(Persona),
    esMagio(Envidiado).
    
leTieneEnvidia(Persona, Envidiado):-
    not(aspiranteAMagio(Persona)),
    aspiranteAMagio(Envidiado).

leTieneEnvidia(Persona, Envidiado):-
    persona(novato(Persona)),
    persona(alMando(Envidiado, _)).

masEnvidioso(Persona) :-
    persona(Persona),
    not(existeAlguienMasEnvidioso(Persona)).
    
existeAlguienMasEnvidioso(Persona) :-
    cantidadDePersonasEnvidiadas(Persona, Cantidad),
    cantidadDePersonasEnvidiadas(OtraPersona, OtraCantidad),
    Persona \= OtraPersona,
    OtraCantidad > Cantidad.
    
cantidadDePersonasEnvidiadas(Persona, Cantidad) :-
    sienteEnvidia(Persona, PersonasEnvidiadas),
    length(PersonasEnvidiadas, Cantidad).

soloLoGoza(Persona, Beneficio) :-
    gozaBeneficio(Persona, Beneficio),
    not(otroTieneElMismoBeneficio(Persona, Beneficio)).
    
otroTieneElMismoBeneficio(Persona, Beneficio) :-
    gozaBeneficio(OtraPersona, Beneficio),
    Persona \= OtraPersona.




tipoDeBeneficioMasAprovechado(Beneficio) :-
    gozaBeneficio(_, Beneficio),
    not(otroBeneficioTieneMasUsos(Beneficio)).
    
otroBeneficioTieneMasUsos(Beneficio) :-
    gozaBeneficio(_, OtroBeneficio),
    cantidadDeUsosPorBeneficio(Beneficio, Cantidad),
    cantidadDeUsosPorBeneficio(OtroBeneficio, CantidadOtrosUsos),
    OtroBeneficio \= Beneficio,
    CantidadOtrosUsos > Cantidad.
    
cantidadDeUsosPorBeneficio(Beneficio, Cantidad) :-
    findall(Uso, gozaBeneficio(_, Beneficio), Usos),
    length(Usos, Cantidad).