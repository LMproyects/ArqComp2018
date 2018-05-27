# Bloque ImmGen
El bloque ImmGen, en grandes rasgos, es el encargado de tomar el valor inmediato desde la instrucción y extender su longitud a 64 bits, respetando el signo. Es decir, si es un valor en complemento a 2 negativo, el cual comienza con '1', el bloque debe extender el signo con el valor '1'.

