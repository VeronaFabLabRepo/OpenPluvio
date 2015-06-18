'''
file: reedTest.py
description: Reads interrupts from reed switch for debug purposes
authors: alberto valente <alberto@plumake.it>, davide grobberio <davide@plumake.it>
project: OpenPluvio an OpenSource tipping bucket rain gauge
version: 1.0
organization: Verona FabLab <www.veronafablab.it>
license: CC-BY-SA

'''
from ablib import Pin
from time import sleep

def pressed():
    print "Pressed"

PB=Pin('PC0','INPUT')
PB.set_edge("falling",pressed)

#Never ending loop
i=0
while True:
    print i
    i=i+1
    sleep(0.5)
