CALL gds.graph.project(
  'betCentrality',
  'Cidade',
  'tem_rota_com'
);
CALL gds.betweenness.stream('betCentrality')
YIELD nodeId, score
RETURN
    nodeId,
    gds.util.asNode(nodeId).cidade as cidade,
    score
ORDER BY score DESC
LIMIT 5;