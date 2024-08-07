% Aquí va el código.
% punto 1
% personajes(Persona)
personajes(ana).
personajes(beto).
personajes(carola).
personajes(dimitri).
% civilizaciones(Civilizacion)
civilizaciones(romanos).
civilizaciones(incas). 
% juegaCon(Persona,civilizacion)
juegaCon(ana, romanos).
juegaCon(beto, incas).
juegaCon(carola, romanos).
juegaCon(dimitri, romanos).
% desarrollo(Persona, desarrollo)
desarrollo(ana, herreria).
desarrollo(ana, forja).
desarrollo(ana, emplumado).
desarrollo(ana, laminas).
desarrollo(beto, herreria).
desarrollo(beto, forja).
desarrollo(beto, fundicion).
desarrollo(carola, herreria).
desarrollo(dimitri, herreria).
desarrollo(dimitri, fundicion).
% tecnologia(Tecnologia)
tecnologia(herreria).
tecnologia(forja).
tecnologia(emplumado).
tecnologia(laminas).
tecnologia(fundicion).
% punto 2
expertoEnMetales(Personaje):- desarrollo(Personaje, herreria), desarrollo(Personaje, forja), desarrollo(Personaje, fundicion).
expertoEnMetales(Personaje):- desarrollo(Personaje, herreria), desarrollo(Personaje, forja), juegaCon(Personaje, romanos).

% punto 3
civilizacionPopular(Civilizacion):- juegaCon(Persona, Civilizacion), juegaCon(OtraPersona,Civilizacion), Persona \= OtraPersona. 

% punto 4
alcanceGlobal(Tecnologia):- tecnologia(Tecnologia), forall(personajes(Persona), desarrollo(Persona, Tecnologia)).

% punto 5
tecnologiasCivilizacion(Civilizacion,ListaTecnologias):- findall(Tecnologia,(juegaCon(Persona,Civilizacion), desarrollo(Persona,Tecnologia)),ListaTecnologias).

%listaContenidaEn(subLista, ListaCompleta)
listaContenidaEn([],_).
listaContenidaEn([X|Xs],Lista):- member(X,Lista), listaContenidaEn(Xs,Lista).

civilizacionLider(Civilizacion):- tecnologiasCivilizacion(Civilizacion,TecnologiasDeLaCiv), forall((civilizaciones(OtraCivilizacion), tecnologiasCivilizacion(OtraCivilizacion, TecnologiasDeOtraCiv), OtraCivilizacion \= Civilizacion), listaContenidaEn(TecnologiasDeOtraCiv, TecnologiasDeLaCiv)).

%%%Unidades%%%

% punto 6
% unidades(Jugador, Unidades)
unidades(ana, jinetes(caballo)).
unidades(ana, piquero(escudo, 1)).
unidades(ana, piquero(sinEscudo, 2)).
unidades(beto, campeon(100)).
unidades(beto, campeon(80)).
unidades(beto, piquero(escudo, 1)).
unidades(beto, jinetes(camello)).
unidades(carola, piquero(sinEscudo, 3)).
unidades(carola, piquero(escudo, 2)).

% punto 7
%cantVida(Unidad, Vida)
cantVida(campeon(Vida), VidaCampeon):- Vida >= 1, Vida =< 100, VidaCampeon is Vida.
cantVida(jinetes(camello), 80).
cantVida(jinetes(caballo), 90).
cantVida(piquero(sinEscudo, 1), 50).
cantVida(piquero(sinEscudo, 2), 65).
cantVida(piquero(sinEscudo, 3), 70).
cantVida(piquero(escudo, Nivel), VidaPiquero):- cantVida(piquero(sinEscudo, Nivel), VidaSinEscudo), VidaPiquero is VidaSinEscudo + (VidaSinEscudo*0.1).

unidadConMasVida(Jugador, UnidadConMasVida) :-generaListaUnidades(Jugador, ListaUnidades), max_member(_-UnidadConMasVida, ListaUnidades).

generaListaUnidades(Jugador, ListaUnidades):-findall(Vida-Unidad, (unidades(Jugador, Unidad), cantVida(Unidad, Vida)), ListaUnidades).

% punto 8
%ventajas("Unidad que gana", "Unidad que pierde")
ventajas(jinetes(_), campeon(_)).
ventajas(campeon(_), piquero(_,_)).
ventajas(piquero(_,_), jinetes(_)).
ventajas(jinetes(camello),jinetes(caballo)).
%leGana("Unidad que gana", "Unidad que pierde")
leGana(Unidad, OtraUnidad):- not(ventajas(Unidad,OtraUnidad)), cantVida(Unidad,Vida1), cantVida(OtraUnidad,Vida2), Vida1 > Vida2.
leGana(Unidad, OtraUnidad):- ventajas(Unidad,OtraUnidad).

% punto 9 
contarPiqueros(Jugador, ConEscudo, SinEscudo) :-
    findall(piquero(escudo, _), unidades(Jugador, piquero(escudo, _)), PiquerosConEscudo),
    findall(piquero(sinEscudo, _), unidades(Jugador, piquero(sinEscudo, _)), PiquerosSinEscudo),
    length(PiquerosConEscudo, ConEscudo),
    length(PiquerosSinEscudo, SinEscudo).

jugadorSobreviveAsedio(Jugador) :-
    contarPiqueros(Jugador, ConEscudo, SinEscudo),
    ConEscudo > SinEscudo.

% punto 10.
/*puedeDesarrollarTecnologia(Jugador,Tecnologia):- obtieneDependencias(Tecnologia,ListaDeDependiencias), jugadorDesarrollo(Jugador,ListaDeDesarrollos), listaContenidaEn(ListaDeDesarrollos,ListaDeDependencias).

*/
