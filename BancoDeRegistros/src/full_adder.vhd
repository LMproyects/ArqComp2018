-- Full Adder
-- Autor: Marcos Postemsky 


--Lógica del full adder
-- cin | a | b || S | Cout
--   0 | 0 | 0 || 0 | 0
--   0 | 0 | 1 || 1 | 0
--   0 | 1 | 0 || 1 | 0
--   0 | 1 | 1 || 0 | 1
--   1 | 0 | 0 || 1 | 0
--   1 | 0 | 1 || 0 | 1
--   1 | 1 | 0 || 0 | 1
--   1 | 1 | 1 || 1 | 1

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is

	port 
	(
		a	   : in STD_LOGIC; 
		b	   : in STD_LOGIC;
		cin	: in STD_LOGIC;
		cout	: out STD_LOGIC;
		S  : out STD_LOGIC
	);

end entity;

architecture behavioral of full_adder is
signal aux: STD_LOGIC;
begin

aux <= a xor b;
S <= cin xor (aux); --salida de la suma de a + b.
cout <= (aux and cin) or (a and b) ; -- carry de salida
 
end behavioral;
