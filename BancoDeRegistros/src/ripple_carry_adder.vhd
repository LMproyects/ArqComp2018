library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ripple_carry_adder is
	generic (n:	INTEGER:=4); --Se define 8 por defecto
	port( carry_in:	in std_logic;
			x,y:	in std_logic_vector(n-1 downto 0);
			suma:		out std_logic_vector(n-1 downto 0);
			carry_out: out std_logic
	); 
end entity;

Architecture behavioral of ripple_carry_adder is
--defino el componente full adder
	component full_adder
	port 
		(
			a	   : in STD_LOGIC;
			b	   : in STD_LOGIC;
			cin	: in STD_LOGIC;
			cout	: out STD_LOGIC;
			S  : out STD_LOGIC
		);
	end component;
signal aux: std_logic_vector (n downto 0);

begin
aux(0)<= carry_in; --se asigna el carry de entrada a la señal auxiliar
carry_out<= aux(n);-- se asigna el carry de salida

--instacio los full adder necesarios dependiendo de n

full_a: for i in 0 to n-1 generate
					full_adder_i: full_adder port map (x(i),y(i),aux(i),aux(i+1),suma(i));
				end generate;
				
end behavioral;
