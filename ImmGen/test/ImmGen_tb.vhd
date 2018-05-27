LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ImmGen_tb IS
  GENERIC(
    clk_period : integer := 10 ns);  -- periodo del clock
    
END ENTITY ImmGen_tb;


ARCHITECTURE Behavioral OF ImmGen_tb IS
	-- Se declara el componente ImmGen
	component ImmGen is
		GENERIC(
   			len_i : integer;  -- Longitud de la instruccion de entrada
    		len_o : integer);  -- Longitud de la instruccion de salida
    	PORT(
      		Inst_i : IN     std_logic_vector(len_i - 1 downto 0);  -- Instruccion de entrada
      		Inmed_o : OUT    std_logic_vector(len_o - 1 downto 0);  -- Inmediato de salida  
      		CLK_i: IN std_logic); -- clock
	end component;  
	
	CONSTANT In_width : integer := 32;  -- Longitud de palabra de entrada
	CONSTANT Out_width : integer := 64;  -- Longitud de palabra de salida
	
	SIGNAL Inst_i : std_logic_vector(In_width - 1 downto 0);
	SIGNAL Inst_o : std_logic_vector(Out_width - 1 downto 0);
	SIGNAL CLK_i: std_logic;
	
BEGIN
	
	uut: ImmGen generic map(len_i len_o)
				port map(Inst_i, Inst_o, CLK_i)

END ARCHITECTURE Behavioral; -- Of entity ImmGen_tb
