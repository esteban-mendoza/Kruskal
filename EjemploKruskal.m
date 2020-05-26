% Cell con nombres de nodos
names = {'A', 'B', 'C', 'D', 'E', 'F', 'G'};

% Matriz de adyacencias
A = [0   2   3   3   0   0   0;
0   0   4   0   3   0   0;
0   0   0   5   1   0   0;
0   0   0   0   0   7   0;
0   0   0   0   0   8   0;
0   0   0   0   0   0   9;
0   0   0   0   0   0   0];

% Crear grafo no-dirigido, con pesos y nombres usando
% una matriz de adyacencias triangular superior
G = graph(A, names, 'upper');

% Crear visualización del grafo con los pesos en las etiquetas de las aristas
h = plot(G, 'EdgeLabel', G.Edges.Weight)

% Usar algoritmo de Kruskal para obtener árbol generador de peso mínimo
T = MinimumSpanTree(G);

% Sobresaltar aristas del árbol generador de peso mínimo
highlight(h, T, 'EdgeColor', 'r', 'LineWidth', 1.5)