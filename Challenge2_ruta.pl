ruta(medellin,bogota, avion, 1, 11, 100, si).
ruta(medellin,bogota, avion, 3, 5, 200, si).
ruta(bogota,cartagena, avion, 20, 300, 23, si).
ruta(bogota,cartagena, avion, 50, 70, 56, si).
ruta(cartagena,pasto, avion, 3, 4, 9, si).
ruta(bogota,pasto, avion, 2, 3, 900000, si).


mayor_o_igual(X, Y) :-X >= Y.  
camino(Origen, Destino, Camino, Preciofinal, Hfinal) :- camino_acum(Origen, Destino, [Origen], Camino, Preciofinal, 0, Hfinal,0,0).
camino_acum(Origen, Origen, Visitados, Camino, Preciofin, Preciofin,Hfinal,Hfinal,Posi) :- reverse(Visitados, Camino).
camino_acum(Origen, Destino, Visitados, Camino,Preciofin, Precioaccum,Hfinal, Haccum, Posi):-ruta(Origen, Intermedio,_,Hsal,Hlleg,Precioruta,si),mayor_o_igual(Hsal, Posi),H is Haccum + Hlleg-Hsal ,Precio is Precioaccum+Precioruta, \+ member(Intermedio, Visitados), camino_acum(Intermedio, Destino, [Intermedio | Visitados], Camino, Preciofin, Precio, Hfinal, H,Hlleg).
cheapest(Origen, Destino, Camino, Preciofinal,Hfinal):-findall((Preciofinal, Camino), camino(Origen, Destino, Camino, Preciofinal,Hfinal), Values), min_member((Preciofinal, Camino),Values).
fastest(Origen, Destino, Camino, Preciofinal,Hfinal):-findall((Hfinal, Camino), camino(Origen, Destino, Camino, Preciofinal,Hfinal), Values), min_member((Hfinal, Camino),Values).
caminoentre(Origen, Destino, Camino, Preciofinal, Hfinal,Hde,Harr) :- caminoe_acum(Origen, Destino, [Origen], Camino, Preciofinal, 0, Hfinal,0,0,Hde,Harr).
caminoe_acum(Origen, Origen, Visitados, Camino, Preciofin, Preciofin,Hfinal,Hfinal,Posi, Hde,Harr) :- reverse(Visitados, Camino).
caminoe_acum(Origen, Destino, Visitados, Camino,Preciofin, Precioaccum,Hfinal, Haccum, Posi,Hde,Harr):-ruta(Origen, Intermedio,_,Hsal,Hlleg,Precioruta,si),mayor_o_igual(Harr, Hlleg),mayor_o_igual(Hsal, Hde),mayor_o_igual(Hsal, Posi),H is Haccum + Hlleg-Hsal ,Precio is Precioaccum+Precioruta, \+ member(Intermedio, Visitados), caminoe_acum(Intermedio, Destino, [Intermedio | Visitados], Camino, Preciofin, Precio, Hfinal, H,Hlleg,Hde,Harr).
cheapestentre(Origen, Destino, Camino, Preciofinal,Hfinal,Min,Max):-findall((Preciofinal, Camino), caminoentre(Origen, Destino, Camino, Preciofinal,Hfinal,Min,Max), Values), min_member((Preciofinal, Camino),Values).
fastestentre(Origen, Destino, Camino, Preciofinal,Hfinal,Min,Max):-findall((Hfinal, Camino), caminoentre(Origen, Destino, Camino, Preciofinal,Hfinal,Min,Max), Values), min_member((Hfinal, Camino),Values).


