-- Autor: Marcos Postemsky
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_nbits is
	generic (n:	INTEGER:=2);
	port 
	(
		a	   : in std_logic_vector(n-1 downto 0);
		b	   : in std_logic_vector(n-1 downto 0);
		y		: out std_logic_vector(n-1 downto 0)
	);

end entity;

architecture behavioral of or_nbits is
begin

y<=a or b;

end behavioral;
