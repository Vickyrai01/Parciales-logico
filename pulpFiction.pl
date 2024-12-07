personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%encargo(Solicitante, Encargado, Tarea). 
%las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


esPeligroso(Personaje):- 
    personaje(Personaje, Actividad),
    esActividadPeligrosa(Actividad).
    
esPeligroso(Personaje):-
    trabajaPara(Personaje, Empleado),
    esPeligroso(Empleado).

esActividadPeligrosa(mafioso(maton)).
esActividadPeligrosa(ladron(Objetos)):-member(licorerias, Objetos).

duoTemible(UnPersonaje, OtroPersonaje):-
    esPeligroso(UnPersonaje),
    esPeligroso(OtroPersonaje),
    seConocen(UnPersonaje, OtroPersonaje).

seConocen(UnPersonaje, OtroPersonaje):- amigo(UnPersonaje, OtroPersonaje).
seConocen(UnPersonaje, OtroPersonaje):- pareja(UnPersonaje, OtroPersonaje).

estaEnProblemas(Personaje):-
    trabajaPara(Empleador, Personaje),
    esPeligroso(Empleador),
    lePidioEncargoPeligroso(Empleador, Personaje).

estaEnProblemas(Personaje):- 
    encargo(_, Personaje,buscar(Boxeador,_)),
    esBoxeador(Boxeador).

estaEnProblemas(butch).

esBoxeador(Boxeador):- personaje(Boxeador, boxeador).

lePidioEncargoPeligroso(Empleador, Personaje):-
    encargo(Empleador, Personaje, cuidar(Pareja)),
    pareja(Empleador, Pareja).


sanCayetano(Personaje):-
    personaje(Personaje,_),
    forall(tieneCerca(Personaje, Empleado), encargo(Personaje, Empleado,_)).

tieneCerca(Personaje1, Personaje2):-
    amigo(Personaje1, Personaje2).
    
tieneCerca(Personaje1, Personaje2):-
    trabajaPara(Personaje1, Personaje2). 

%masAtareado(Personaje):-
    %cantidadDeTareas(Personaje, Cantidad),
    %forall((cantidadDeTareas(Personaje, Cantidad),cantidadDeTareas(OtroPersonaje, OtraCantidad)),
 %Cantidad > OtraCantidad.
    