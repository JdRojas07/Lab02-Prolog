% --- META: lista con 8 reinas ---
meta(Estado) :-
    length(Estado, 8).

% --- DFS ---
dfs(EstadoActual, _, EstadoActual) :-
    meta(EstadoActual).   % Caso base: ya tengo las 8 reinas

dfs(EstadoActual, Visitados, SolucionFinal) :-
    siguiente_estado(EstadoActual, SiguienteEstado),
   	\+ member(SiguienteEstado, Visitados),   % evitar repetir estados
    dfs(SiguienteEstado, [SiguienteEstado | Visitados], SolucionFinal).

% --- Generación de siguiente estado ---
siguiente_estado(EstadoActual, EstadoConNueva) :-
    length(EstadoActual, N),
    Col is N + 1,
    member(Fila, [1,2,3,4,5,6,7,8]),
    seguro(Fila, Col, EstadoActual, 1),
    append(EstadoActual, [Fila], EstadoConNueva).

% --- Verificación de seguridad (no ataques) ---
seguro(_, _, [], _).
seguro(Fila, Col, [Fprev | Resto], Cprev) :-
    Fila =\= Fprev,                         
    abs(Fila - Fprev) =\= abs(Col - Cprev),  
    Cnext is Cprev + 1,
    seguro(Fila, Col, Resto, Cnext).

% --- Solución principal ---
solucion(Solucion) :-
    EstadoInicial = [],
    dfs(EstadoInicial, [EstadoInicial], Solucion).