import requests
import pandas as pd
import os

path = os.path.dirname(__file__)

urls = [
    ('https://raw.githubusercontent.com/jpatokal/openflights/master/data/routes.dat', 'routes.csv'),
    ('https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat', 'airports.csv'),
    ('https://raw.githubusercontent.com/jpatokal/openflights/master/data/airlines.dat', 'airlines.csv'),
]

try:
    for f in os.listdir(os.path.join(path, 'data')):
        os.remove(os.path.join(path, 'data', f))
    os.rmdir(os.path.join(path, 'data'))
    os.mkdir(os.path.join(path, 'data'))
except:
    os.mkdir(os.path.join(path, 'data'))

for url in urls:
    destino_local = os.path.join(path, 'data', url[1])
    response = requests.get(url[0])
    if response.status_code == 200:
        with open(destino_local, 'wb') as arquivo:
            if url[1] == 'routes.csv':
                arquivo.write(b'"companhia","airline_id","source_airport_code","source_airport_id","destination_airport_code","destination_airport_id","codeshare","stops","equipment"\n')
                arquivo.write(response.content)
            elif url[1] == 'airlines.csv':
                arquivo.write(b'"airline_id","airline_name","alias","iata","icao","indicativo","country","active"\n')
                arquivo.write(response.content)
            else:
                arquivo.write(b'"airport_id","airport_name","city","country","airport_code","icao","latitude","longitude","altitude","timezone","dst","tz","type","source"\n')
                arquivo.write(response.content)