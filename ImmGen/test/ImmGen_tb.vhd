LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY ImmGen_tb IS  
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
	               
	--constante que determina el periodo del clock
   constant CLK_i_period : time := 30 ns;

	
BEGIN
	
	uut: ImmGen generic map(In_width, Out_width)
				port map(Inst_i, Inst_o, CLK_i); 
				
	proc_clk : PROCESS IS
	BEGIN
	  	CLK_i <= '0';
		wait for CLK_i_period/2;
		CLK_i <= '1';
		wait for CLK_i_period/2;
	   
	END PROCESS proc_clk;
	
	estimulos : PROCESS IS
	  -- Put declarations here.
	BEGIN
	--seteo la señal de entrada en cero        
		Inst_i <= (OTHERS => '0');
		-- Primero asigno todos los opcode para los I-type. 
		Inst_i(6 downto 0) <= "0000011";
		Inst_i(31 downto 20)<= "110110110111";             
		wait for 100 ns;
						
	    Inst_i(6 downto 0) <= "0010011";
		Inst_i(31 downto 20)<= "011010000111";            
		wait for 100 ns;	
		wait;	
		
	END PROCESS estimulos;
	
	

END ARCHITECTURE Behavioral; -- Of entity ImmGen_tb
