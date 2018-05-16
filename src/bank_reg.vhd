-- Se realiza un banco de registros, con las siguientes entradas A_i, B_i, C_i y W_c_i
-- Salidas: R_a_o y R_b_o.
library ieee;            

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY bank_reg IS
  GENERIC(
    n_reg : integer := 64;  -- cantidad de bits registros
    bit_dir_reg : integer := 5);  -- cantidad de bits de direccionamiento a registros
    PORT(
      A_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);
      B_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);
      C_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);    
      Reg_W_i: IN		std_logic;
      CLK_i : IN     std_logic;
      W_c_i : IN     std_logic_vector(n_reg-1 downto 0);
      R_a_o : OUT    std_logic_vector(n_reg-1 downto 0);
      R_b_o : OUT    std_logic_vector(n_reg-1 downto 0));
END ENTITY bank_reg;

ARCHITECTURE Behavioral OF bank_reg IS
 -- Declaramos una matriz como memoria       
TYPE ram_memory IS ARRAY ( 2**bit_dir_reg-1 downto 0 ) OF std_logic_vector(n_reg-1 downto 0);
signal Memoria_ram: ram_memory;
	
BEGIN

Registros : PROCESS (CLK_i) IS
BEGIN
  IF (rising_edge(CLK_i))  THEN
	R_a_o <= Memoria_ram(to_integer(unsigned(A_i)));  	  
    R_b_o <= Memoria_ram(to_integer(unsigned(B_i)));
    
    IF (Reg_W_i = '1') THEN
    	Memoria_ram(to_integer(unsigned(C_i))) <= W_c_i; 
   	END IF;	 
  END IF;
END PROCESS Registros;
END ARCHITECTURE Behavioral; -- Of entity bank_reg

 
