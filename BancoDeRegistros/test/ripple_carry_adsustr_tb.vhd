LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 

 
ENTITY ripple_carry_adsustr_tb IS
END ripple_carry_adsustr_tb;
 
ARCHITECTURE behavior OF ripple_carry_adsustr_tb IS 
 
    --Declaracion del componente 

    COMPONENT ripple_carry_adsustr
		generic (n:	INTEGER:=4); 
		port( x,y:	in std_logic_vector(n-1 downto 0);
			sum_rest: in std_logic;
			result:		out std_logic_vector(n-1 downto 0);
			carry_out: out std_logic
	); 
	END COMPONENT;
	
	constant ancho : integer := 8;
	signal a,b,s: std_logic_vector(ancho-1 downto 0);
	signal resta: std_logic_vector (ancho downto 0);
	signal suma: std_logic_vector(ancho downto 0);
	signal cout,selec: std_logic;
	
	
	begin
	--instancio
	uut: ripple_carry_adsustr generic map (ancho)
			port map(a,b,selec,s,cout);
	 -- Stimulus process
   stim_proc: process
	variable errors: boolean := false;
   begin		
	resta<="000000000";
   selec <= '0';
		for i in 255 downto 0 loop
		for j in 255 downto 0 loop 
			a<= std_logic_vector (to_unsigned (j,8));
			b<=std_logic_vector (to_unsigned (i,8));
			suma <= std_logic_vector (to_unsigned (i+j,9));
			wait for 50 ns;
			if (suma(7 downto 0)/=s) then 
				assert false
				report "Ocurrio un Error en la suma.";
				errors := true;
			end if;
		end loop;
		end loop; 

 wait for 50 ns;
		
   selec <= '1';
		for i in 256 downto 0 loop
		for j in 256 downto 0 loop 
--		

      --Se limitan los valores a restar para evitar desbortamientos,
		--ya que los operadores de vhdl no trabajan de la misma manera.
		if (i<=j) then 
			a<= std_logic_vector (to_unsigned (j,8));
			b<=std_logic_vector (to_unsigned (i,8));
			resta <= std_logic_vector (to_unsigned (j-i,9));
			wait for 50 ns;
			if (resta(7 downto 0)/=s) then 
				assert false
				report "Ocurrio un Error en la resta.";
				errors := true;
			end if;
		end if;
		end loop;
		end loop;
		
	assert not errors
		report "Fallo el testeo"
		severity note;
	assert errors
	report "Paso el testeo"
	severity note;
			
      wait;
   end process;
	
	
	end;
	
	