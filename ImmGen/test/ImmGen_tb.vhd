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
   constant CLK_i_period : time := 20 ns;

	
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
		wait for 50 ns;
						
	    Inst_i(6 downto 0) <= "0010011";
		Inst_i(31 downto 20)<= "011010000111";            
		wait for 50 ns;	
		
		Inst_i(6 downto 0)<= "1100111";
		Inst_i(31 downto 20)<= "110000111111"
        --*****************************************************--
		-- Opcode para los S-type
		Inst_i(6 downto 0)<= "0100011";
		
		-- Inmediato del bit 11 al 5
		Inst_i(31 downto 25)<="1101010";
		--inmediato del bit 4 al 0
		Inst_i(11 downto 7)<="01011";
		wait for 50 ns;
		-- Inmediato del bit 11 al 5
		Inst_i(31 downto 25)<="0110010";
		--inmediato del bit 4 al 0
		Inst_i(11 downto 7)<="11100";
		wait for 50 ns;
		--*****************************************************--
		-- Opcode para los SB-type
		Inst_i(6 downto 0)<= "1100011";
		--inmediato 12
		Inst_i(31)<='1';
		-- Inmediato 11
		Inst_i(7)<='0';
		--Inmediato del 10 al 5
		Inst_i(30 downto 25)<= "010111";
		--Inmediato del 4 al 1
		Inst_i(11 downto 8)<= "1000";
		wait for 50 ns;
		   
		--inmediato 12
		Inst_i(31)<='0';
		-- Inmediato 11
		Inst_i(7)<='1';
		--Inmediato del 10 al 5
		Inst_i(30 downto 25)<= "111111";
		--Inmediato del 4 al 1
		Inst_i(11 downto 8)<= "1000";
		wait for 50 ns;
		
		--*****************************************************--
		--Opcode para U-Type
		Inst_i(6 downto 0)<="0110111";
		--inmediato del 31 al 12
		Inst_i(31 downto 12)<="11001111010101111000";
		wait for 50 ns;
		
		--inmediato del 31 al 12
		Inst_i(31 downto 12)<="01111100010101111000";
		wait for 50 ns;
		
		--*****************************************************--
		--Opcode para UJ-type
		Inst_i(6 downto 0)<="1101111";
		--Inmediato 20
		Inst_i(31)<='1';
		--Inmediato 19 al 12
		Inst_i(19 downto 12)<="10101111";
		--Inmediato 11
		Inst_i(11)<='0';
		--Inmediato del 10 al 1
		Inst_i(30 downto 21)<="1100111111";
		wait for 50 ns;
		
		--Inmediato 20
		Inst_i(31)<='0';
		--Inmediato 19 al 12
		Inst_i(19 downto 12)<="10101111";
		--Inmediato 11
		Inst_i(11)<='1';
		--Inmediato del 10 al 1
		Inst_i(30 downto 21)<="1100111111";
		wait for 50 ns;
		               
		--****************************************************--
		--Opcode para type-R (La salida del bloque no deberia cambiar)
		Inst_i(6 downto 0)<="0110011";
		wait;	


		
	END PROCESS estimulos;
	
	

END ARCHITECTURE Behavioral; -- Of entity ImmGen_tb
