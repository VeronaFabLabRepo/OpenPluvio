'''
file: bascula2db.py
description: Reads interrupts from reed switch and saves timestamp on db
authors: alberto valente <alberto@plumake.it>, davide grobberio <davide@plumake.it>
project: OpenPluvio an OpenSource tipping bucket rain gauge
version: 1.0
organization: Verona FabLab <www.veronafablab.it>
license: CC-BY-SA

'''

from ablib import Pin
from time import sleep
import sqlite3

DBNAME = '/var/www/OpenPluvio/db/openpluvio'

def basculata():
    connection = sqlite3.connect(DBNAME)
    cursor = connection.cursor()
    cursor.execute('insert into basculate default values')
    connection.commit()
    connection.close()

PB=Pin('PC0','INPUT')
PB.set_edge("falling",basculata)

#Never ending loop
while True:
    sleep
   
