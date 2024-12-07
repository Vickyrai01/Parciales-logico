%comida(hamburguesa, 2000).
%comida(panchoConPapas, 1500 ).
%comida(lomito, 2500).
%comida(caramelo, 0).

puestoDeComida(hamburguesa,2000).
puestoDeComida(panchoConPapas, 1500 ).
puestoDeComida(lomito, 2500).
puestoDeComida(caramelo,0).

atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

% atraccion(nombre, intensa(coeficienteDeLanzamiento)).
atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

% atracccion(nombre, montaniaRusa(giros, duracion)).
atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

atraccion(torpedoSalpicon, acuatica).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).


%persona : nombre dinero edad
persona(eusebio, 3000, 80).
persona(carmela, 0, 80).
persona(eduardo, 3000, 80).
persona(analia, 3000, 80).
persona(sofia, 3000, 80).
persona(bianca, 3000, 80).

persona(marcela, 0, 80).
persona(julieta, 0, 80).

%estado:nombre hambre aburrimiento
estado(eusebio, 50, 0).
estado(carmela,0, 25).
estado(eduardo,0, 25).
estado(analia,0, 25).
estado(sofia,0, 25).
estado(bianca,0, 0).


estado(marcela, 50, 0).
estado(julieta, 50, 0).

%grupo perteneciente nombre grupo

grupo(eusebio, viejitos).
grupo(carmela, viejitos).
grupo(eduardo, lopez).
grupo(analia, lopez).
grupo(sofia, lopez).
grupo(bianca, lopez).

estaAcompaniado(Visitante):- grupo(Visitante,_).

estadoDeBienEstar(Visitante, EstadoDeBienEstar):-
    estado(Visitante, Hambre, Aburrimiento),
    Cantidad is Hambre + Aburrimiento,
    bienEstarSegun(Cantidad, EstadoDeBienEstar, Visitante).

bienEstarSegun(0, felicidadPlena, Visitante):- estaAcompaniado(Visitante).
bienEstarSegun(0, podriaEstarMejor, Visitante):- not(estaAcompaniado(Visitante)).
bienEstarSegun(Cantidad, seQuireIrACasa,_):- Cantidad >= 100.
bienEstarSegun(Cantidad, necesitaEntretenerse,_):- between(51, 99, Cantidad).
bienEstarSegun(Cantidad, podriaEstarMejor,_):- between(1, 50, Cantidad).



satisfaceAGrupo(Comida, Grupo):-
    puestoDeComida(Comida,_),
    grupo(_,Grupo),
    forall(grupo(Persona, Grupo),puedePagarYLoSatisface(Comida, Persona)).

puedePagarYLoSatisface(Comida, Persona):-
    puedePagar(Comida, Persona),
    satisface(Comida, Persona).

puedePagar(Comida, Persona):-
    puestoDeComida(Comida, Precio),
    persona(Persona, Dinero,_),
    Dinero >= Precio.

satisface(lomitoCompleto,_).
satisface(hamburguesa,Persona):-estado(Persona,Hambre, _), Hambre =< 50.
satisface(panchoConPapas, Persona):- esMenor(Persona).
satisface(caramelo, Persona):- not(puedePagarComida(Persona)).

puedePagarComida(Persona) :-
    puedePagar(Comida, Persona),
    Comida \= caramelos.

esMenor(Persona):-persona(Persona,_, Edad),Edad < 13.

puedeProducirLluviaDeHambueguesasCon(Atraccion,Persona):-
    puedePagar(hamburguesa, Persona),
    atraccion(Atraccion, TipoDeAtraccion),
    produceLluvia(Atraccion, Persona, TipoDeAtraccion).


produceLluvia(_,_,intensa(Cantidad)):- Cantidad >= 10.
produceLluvia(tobogan,_,_).
produceLluvia(_,Visitante,MontaniaRusa):- esPeligrosaPara(Visitante, MontaniaRusa).

esPeligrosaPara(Visitante, montaniaRusa(_, Duracion)):-
    esMenor(Visitante),
    Duracion >= 60.

esPeligrosaPara(Visitante, montaniaRusa(Giros,_)):-
    not(esMenor(Visitante)),
    not(estadoDeBienEstar(Visitante, necesitaEntretenerse)).
    forall(atraccion(_, montaniaRusa(OtrosGiros)), Giros >= OtrosGiros).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    opcionesDeEntretenimiento(Visitante, Opcion, _) :-
        puedeComprar(Opcion, Visitante).
        
      opcionesDeEntretenimiento(Visitante, Opcion, _) :-
        atraccion(Opcion, AtraccionTranquila),
        atraccionTranquilaPara(Visitante, AtraccionTranquila).
      
      atraccionTranquilaPara(Visitante, tranquila(_)) :-
        chico(Visitante).
      
      atraccionTranquilaPara(_, tranquila(chicosYAdultos)). % en el video le puse atraccionTranquilaParaSuFranjaEtaria/2, no me di cuenta.
      
      atraccionTranquilaPara(Visitante, tranquila(chicos)) :- % aquí igual.
        tieneChicoEnSuGrupoFamiliar(Visitante).
      
      tieneChicoEnSuGrupoFamiliar(Visitante) :-  % no lo mencioné, pero puedo evitar fijarme que Visitante \= Chico
        integranteDeGrupo(Visitante, Grupo),     % porque si Visitante es adulto, entonces de todos modos da false chico(Chico);
        integranteDeGrupo(Chico, Grupo),         % y si Visitante es chico, de todos modos ya podía acceder a las atracciones de chicos
        chico(Chico).                            % por la cláusula de la línea 142, con lo que no cambia los resultados
      
      opcionesDeEntretenimiento(_, Opcion, _) :-
        atraccion(Opcion, intensa(_)).
      
      opcionesDeEntretenimiento(Visitante, Opcion, _) :-
        atraccion(Opcion, montaniaRusa(GirosInvertidos, Duracion)),
        not(esPeligrosaPara(Visitante, montaniaRusa(GirosInvertidos, Duracion))).
      
      opcionesDeEntretenimiento(_, Opcion, Mes) :-
        atraccion(Opcion, acuatica()),
        mesDeApertura(Mes).
      
      mesDeApertura(septiembre).
      mesDeApertura(octubre).
      mesDeApertura(noviembre).
      mesDeApertura(diciembre).
      mesDeApertura(enero).
      mesDeApertura(febrero).
      mesDeApertura(marzo).
