integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).

nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

tieneBuenaBase(Grupo):-
    tieneBuenaBasePara(Grupo, UnIntegrante),
    tieneBuenaBasePara(Grupo, OtroIntegrante),
    UnIntegrante \= OtroIntegrante.

tieneBuenaBasePara(Grupo, UnIntegrante):-
    integrante(Grupo, UnIntegrante, UnInstrumento),
    instrumento(UnInstrumento, TipoDeInstrumento),
    tipoDeBuenaBase(TipoDeInstrumento).

tipoDeBuenaBase(ritmico).
tipoDeBuenaBase(armonico).

nivelConElQueToca(Persona, Grupo, Nivel):-
    integrante(Grupo, Persona, Instrumento),
    nivelQueTiene(Persona, Instrumento, Nivel).

seDestaca(Integrante, Grupo):-
    nivelConElQueToca(Integrante, Grupo, Nivel),
    forall((nivelConElQueToca(OtroIntegrante, Grupo, OtroNivel), Integrante \= OtroIntegrante), Nivel >= 2 + OtroNivel).
        

grupo(vientosDelEste, bigBand). 
grupo(sophieTrio, formacion([contrabajo, guitarra, violin])). 
grupo(jazzmin, formacion([bateria, bajo, trompeta, piano, guitarra])).

esDeViento(Instrumento):- instrumento(Instrumento, melodico(viento)).

hayCupoPara(Instrumento, Grupo):-
    grupo(Grupo, bigBand),
    esDeViento(Instrumento).

hayCupoPara(Instrumento, Grupo):-
    grupo(Grupo, TipoDeGrupo),
    sirvePara(TipoDeGrupo, Instrumento),
    not(integrante(Grupo,_,Instrumento)).

sirvePara(bigBand, bateria).
sirvePara(bigBand, bajo).
sirvePara(bigBand, piano).
sirvePara(bigBand, Instrumento):- esDeViento(Instrumento).
sirvePara(formacion(InstrumentosBuscados), Instrumento):-
    member(Instrumento, InstrumentosBuscados).

puedeIncorporarseCon(Instrumento, Persona, Grupo):-
    nivelQueTiene(Persona, Instrumento, Nivel),
    not(integrante(Grupo, Persona,_)),
    hayCupoPara(Instrumento, Grupo),
    grupo(Grupo, TipoDeGrupo),
    cumpleConNivelMinimoDe(TipoDeGrupo, NivelEsperado),
    Nivel >= NivelEsperado.


cumpleConNivelMinimoDe(bigBand, 1).
cumpleConNivelMinimoDe(formacion(Instrumentos), Nivel):-
    length(Instrumentos, Cantidad),
    Nivel is 7 - Cantidad.

seQuedoEnBanda(Persona):-
    nivelQueTiene(Persona, _,_),
    not(integrante(_,Persona,_)),
    not(puedeIncorporarseCon(_,Persona,_)).


puedeTocar(Grupo):-
    grupo(Grupo, formacion(Instrumentos)),
    forall(member(Instrumento, Instrumentos) , integrante(Grupo,_, Instrumento)).

puedeTocar(Grupo):-
    grupo(Grupo, bigBand),
    tieneBuenaBase(Grupo),
    findall(Integrante, (integrante(Grupo, Integrante, Instrumento), esDeViento(Instrumento)), Integrantes),
    length(Integrantes, Cantidad),
    Cantidad >= 5.

sirvePara(ensamble,_).

nivelMinimo(ensamble(NivelMinimo), NivelMinimo).
puedeTocar(Grupo):-
    grupo(Grupo, ensamble(_)),
    tieneBuenaBase(Grupo),
    integrante(Grupo,_, Instrumento),
    instrumento(Instrumento, melodico(_)).        



