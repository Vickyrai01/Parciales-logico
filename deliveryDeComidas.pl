%composicion(plato, [ingrediente])%
composicion(platoPrincipal(milanesa),[ingrediente(pan,3),
ingrediente(huevo,2),ingrediente(carne,2)]).

composicion(entrada(ensMixta),[ingrediente(tomate,2),
ingrediente(cebolla,1),ingrediente(lechuga,2)]).

composicion(entrada(ensFresca),[ingrediente(huevo,1),
ingrediente(remolacha,2),ingrediente(zanahoria,1)]).

composicion(postre(budinDePan),[ingrediente(pan,2),ingrediente(caramelo,1)]).

%calorías(nombreIngrediente, cantidadCalorias)%
calorias(pan,30).
calorias(huevo,18).
calorias(carne,40).
calorias(caramelo,170).

%proveedor(nombreProveedor, [nombreIngredientes])%
proveedor(disco, [pan, caramelo, carne, cebolla]).
proveedor(sanIgnacio, [zanahoria, lechuga, miel, huevo]).

caloriasTotal(Plato, Calorias):-
    composicion(Plato, Ingredientes),
    caloriasTotalesDeLosIngredientes(Ingredientes, ListaDeCalorias),
    sumlist(ListaDeCalorias, Calorias).

caloriasTotalesDeLosIngredientes(Ingredientes, ListaDeCalorias):-
    findall(CaloriasDeIngrediente, (member(Ingrediente, Ingredientes),
    caloriasDe(Ingrediente, CaloriasDeIngrediente)), ListaDeCalorias).
    
caloriasDe(ingrediente(Ingrediente,Cantidad), Calorias):-
    calorias(Ingrediente, CaloriasPorPorcion),
    Calorias is Cantidad *CaloriasPorPorcion.

platoSimpatico(Plato):-
    composicion(Plato, Ingredientes),
    hayIngredientesSimpaticos(Ingredientes).

platoSimpatico(Plato):-
    caloriasTotal(Plato, Calorias),
    Calorias < 200.

hayIngredientesSimpaticos(Ingredientes):- 
    member(ingrediente(huevo,_), Ingredientes),
    member(ingrediente(pan,_), Ingredientes).

menuDiet(Plato1, Plato2, Plato3) :-
    esEntrada(Plato1),
    esPlatoPrincipal(Plato2),
    esPostre(Plato3),
    caloriasTotal(Plato1, Calorias1),
    caloriasTotal(Plato2, Calorias2),
    caloriasTotal(Plato3, Calorias3),
    Calorias1 + Calorias2 + Calorias3 =< 450.    
    
    
esEntrada(entrada(Nombre)) :- composicion(entrada(Nombre), _).
esPlatoPrincipal(platoPrincipal(Nombre)) :- composicion(platoPrincipal(Nombre), _).
esPostre(postre(Nombre)) :- composicion(postre(Nombre), _).

tieneTodo(Proveedor, Plato):-
    proveedor(Proveedor, Productos),
    composicion(Plato, Ingredientes),
    forall(member(ingrediente(Ingrediente,_), Ingredientes), member(Ingrediente, Productos)).

ingredientePopular(Ingrediente):-
    tiene(ingrediente(Ingrediente, _), _),
    cantidadDePlatosQueContienen(Ingrediente, Cantidad),
    Cantidad > 3.

cantidadDePlatosQueContienen(Ingrediente, Cantidad):-
    findall(Plato, tiene(ingrediente(Ingrediente,_),Plato), Platos),
    length(Platos, Cantidad).

tiene(Ingrediente, Plato) :-
    composicion(Plato, Ingredientes),
    member(Ingrediente, Ingredientes).

