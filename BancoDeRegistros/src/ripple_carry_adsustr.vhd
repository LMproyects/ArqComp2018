library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ripple_carry_adsustr is
	generic (n:	INTEGER:=4); --Se define 8 por defecto
	port( x,y:	in std_logic_vector(n-1 downto 0);
			sum_rest: in std_logic;
			result:		out std_logic_vector(n-1 downto 0);
			carry_out: out std_logic
	); 
end entity;

Architecture behavioral of ripple_carry_adsustr is
--defino el componente full adder
	component full_adder
	port 
		(	a	   : in STD_LOGIC;
			b	   : in STD_LOGIC;
			cin	: in STD_LOGIC;
			cout	: out STD_LOGIC;
			S  : out STD_LOGIC
		);
	end component;
signal aux: std_logic_vector (n downto 0);
signal h: std_logic_vector (n-1 downto 0);
signal carry_in: std_logic;


begin
-- si sum_rest es igual a 0 se suma x+h, sino se resta x-h.

h<= not y when sum_rest='1'else y;
	
carry_in <= '1' when sum_rest='1' else '0';

aux(0)<= carry_in; --se asigna el carry de entrada a la señal auxiliar
carry_out<= aux(n);-- se asigna el carry de salida

--instacio los full adder necesarios dependiendo de n

full_a: for i in 0 to n-1 generate
					full_adder_i: full_adder port map (x(i),h(i),aux(i),aux(i+1),result(i));
				end generate;
				
end behavioral;