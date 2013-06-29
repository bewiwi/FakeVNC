#!/usr/bin/python
import os
import sys
import socket   
import ConfigParser

os.chdir(os.path.dirname(os.path.abspath(sys.argv[0])))
config = ConfigParser.ConfigParser()

config.add_section('Fake')
config.set('Fake','port','5900')
config.set('Fake','host','localhost')
config.set('Fake','command','echo $ip')

config.read('fakeVnc.conf')
config.read(['/etc/fakeVnc.conf','./fakeVnc.conf'])


s = socket.socket() 
s.bind((config.get('Fake','host'), config.getint('Fake','port')))
s.listen(5)        

while True:
    try:
        c, addr = s.accept()
        print 'Got connection from', addr
        ip = addr[0]
        os.putenv('ip',ip)
        os.system( config.get('Fake','command') )
        c.send('Oh My god a Naab\n')
        c.close()          
    except:
        pass
