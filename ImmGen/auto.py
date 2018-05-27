#!/usr/bin/python
# Autor: Villarreal Luciano

#-----------------------------

# Programa que crea automaticamente los archivos Manifest.py de hdl para ghdl y gtkwave.

# Se debe organizar el proyecto de la siguiete manera, respetando las capetas.
# Proyecto
# |__ auto.py
# |__ src
# |   |__ CodigoFuente1.vhd
# |   |__ CodigoFuente2.vhd
# |   |__   ...
# |   |__ codigoFuenteN.vhd
# |__ test
#     |__ testbench.vhd
#-----------------------------
# En la carpeta sim se generan los archivos relacionados a la simulacion.
# En la carpeta src se deben guardar los archivos fuente.
# En la carpeta test se debe guardar el testbench.

import os
import sys 
import subprocess, shlex

# En src se deben colocar los nombres de los archivos fuente sin extension 
src = ['RippleCarryAdder','FullAdder']

# En tb se debe colocar el nombre del testbench sin extension
tb = 'RippleCarryAdder_tb'

#En time se indica el tiempo de simulacion en microsegundos
time = 1000

# Se crea el Manifest.py en carpeta src
f = open('src/Manifest.py','w')
f.write('files = [ \n ')

for i in range(0,len(src)-1):
	f.write('"%s.vhd", '%(src[i]))
	#f.write(src[i]+'.vhd')
	#f.write('", ') 

f.write('"')
f.write(src[len(src)-1]+'.vhd')
f.write('"\n]\n') 
f.close();

# Se crea el Manifest.py en carpeta test
f = open('test/Manifest.py','w')
f.write('files = [ \n "%s.vhd", \n]\n' %(tb))
f.write('\nmodules = {\n "local" : [ "../src"],\n}\n')
f.close()

# Se crea el Manifest.py en la carpeta sim (simulacion)
# Si la carpeta sim no existe, la crea.
if not os.path.exists("sim"):
	os.mkdir("sim")

f = open('sim/Manifest.py','w')
f.write('action = "simulation"\nsim_tool = "ghdl"\nsim_top = "%s"\n' %(tb))
f.write('\nsim_post_cmd = "ghdl -r %s --stop-time=%dus --vcd=%s.vcd; gtkwave %s.vcd"\n' %(tb,time,tb,tb))
f.write('\nmodules = {\n  "local" : [ "../test" ],\n}\n')

f.close()

subprocess.call(shlex.split('cd ..'))