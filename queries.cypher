// Quais são as rotas existentes para ir do Brasil para Itália, sem utilizar o aeroporto de Guarulhos (GRU)?
MATCH r=(p1:Pais)<-[:do_pais]-()<-[:fica_em]-(a1:Aeroporto)-[:faz_conexao_com]->(a2:Aeroporto)-[:fica_em]->()-[:do_pais]->(p2:Pais)
WHERE p1.pais = 'Brazil' AND p2.pais = 'Italy' AND NOT a1.codigo='GRU'
RETURN r;
// Quais são os aeroportos situados no Rio de Janeiro?
MATCH r=(a:Aeroporto)-[:fica_em]-(c:Cidade {cidade: 'Rio De Janeiro'})
RETURN r;
//Quais companhias aéreas possuem passagens para o aeroporto de Brasília e também para cidade de Tokyo?
MATCH r=(a1:Aeroporto)<-[:oferece_voo_para]-(c:Companhia)-[:oferece_voo_para]->()-[:fica_em]->(c2:Cidade)
WHERE a1.codigo = 'BSB' AND c2.cidade = 'Tokyo'
RETURN r;
//Quais companhias aéreas brasileiras operam na ponte aérea Rio SP?
MATCH r=(p:Pais)<-[:com_sede_em]-()-[:oferece_voo_para]->()-[:fica_em]->(c:Cidade)
WHERE p.pais = 'Brazil' AND c.cidade in ['Sao Paulo', 'Rio De Janeiro']
RETURN r;
//Saindo de Curitiba, qual o mínimo de cidades que preciso passar para chegar em Sydney?
MATCH r=allShortestPaths((c1:Cidade)-[*]->(c2:Cidade))
WHERE c1.cidade= 'Curitiba' AND c2.cidade = 'Sydney'
RETURN r;
//Quais países possuem cidades com rotas diretas para cidades brasileiras?
MATCH r=(p1:Pais)<-[:do_pais]-()-[:tem_rota_com]->()-[:do_pais]->(p2:Pais)
WHERE p1.pais <> 'Brazil' AND p2.pais = 'Brazil'
RETURN p1;
//Quais são as cidades estrangeiras que companhias aéreas brasileiras voam?
MATCH (p1:Pais)<-[:com_sede_em]-()-[:oferece_voo_para]->()-[:fica_em]->(c:Cidade)-[:do_pais]->(p2:Pais)
WHERE p1.pais = 'Brazil' AND p2.pais <> 'Brazil'
RETURN c, p2
LIMIT 50;