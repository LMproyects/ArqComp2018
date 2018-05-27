-- Autor: Marcos Postemsky
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ejercicio_4 is
	generic (ancho:	INTEGER:=6); --Se define 2 por defecto
	port( a_in,b_in:	in std_logic_vector(ancho-1 downto 0);
			y_or,y_and,y_not:		out std_logic_vector(ancho-1 downto 0)
	); 
end entity;

Architecture behavioral of ejercicio_4 is
--defino los componentes not, and y or
	component not_nbits
		generic (n:	INTEGER:=2);
		port 
		(	a	   : in std_logic_vector(n-1 downto 0);
			y		: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component and_nbits
		generic (n:	INTEGER:=2);
		port 
		(	a	   : in std_logic_vector(n-1 downto 0);
			b	   : in std_logic_vector(n-1 downto 0);
			y		: out std_logic_vector(n-1 downto 0)
		);
	end component;
	
	component or_nbits
		generic (n:	INTEGER:=2);
		port 
		(	a	   : in std_logic_vector(n-1 downto 0);
			b	   : in std_logic_vector(n-1 downto 0);
			y		: out std_logic_vector(n-1 downto 0)
		);
	end component;

signal a_x,b_x : std_logic_vector(ancho-1 downto 0);

begin


--instacio los full adder necesarios dependiendo de n
comp_not:not_nbits generic map (ancho)
			port map(a_x,y_not);
			
comp_and: and_nbits generic map (ancho)
			port map(a_x,b_x,y_and);
			
comp_or: or_nbits generic map (ancho)
			port map(a_x,b_x,y_or);
			
a_x <= a_in;
b_x <= b_in;
				
end behavioral;
