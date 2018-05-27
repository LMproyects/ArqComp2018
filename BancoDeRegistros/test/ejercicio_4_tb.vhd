-- Autor: Marcos Postemsky
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ejercicio_4_tb IS
END ejercicio_4_tb;
 
ARCHITECTURE behavior OF ejercicio_4_tb IS 
 
    --Declaracion del componente 

    COMPONENT ejercicio_4 
    	generic (ancho:	INTEGER:=6); --Se define 2 por defecto
		port( a_in,b_in:	in std_logic_vector(ancho-1 downto 0);
				y_or,y_and,y_not:		out std_logic_vector(ancho-1 downto 0)
	); 
	END COMPONENT;
	
	constant ancho : integer := 8;
	signal a,b,y_and,y_or,y_not: std_logic_vector(ancho-1 downto 0);

	
	
	begin
	--instancio
	uut: ejercicio_4 generic map (ancho)
			port map(a,b,y_or,y_and,y_not);
	 -- Stimulus process
   stim_proc: process
   begin		

		a<="00010101";
		b<="01001000";
      wait for 100 ns;
		a<="01011010";
		b<="10000110";
      wait for 100 ns;
		a<="00010011";
		b<="01010111";
      wait for 100 ns;
		a<="00011001";
		b<="11100001";
		wait for 100 ns;
		a<="00101101";
		B<="00111111";
      wait for 100 ns;
		A<="00011111";
		B<="10000101";
      wait for 100 ns;
		A<="10000011";
		B<="11110000";
      wait for 100 ns;
		A<="11110101";
		B<="10101010";
		wait for 100 ns;
		A<="01110101";
		B<="10111011";
		wait for 100 ns;
		A<="11110101";
		B<="10101111";
		wait for 100 ns;
		A<="00000111";
		B<="10101010";
			
      wait;
   end process;
	
	
	end;
	