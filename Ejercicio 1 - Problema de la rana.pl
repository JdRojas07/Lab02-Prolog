% --- HECHOS Y CAPACIDADES (PARÁMETROS DEL PROBLEMA) ---

% Coordenadas de las ubicaciones: ubicacion(ID, X, Y).
ubicacion(orilla_inicial, 0, 5).
ubicacion(piedra1, 2, 4).
ubicacion(piedra2, 5, 6).
ubicacion(piedra3, 8, 4).
ubicacion(piedra4, 5, 0).
ubicacion(orilla_final, 10, 5).

% Capacidad de la rana: distancia máxima de salto.
salto_maximo(4.0).

% Caso base: El estado actual es la meta.
dfs(EstadoActual, _, [EstadoActual]) :-
    meta(EstadoActual).

% Caso recursivo:  Buscar un nodo sucesor tal que exista un Camino (solucion) desde ese nodo hasta meta
dfs(EstadoActual, Visitados, [EstadoActual | CaminoRestante]) :-
    % 1. Genera un posible siguiente estado.
    siguiente_estado(EstadoActual, SiguienteEstado),
    
    % 2. Asegura que el siguiente estado no ha sido visitado para evitar ciclos.
    not(member(SiguienteEstado, Visitados)),
    
    % 3. Continúa la búsqueda desde el nuevo estado.
    dfs(SiguienteEstado, [SiguienteEstado | Visitados], CaminoRestante).

    
siguiente_estado(pos(LugarActual), pos(LugarSiguiente)):-
    ubicacion(LugarActual,X1,Y1),
    ubicacion(LugarSiguiente,X2,Y2),
    XT is X2-X1,
    YT is Y2-Y1,
    D is sqrt(XT*XT+YT*YT),
	salto_maximo(N),
    D=<N.
meta(pos(orilla_final).
    
buscar_solucion(Solucion) :-
    EstadoInicial = pos(orilla_inicial),
    dfs(EstadoInicial, [EstadoInicial], Solucion). %dfs(Estado,Visitados, Solucion)