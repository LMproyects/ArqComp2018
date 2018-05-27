-- Autor: Marcos Postemsky
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Cuadro funcionamiento

-- control | operacion (y)
-- --------------------
-- "000"	  | not a_in
-- "001"	  | a_in and b_in
-- "010"	  | a_in or b_in
-- "011"	  | a_in + b_in
-- "100"	  | a_in - b_in
 


entity Alu_with_sus is
	generic (ancho:	INTEGER:=6); --Se define 2 por defecto
	port( a_in,b_in:	in std_logic_vector(ancho-1 downto 0);
			control:		in std_logic_vector(2 downto 0); 
			y:		out std_logic_vector(ancho-1 downto 0)
	); 
end entity;

Architecture behavioral of Alu_with_sus is
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
	
	component ripple_carry_adsustr
		generic (n:	INTEGER:=4); --Se define 8 por defecto
		port( x,y:	in std_logic_vector(n-1 downto 0);
			sum_rest: in std_logic;
			result:		out std_logic_vector(n-1 downto 0);
			carry_out: out std_logic
		); 
	end component;

signal a_x,b_x, y_not, y_or,y_and,y_ripple : std_logic_vector(ancho-1 downto 0);
signal aux_s_r,aux_c_out:	std_logic;

begin


--instacio los full adder necesarios dependiendo de n
comp_not:not_nbits generic map (ancho)
			port map(a_x,y_not);
			
comp_and: and_nbits generic map (ancho)
			port map(a_x,b_x,y_and);
			
comp_or: or_nbits generic map (ancho)
			port map(a_x,b_x,y_or);
compo_ripple: ripple_carry_adsustr generic map (ancho)
					port map (a_x,b_x,aux_s_r,y_ripple,aux_c_out);
	

	
a_x <= a_in;
b_x <= b_in;

-- condicion suma-resta para el componente ripple_carry_adsustr
aux_s_r <= '1' when control="100" else '0';

with control select 
y <= y_not when "000",
	  y_and when "001",
	  y_or when "010",
	  y_ripple when "011",
	  y_ripple when "100",
	  a_x when others;
				
end behavioral;
