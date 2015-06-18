'''
file: ws.py
description: Tornado based webserver for OpenPluvio project
authors: alberto valente <alberto@plumake.it>, davide grobberio <davide@plumake.it>
project: OpenPluvio an OpenSource tipping bucket rain gauge
version: 1.0
organization: Verona FabLab <www.veronafablab.it>
license: CC-BY-SA

'''


import tornado.ioloop
import tornado.web
import time
import sys
import os
from datetime import datetime
import StringIO
import thread
import threading
import sqlite3
import json

DBNAME = '/var/www/OpenPluvio/db/openpluvio'
port = 8888

class main_page(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, world")

class get_monthly_mm(tornado.web.RequestHandler):
    def get(self):
        mese = self.get_argument("mese", default=1)
        anno = self.get_argument("anno", default=2015)
        connection = sqlite3.connect(DBNAME)
        cursor = connection.cursor()
        cursor.execute('SELECT count_2_mm FROM parameters')
        count_2_mm = cursor.fetchone()
        count_2_mm = float(count_2_mm[0])
        cursor.execute('SELECT strftime(\'%d\', t_timestamp ), count(id) \
        FROM "basculate" \
        WHERE strftime(\'%m\', t_timestamp )=? \
        AND strftime(\'%Y\', t_timestamp )=? \
        GROUP BY strftime(\'%d\', t_timestamp )',(mese,anno,))
        basculate = cursor.fetchall()
        connection.commit()
        connection.close()
        print basculate
        basc_return = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0],\
        [10,0],[11,0],[12,0],[13,0],[14,0],[15,0],[16,0],[17,0],[18,0],[19,0],\
        [20,0],[21,0],[22,0],[23,0],[24,0],[25,0],[26,0],[27,0],[28,0],[29,0],\
        [30,0],[31,0]]
        for i in basculate:
            basc_return[int(i[0])-1][1] = round(int(i[1])*count_2_mm,2)
        self.write({'basculate':basc_return})
        
class get_daily_mm(tornado.web.RequestHandler):
    def get(self):
        giorno = self.get_argument("giorno", default=1)
        mese = self.get_argument("mese", default=1)
        anno = self.get_argument("anno", default=2015)
        connection = sqlite3.connect(DBNAME)
        cursor = connection.cursor()
        cursor.execute('SELECT count_2_mm FROM parameters')
        count_2_mm = cursor.fetchone()
        count_2_mm = float(count_2_mm[0])
        cursor.execute('SELECT strftime(\'%H\', t_timestamp ), count(id) \
        FROM "basculate" \
        WHERE strftime(\'%d\', t_timestamp )=? \
        AND strftime(\'%m\', t_timestamp )=? \
        AND strftime(\'%Y\', t_timestamp )=? \
        GROUP BY strftime(\'%H\', t_timestamp )',(giorno,mese,anno,))
        basculate_d = cursor.fetchall()
        connection.commit()
        connection.close()
        print basculate_d
        basculate_d_return = [[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],\
        [8,0],[9,0],[10,0],[11,0],[12,0],[13,0],[14,0],[15,0],[16,0],[17,0],\
        [18,0],[19,0],[20,0],[21,0],[22,0],[23,0]]
        for i in basculate_d:
            basculate_d_return[int(i[0])+1][1] = round(int(i[1])*count_2_mm,2)
        self.write({'basculate':basculate_d_return})
        
        
        
SETTINGS = {
    "debug" : True
}

root = os.path.join(os.path.dirname(__file__), "pages")
application = tornado.web.Application([
    (r"/get_daily_mm", get_daily_mm),
    (r"/get_monthly_mm", get_monthly_mm),
    (r'/(.*)', tornado.web.StaticFileHandler, {"path": root,"default_filename": "index.html"})
],**SETTINGS)



if __name__ == "__main__":
	application.listen(port,"0.0.0.0")
	tornado.ioloop.IOLoop.instance().start() 
	

