--Autor: Marcos Postemsky
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Cuadro funcionamiento

-- control | operacion (y)
-- --------------------
-- "00"	  | not a_in
-- "01"	  | a_in and b_in
-- "10"	  | a_in or b_in
-- "11"	  | a_in + b_in

 


entity Alu_without_sus is
	generic (ancho:	INTEGER:=6); --Se define 2 por defecto
	port( a_in,b_in:	in std_logic_vector(ancho-1 downto 0);
			control:		in std_logic_vector(1 downto 0); 
			y:		out std_logic_vector(ancho-1 downto 0)
	); 
end entity;

Architecture behavioral of Alu_without_sus is
--defino los componentes not, and , or y ripple_carry_adsustr
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
	
	component ripple_carry_adder
		generic (n:	INTEGER:=4); --Se define 8 por defecto
		port( carry_in:	in std_logic;
			x,y:	in std_logic_vector(n-1 downto 0);
			suma:		out std_logic_vector(n-1 downto 0);
			carry_out: out std_logic
		);
	end component;

signal a_x,b_x, y_not, y_or,y_and,y_ripple : std_logic_vector(ancho-1 downto 0);
signal aux_s_r,aux_c_out,aux_c_in:	std_logic;

begin


--instacio los full adder necesarios dependiendo de n
comp_not:not_nbits generic map (ancho)
			port map(a_x,y_not);
			
comp_and: and_nbits generic map (ancho)
			port map(a_x,b_x,y_and);
			
comp_or: or_nbits generic map (ancho)
			port map(a_x,b_x,y_or);
compo_ripple: ripple_carry_adder generic map (ancho)
					port map (aux_c_in,a_x,b_x,y_ripple,aux_c_out);
	

	
a_x <= a_in;
b_x <= b_in;
aux_c_in<='0';

with control select 
y <= y_not when "00",
	  y_and when "01",
	  y_or when "10",
	  y_ripple when "11",
	  a_x when others;
				
end behavioral;
