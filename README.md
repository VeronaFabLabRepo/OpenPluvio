# README #

OpenPluvio is an OpenSource (both hardware and software) project for a DIY tipping bucket rain gauge.
This project has been developed at [Verona FabLab](http://www.veronafablab.it) in Verona, Italy.

OpenPluvio at the moment is not localized since it is still in an early stage of development.
Feel free to contact us for clarifications and for more info about the project and our activities.

From now on.. italian! ;-)

### Progetto OpenPluvio ###

Il progetto OpenPluvio è composto da un pluviometro realizzato utilizzano semplici materiali reperibili 
in ferramenta e con alcuni componenti stampabili in 3D.
Le istruzioni per la costruzione sono disponibili su questo [wiki](http://167.88.40.66/OpenResmia/wiki)

La parte elettronica del pluviometro è composta da un modulo Linux Embedded "Arietta G25" prodotto da
[ACME Systems](http://acmesystems.it/) a cui è collegata una batteria tampone CR2032 per mantenere 
alimentato il Real Time Clock interno ed un sensore magnetico reed in grado di rilevare i colpi della 
bascula stampata in 3D.

### Software ###

La parte software di OpenPluvio è composta dai seguenti componenti:

* un database SQLite per memorizzare le basculate
* un servizio python che salva sul database il timestamp corrente ad ogni basculata
* una single page application HTML5-CSS3-Angularjs per la visualizzazione dei dati
* un webserver scritto in python usando Tornado per gestire i comandi ricevuti dalla webpage

Spiegazione di alcuni file presenti nella directory principale

* rc.local: il suo contenuto va in /etc/rc.local per avviare al boot il programma python e la wifi hotspot
* hostap.conf: contiene le configurazioni per la creazione dell'hostpot wifi

### Funzionamento ###
Il pluviometro va esposto a campo. Ad ogni basculata verrà salvato sul database il timestamp corrente.

Per accedere ai dati bisogna collegarsi con smarphone/tablet/pc alla wifi aperta "OpenPluvio" generata 
da OpenPluvio e puntare il browser su 192.168.10.10:8888 per visualizzare la pagina principale.

### Deploy ###

* collegare Arietta con cavo USB al proprio pc
* seguire le istruzioni "getting started" sul sito [ACME Systems](http://www.acmesystems.it)
* `sudo dd if=arietta_ledpanel.img of=/dev/sdb`
* `ssh root@192.168.10.10` con password `acmesystems`
* `nano /etc/resolv.conf` cambiare ip gateway se necessario
* `ping www.plumake.it` per testare la connessione verso l'esterno
* `/etc/init.d/ntp restart`
* `date` per controllare che la data sia corretta
* `apt-get update && apt-get install sqlite php5-sqlite python-smbus` per installare le dipendenze
* `cd /var/www/`
* `git clone git://github.com/tanzilli/ablib.git`
* `cd ablib`
* `python setup.py install`
* `cd ..`
* `git clone https://github.com/VeronaFabLabRepo/OpenPluvio.git`
* `cp OpenPluvio/rc.local /etc/rc.local`
* `shutdown -r now`
*  testare che venga creata una wifi hotspot con essid "OpenPluvio"
*  connettersi a 192.168.10.10:8888

### Come contribuire ###

Il progetto è in una fase molto primitiva di sviluppo, sono stati realizzati i primi prototipi funzionanti.

Se il progetto ti piace il tuo contributo è molto gradito sia in termini di software che di hardware.

### Licenze

* License: Creative Commons Attribution-ShareAlike 4.0 International
* Human Readable License: http://creativecommons.org/licenses/by-sa/4.0/
* Complete Legal Terms: http://creativecommons.org/licenses/by-sa/4.0/legalcode

### Contatti ###

La parte meccanica del progetto è stata realizzata da Fabio Righetti <fabio@plumake.it>

La parte elettronica da Alberto Valente <alberto@plumake.it>

La parte software da Alberto Valente <alberto@plumake.it> e Davide Grobberio <davide@plumake.it>

Il progetto è stato incubato dall'[Associazione Verona FabLab](http://www.veronafablab.it)
