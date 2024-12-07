gustaDe(maria,juan).
gustaDe(ana,pedro).
gustaDe(nora,pedro).
gustaDe(zulema,Persona):- gustaDe(nora,Persona).
gustaDe(Persona,julian):- esMorocha(Persona).
gustaDe(Persona,julian):- tieneOndas(Persona).
gustaDe(Persona,mario):- esMorocha(Persona),tieneOnda(Persona).
gustaDe(luisa, mario).
gustaDe(laura,Persona):- gustaDe(ana,Persona), gustaDe(luisa,Persona).


gustaDe(laura,Persona):- gustaDe(ana,Persona).
gustaDe(laura,Persona):- gustaDe(luisa,Persona).


