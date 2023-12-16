CALL gds.graph.project(
  'maxInfluencia',
  'Cidade',
  'tem_rota_com'
);
CALL gds.influenceMaximization.celf.stream(
  'maxInfluencia', {seedSetSize: 5}
)
YIELD nodeId, spread
RETURN
  nodeId, 
  gds.util.asNode(nodeId).cidade as cidade,
  spread
ORDER BY spread DESC, nodeId