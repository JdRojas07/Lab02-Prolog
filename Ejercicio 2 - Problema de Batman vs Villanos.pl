power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).

villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).

dfs(estado([],_,_), _).

% Caso recursivo:  Buscar un nodo sucesor tal que exista un Camino (solucion) desde ese nodo hasta meta
dfs(EstadoActual, Visitados) :-
    % 1. Genera un posible siguiente estado.
    siguiente_estado(EstadoActual, SiguienteEstado),
    
    % 2. Asegura que el siguiente estado no ha sido visitado para evitar ciclos.
    not(member(SiguienteEstado, Visitados)),
    
    % 3. Continúa la búsqueda desde el nuevo estado.
    dfs(SiguienteEstado, [SiguienteEstado | Visitados]).

siguiente_estado(estado([Villano_actual|Villano_restantes],[_|Superpoder_restantes],Energia), estado([Villano_actual|Villano_restantes],Superpoder_restantes,Energia)).

siguiente_estado(estado([villain(_,HP, Weakness)|Villano_restantes],[power(Pname, Dano, Penergia)|Superpoder_restantes],EnergiaActual), estado(Villano_restantes, Superpoder_restantes, Nueva_energia)):-
    member(Pname, Weakness),
    Dano >= HP,                     
    EnergiaActual >= Penergia,      
    Nueva_energia is EnergiaActual - Penergia.
     

batman_can_win(EnergiaMaxima) :-
    power_list(Superpoderes),
    villain_list(Villanos),
    % El estado inicial contiene todos los villanos, todos los poderes y la energía máxima.
    EstadoInicial = estado(Villanos, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]). %dfs(Estado,Visitados)