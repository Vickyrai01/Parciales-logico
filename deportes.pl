% natacion: estilos (lista), metros nadados, medallas
practica(ana, natacion([pecho, crawl], 1200, 10)).
practica(luis, natacion([perrito], 200, 0)).
practica(vicky, 
   natacion([crawl, mariposa, pecho, espalda], 800, 0)).
% fútbol: medallas, goles marcados, veces que fue expulsado
practica(deby, futbol(2, 15, 5)).
practica(mati, futbol(1, 11, 7)).
% rugby: posición que ocupa, medallas
practica(zaffa, rugby(pilar, 0)).


esNadador(UnaPersona):-
    practica(UnaPersona, Deporte),
    natacion(Deporte).

natacion(natacion(_,_,_)).

medallasObtenidas(UnaPersona, Medallas):-
    practica(UnaaPersona, Deporte),
    medallas(Deporte, Medallas).

medallas(natacion(_,_,Cantidad), Cantidad).
medallas(futbol(Cantidad,_,_), Cantidad).
medallas(rugby(_,Cantidad), Cantidad).

buenDeportista(UnDeportista):-
    practica(UnDeportista, Deporte).
    esBienPracticado(Deporte).

esBienPracticado(natacion(_,MetrosNadados,_)):-
    MetrosNadados > 1000.
esBienPracticado(natacion(Estilos,_,_)):-
    length(Estilos, Cantidad ),
    Cantidad >= 3.
esBienPracticado(futbol(_,Goles,Expulsiones)):-
    DiferenciasGolesExpulsiones is Goles - Expulsiones.
    DiferenciasGolesExpulsiones > 5.
esBienPracticado(rugby(wing,_)).
esBienPracticado(rugby(pilar,_)).
    