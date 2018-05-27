-- Postemsky Marcos
--Test bench para full adder

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY fulladder_tb IS
END fulladder_tb;
 
ARCHITECTURE behavior OF fulladder_tb IS 
 
    -- Declaracion del componente
 
    COMPONENT full_adder
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         cin : IN  std_logic;
			cout : OUT  std_logic;
         S : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal cin : std_logic := '0';

 	--Outputs
   signal S : std_logic;
   signal cout : std_logic;

 
   
 
BEGIN
 
	-- Instanciamos la unidad
   uut: full_adder PORT MAP (
          a => a,
          b => b,
          cin => cin,
          S => S,
          cout => cout
        );

  
 
	-- Estimulos
   stim_proc: process
   begin		
   cin<= '0';
		a<='0';
      wait for 50 ns;
		b<='0';
      wait for 50 ns;
		--------------------
		a<='0';
      wait for 50 ns;
		b<='1';
      wait for 50 ns;
		--------------------
		a<='1';
      wait for 50 ns;
		b<='0';
      wait for 50 ns;
		--------------------
		a<='1';
      wait for 50 ns;
		b<='1';
      wait for 50 ns;
		-------------------
	
	cin<= '1';
		a<='0';
      wait for 50 ns;
		b<='0';
      wait for 50 ns;
		--------------------
		a<='0';
      wait for 50 ns;
		b<='1';
      wait for 50 ns;
		--------------------
		a<='1';
      wait for 50 ns;
		b<='0';
      wait for 50 ns;
		--------------------
		a<='1';
      wait for 50 ns;
		b<='1';
      wait for 50 ns;
		-------------------

			
      wait;
   end process;

END;
