-- Autor: Marcos Postemsky
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity not_nbits is
	generic (n:	INTEGER:=2);
	port 
	(
		a	   : in std_logic_vector(n-1 downto 0);
		y		: out std_logic_vector(n-1 downto 0)
	);

end entity;

architecture behavioral of not_nbits is
begin

y<=not a;

end behavioral;
