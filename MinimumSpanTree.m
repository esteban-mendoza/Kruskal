function MST = MinimumSpanTree(Graph)

% Iniciar Minimum Spanning Tree (MST) con arista de peso mínimo
MST = graph();

% Ordenar y obtener arista y peso de la arista del peso mínimo
minEdge = sortrows(Graph.Edges, 'Weight').EndNodes(1,:);
minWeight = sortrows(Graph.Edges, 'Weight').Weight(1,:);

MST = MST.addedge(minEdge(1), minEdge(2), minWeight);

% Eliminar vértice de Graph
Graph = Graph.rmedge(minEdge(1), minEdge(2));

% Mientras haya aristas en Graph, seguir iterando
while (~isempty(Graph.Edges))
    
    % subgráfica de G adyacente a MST
    subG = adjacentSubgraph(Graph, MST);
    
    % Arista de peso mínimo
    minEdge = sortrows(subG.Edges, 'Weight').EndNodes(1,:);
    minWeight = sortrows(subG.Edges, 'Weight').Weight(1,:);
    
    % Número de nodos de la arista que aparecen en el grafo
    N = countNodes(MST, minEdge);
    
    % Si ninguno o sólo uno de los nodos aparecen, agregar
    % la arista al árbol generador y borrarla de G
    if N < 2
       MST = MST.addedge(minEdge(1), minEdge(2), minWeight);
    end
    
    % Eliminar arista de G
    Graph = Graph.rmedge(minEdge(1), minEdge(2));
end

end


function subG = adjacentSubgraph(G, F)
% Obtiene la subgráfica de G con las aristas que incluyen a nodos en F
% F es una subgráfica de G

% Nodos de Graph y SubGraph
GNodes = unique(G.Edges.EndNodes);
FNodes = unique(F.Edges.EndNodes);

% Intersección de nodos
Nodes = intersect(GNodes, FNodes);

% Subgráfica resultante
subG = graph();

for i = 1:length(Nodes)
    
    % id's de aristas que incluyen a node
    eid = G.outedges(Nodes(i));
    
    % EdgeTable de las aristas que incluyen a node
    tEdges = G.Edges(eid,:);
    
    % Agregar aristas elegidas a subGraph
    subG = subG.addedge(tEdges);
end

end


function n = countNodes(G, edge)
% Cuenta el número de nodos de la arista que están en el grafo

% Conjunto de nodos en el grafo G
nodes = unique(G.Edges.EndNodes);

% Devuelve el máximo número de veces
n = sum(ismember(edge, nodes));

end
