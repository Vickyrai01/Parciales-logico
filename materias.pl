materia(algoritmos, 1).
materia(analisisI, 1).
materia(pdp, 2).
materia(proba, 2).
materia(sintaxis, 2).
nota(nicolas, pdp, 10).
nota(nicolas, proba, 7).
nota(nicolas, sintaxis, 8).
nota(malena, pdp, 6).
nota(malena, proba, 2).
nota(raul, pdp, 9).

terminoAnio(Alumno, Anio):-
    forall(materia(Materia, Anio), aprobo(Materia, Alumno)).


aprobo(Materia, Alumno):-
    nota(Alumno, Materia, Nota), 
    Nota >= 6.

    