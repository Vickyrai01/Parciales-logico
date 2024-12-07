atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

atiende(vale, Dia, HorarioEn, HorarioSa):- atiende(dodain, Dia, HorarioEn, HorarioSa).
atiende(vale, Dia, HorarioEn, HorarioSa):- atiende(juanC, Dia, HorarioEn, HorarioSa).

% Por principio de universo cerrado no modelo ni maiu qsy

quienAtiende(Dia, Hora, Persona):-
    atiende(Persona, Dia, Entrada, Salida),
    between(Entrada, Salida, Hora).

foreverAlone(Persona, Dia, Horario):-
    atiende(Persona, Dia, _, _),
    not((quienAtiende(OtraPersona, Dia, Horario), OtraPersona \= Persona)).

% no pienso hacer puntos con recursividad, beso ahreeeexxxx

venta(dodain, fecha(10, 8), [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
venta(dodain, fecha(12, 8), [bebidas(true, 8), bebidas(false, 1), golosinas(10)]).
venta(martu, fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, fecha(11, 8), [golosinas(600)]).
venta(lucas, fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).


esSuertuda(Persona):-
    atiende(Persona, _, _, _),
    forall(venta(Persona, _, [Venta|_]), ventaImportante(Venta)).

ventaImportante(golosinas(Cantidad)):- Cantidad > 100.
ventaImportante(cigarrillos(Marcas)):- length(Marcas, Cantidad), Cantidad > 2.
ventaImportante(bebidas(true,_)).
ventaImportante(bebidas(_,Cantidad)):- Cantidad > 5.


    