// Algoritmo de centralidade
//     Geração de score e atribuindo resultado como atributo "centralidade" no nó Aeroporto
CALL gds.graph.project(
  'myGraph', 
  'Aeroporto', 
  {
    faz_conexao_com: {
      orientation: 'UNDIRECTED'
    }
  }
);

CALL gds.degree.stream('myGraph')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS node, score
SET node.centralidade = score;

// Quais são os 5 aeroportos com MAIS conexões?
CALL gds.degree.stream('myGraph')
YIELD nodeId, score
RETURN 
    nodeId,
    gds.util.asNode(nodeId).nome as nomeAeroporto, 
    gds.util.asNode(nodeId).codigo as codigoAeroporto,
    score as scoreCentralidade
ORDER BY score DESC
LIMIT 5;