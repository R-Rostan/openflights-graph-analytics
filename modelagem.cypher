// Criação de constraints para garantir unicidade
CREATE CONSTRAINT UniqueAeroporto FOR (a:Aeroporto) REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT UniqueCidade FOR (c:Cidade) REQUIRE c.cidade IS UNIQUE;
CREATE CONSTRAINT UniquePais FOR (p:Pais) REQUIRE p.pais IS UNIQUE;
CREATE CONSTRAINT UniqueCompanhia FOR (c:Companhia) REQUIRE c.id IS UNIQUE;

// Criação dos nós
LOAD CSV WITH HEADERS FROM 'file:///airports.csv' AS row
MERGE (
    :Aeroporto 
    {
        id: row.airport_id,
        nome: row.airport_name,
        codigo: row.airport_code,
        latitude: row.latitude,
        longitude: row.longitude,
        altitude: row.altitude,
        cidade: row.city
    }
)
MERGE (
    :Cidade 
    {
        cidade: row.city
    }
)
MERGE (
    :Pais
    {
        pais: row.country
    }
);
LOAD CSV WITH HEADERS FROM 'file:///routes.csv' AS row
MERGE (
    :Companhia
    {
        id: row.airline_id
    }
);
LOAD CSV WITH HEADERS FROM 'file:///airlines.csv' AS row
MATCH (c:Companhia {id: row.airline_id})
SET c.nome = row.airline_name;

// Criação dos relacionamentos
LOAD CSV WITH HEADERS FROM 'file:///airports.csv' AS row
MATCH (a:Aeroporto {id: row.airport_id})
MATCH (c:Cidade {cidade: row.city})
MERGE (a)-[:fica_em]->(c);

LOAD CSV WITH HEADERS FROM 'file:///airports.csv' AS row
MATCH (c:Cidade {cidade: row.city})
MATCH (p:Pais {pais: row.country})
MERGE (c)-[:do_pais]->(p);

LOAD CSV WITH HEADERS FROM 'file:///routes.csv' AS row
MATCH (a:Aeroporto {id: row.source_airport_id})
MATCH (b:Aeroporto {id: row.destination_airport_id})
MATCH (c:Companhia {id: row.airline_id})
MATCH (c1:Cidade {cidade: a.cidade})
MATCH (c2:Cidade {cidade: b.cidade})
MERGE (c)-[:oferece_voo_para]->(b)
MERGE (c1)-[:tem_rota_com]->(c2)
MERGE (a)-[:faz_conexao_com]->(b);

LOAD CSV WITH HEADERS FROM 'file:///airlines.csv' AS row
MATCH (c:Companhia {id: row.airline_id})
MATCH (p:Pais {pais: row.country})
MERGE (c)-[:com_sede_em]->(p);