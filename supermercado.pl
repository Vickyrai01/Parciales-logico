%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).
descuento(arroz(_), 1.50).
descuento(salchichas(Marca), 0.50):- Marca \= vienisima.
descuento(lacteo(Marca, Producto), 2):-
    primeraMarca(Marca),
    esProductoDePrimeraMarca(Producto).

descuento(Producto, Descuento) :-
    productoConMayorPrecio(Producto, Precio),
    Descuento is Precio * 0.5.
    
productoConMayorPrecio(Producto, Precio) :-
    precioUnitario(Producto, Precio),
    forall(precioUnitario(_, OtroPrecio), Precio >= OtroPrecio).
        
esProductoDePrimeraMarca(leche).
esProductoDePrimeraMarca(queso).

esCompradorCompulsivo(Cliente):-
    compro(Cliente,_,_),
    forall(compro(Cliente, Producto,_), productoCompulsivo(Producto)).

productoCompulsivo(Producto):-
    marca(Producto, Marca),
    primeraMarca(Marca),
    descuento(Producto, _).

marca(arroz(Marca), Marca).
marca(lacteo(Marca,_), Marca).
marca(salchicas(Marca,_), Marca).

totalAPagar(Cliente, TotalAPagar) :-
    compro(Cliente, _, _),
    findall(Precio, calcularPrecioFinal(Cliente, _, Precio), Precios),
    sum_list(Precios, TotalAPagar).

calcularPrecio(Producto, Precio) :-
    descuento(Producto, Descuento),
    precioUnitario(Producto, PrecioUnitario),
    Precio is PrecioUnitario - Descuento.
calcularPrecio(Producto, Precio) :-
    not(descuento(Producto, _)),
    precioUnitario(Producto, Precio). 

calcularPrecioFinal(Cliente, Producto, PrecioFinal) :-
    compro(Cliente, Producto, Cantidad),
    calcularPrecio(Producto, Precio),
    PrecioFinal is Precio * Cantidad.

clienteFiel(Cliente, Marca):-
    compro(Cliente,_,_),
    marca(_,Marca),
    not((compro(cliente, Producto,_),marca(Producto, UnaMarca), Marca \= UnaMarca) ).

