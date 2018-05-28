
# Arquitectura de computadoras 2018

## Integrantes:
* Villarreal Luciano (@lvillarreal)
* Postemsky Marcos (@marcospostemsky)

## Bloque ImmGen
El **bloque ImmGen**, es el encargado de tomar el valor inmediato desde la instrucción y extender su longitud a 64 bits, extendiendo el signo. Es decir, si bit más significativo del valor inmediato es igual a '1', el bloque debe extender el signo con el valor '1', hasta completar los 64-MSB bits restantes.

La extensión de signo es una de las operaciones más críticas en inmediatos (particularmente en RV64I), y en RISC-V el bit de signo para todos los inmediatos siempre se mantiene en el bit 31 de la instrucción para permitir que la extensión de signo avence en paralelo con la decodificación de instrucciones.

### Funcionamiento del bloque ImmGen
El bloque ImmGen tiene como señal de entrada la instrucción de **32 bits** que proviene de la memoria de programa, y como salida la señal inmediata de **64 bits** con signo extendido. Se debe tener en cuenta que el valor del inmediato que contiene la instrucción depende del tipo de la misma, el siguiente cuadro describe como se conforma la señal de salida, dependiendo del tipo de instrucción.

![Imagen tabla inmediato](https://github.com/LMproyects/ArqComp2018/blob/master/ImmGen/images/tabla_inmediato.png)

Por último, mencionamos cuales son los opcode que referencian a cada tipo de instrucción.

Tipo de Instrucción | Opcode
--------------------|-------
I-Type | 0000011
I-Type | 0010011
I-Type | 1100111
S-Type | 0100011
SB-Type | 1100011
U-Type | 0110111
UJ-Type | 1101111