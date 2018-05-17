# Arquitectura de Computadoras 2018

## Integrantes:
	*Villarreal Luciano (@lvillarreal)
	*Postemsky Marcos (@marcospostemsky)


## Banco de registros
Dentro de la carpeta src "bank_reg.vhd" describe el comportamiento del banco de registros, y dentro de la carpeta test_src se encuentra "bank_reg_tb.vhd", vhdl que describe el Test Bench utilizado para comprobar el funcionamiento del banco de registros.
El banco de registros está descripto de manera genérica, aunque por defecto se definió con un ancho de registro de 64 bits, y una cantidad de 32 registros.

### Comportamiento del banco de registros

El banco de registros siempre lee, es decir, en cada pulso de clock a la salida se tendrán los registros que se encuentran en la dirección A y B. Solo cambia su comportamiento cuando se activa la entrada Reg_W_i. La siguiente tabla describe de una mejor manera el comportamiento.

Entradas  | Comportamiento del banco de registros
--------  | -------------------------------------
Reg_W_i=0 | A la salida se tienen los registros de 64 bits ubicados en la dirección A y B.
Reg_W_i=1 | Igual que Reg_W_i=0, y además escribe en la dirección C, el dato de 64 bits ingresado por W_c_i.

### Definicion de puertos del bloque
Se definen 2 variables genéricas: 
**n_reg y bit_dir_reg.** 
Se las inicializa con los valores 64 y 5 respectivamente.

Puerto | Descripción
-------|-----------
A_i, B_i, C_i | Entradas de _bit_dir_reg_ bits.
Reg_W_i, CLK_i | Entradas de 1 bit.
W_c_i | Entrada de _n_dir_ bits.
R_a_o, R_b_o | Salidas de _n_dir_ bits.

