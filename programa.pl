% Aquí va el código.
%personajes(Persona)
personajes(ana).
personajes(beto).
personajes(carola).
personajes(dimitri).
%civilizaciones(Persona,civilizacion)
civilizaciones(ana, romanos).
civilizaciones(beto, incas).
civilizaciones(carola, romanos).
civilizaciones(dimitri, romanos).
%tecnologias(Persona, desarrollo)
tecnologias(ana, herreria).
tecnologias(ana, forja).
tecnologias(ana, emplumado).
tecnologias(ana, laminas).
tecnologias(beto, herreria).
tecnologias(beto, forja).
tecnologias(beto, fundicion).
tecnologias(carola, herreria).
tecnologias(dimitri, herreria).
tecnologias(dimitri, fundicion).

expertoEnMetales(Personaje):- tecnologias(Personaje, herreria), tecnologias(Personaje, forja), tecnologias(Personaje, fundicion).
expertoEnMetales(Personaje):- tecnologias(Personaje, herreria), tecnologias(Personaje, forja), civilizaciones(Personaje, romanos).

civilizacionPopular(Civilizacion):- civilizaciones(Persona, Civilizacion), civilizaciones(OtraPersona,Civilizacion), Persona \= OtraPersona. 

