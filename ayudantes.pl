% Las tareas son functores de la forma
% corregirTp(fechaEnQueElGrupoEntrego, grupo, paradigma)
% robarseBorrador(diaDeLaClase, horario)
% prepararParcial(paradigma).
tarea(vero, corregirTp(190, losMagiosDeTempeley, funcional)).
tarea(hernan, corregirTp(181, analiaAnalia, objetos)).
tarea(hernan, robarseBorrador(197, turnoManiana)).
tarea(hernan, prepararParcial(objetos)).
tarea(alf, prepararParcial(funcional)).
tarea(nitu, corregirTp(190, analiaAnalia, funcional)).
tarea(ignacio, corregirTp(186, laTerceraEsLaVencida, logico)).
tarea(clara, robarseBorrador(197, turnoNoche)).
tarea(hugo, corregirTp(10, laTerceraEsLaVencida, objetos)).
tarea(hugo, robarseBorrador(11, turnoNoche)).
% Estos grupos están en problemas
noCazaUna(loMagiosDeTempeley).
noCazaUna(losExDePepita).
% El 1 es el primero de enero, el 32 es el 1 de febrero, etc
diaDelAnioActual(192).

esDificil(prepararParcial(_)).
esDificil(robarseBorrador(_,turnoNoche)).
esDificil(corregirTp(_,_,objetos)).
esDificil(corregirTp(_,Grupo,_)):- noCazaUna(Grupo).

estaAtrasadoCon(Tarea, Ayudante):-
    tarea(Ayudante, Tarea),
    estaAtrasada(Tarea).

estaAtrasada(Tarea):-
    diaDelAnioActual(Dia),
    fechaDeVencimiento(Tarea, Fecha),
    DiasRetrasados is Dia - Fecha,
    DiasRetrasados > 3.

%%%% Preguntar si esta bien esta delegacion👆👇 %%%%%%%%%%
fechaDeVencimiento(corregirTp(FechaVencimiento,_,_), Fecha):-
    Fecha is FechaVencimiento + 4.
fechaDeVencimiento(robarseBorrador(Fecha,_), Fecha).
%fechaDeVencimiento(prepararParcial(_), _).

verdugos(Grupo, ListaAyudantes):-
    tarea(_, corregirTp(_, Grupo, _)),
    findall(Ayudante, tarea(Ayudante, corregirTp(_, Grupo, _)), ListaAyudantes).

laburaEnProyectoEnLLamas(alf).
laburaEnProyectoEnLLamas(hugo).

cursa(nitu, [ operativos, disenio, analisisMatematico2 ]).
cursa(clara, [ sintaxis, operativos ]).
cursa(ignacio, [ tacs, administracionDeRecursos ] ).

tienePareja(nitu).
tienePareja(alf).

tieneProblemitas(Ayudante):- tienePareja(Ayudante).
tieneProblemitas(Ayudante):- laburaEnProyectoEnLLamas(Ayudante).
tieneProblemitas(Ayudante):- 
    cursa(Ayudante, Materias),
    member(operativos, Materias).

alHorno(Ayudante):-
    tarea(Ayudante,_),
    forall(tarea(Ayudante, Tarea), esDificil(Tarea)),
    estaAtrasadoCon(Tarea, Ayudante),
    tieneProblemitas(Ayudante).