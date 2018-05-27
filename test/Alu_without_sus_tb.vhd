--Autor: Marcos Postemsky
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Alu_without_sus_tb IS
END Alu_without_sus_tb;
 
ARCHITECTURE behavior OF Alu_without_sus_tb IS 
 
    --Declaracion del componente 

    COMPONENT Alu_without_sus
		generic (ancho:	INTEGER:=6); --Se define 2 por defecto
		port( a_in,b_in:	in std_logic_vector(ancho-1 downto 0);
				control:		in std_logic_vector(1 downto 0); 
				y:		out std_logic_vector(ancho-1 downto 0)
		); 
	END COMPONENT;
	
	constant ancho : integer := 7;
	signal a,b,s,logica: std_logic_vector(ancho-1 downto 0);
	signal suma: std_logic_vector(ancho downto 0);
	signal control: std_logic_vector(1 downto 0);
	
	
	begin
	--instancio
	uut: Alu_without_sus generic map (ancho)
			port map(a,b,control,s);
	 -- Stimulus process
   stim_proc: process
	
   variable errors: boolean := false;

	
   begin		

	logica<= "0000000";
	--bloque prueba para la suma		

   control <= "11";
		for i in 255 downto 0 loop
		for j in 255 downto 0 loop 
			a<= std_logic_vector (to_unsigned (j,ancho));
			b<=std_logic_vector (to_unsigned (i,ancho));
			suma <= std_logic_vector (to_unsigned (i+j,ancho+1));
			wait for 50 ns;
			if (suma(ancho-1 downto 0)/=s) then 
				assert false
				report "Ocurrio un Error en la suma.";
				errors := true;

			end if;
		end loop;
		end loop; 



--bloque prueba para not		

wait for 50 ns;
	control <= "00";

		for j in 255 downto 0 loop 
			a<= std_logic_vector (to_unsigned (j,7));
			logica<= not (std_logic_vector (to_unsigned (j,7)));
			
			if (logica/=s) then 
				assert false
				report "Ocurrio un Error en not";
				errors := true;

			end if;
			
			wait for 50 ns;

		end loop;
			

-- bloque prueba para and

	wait for 50 ns;
		
   control <= "01";
		for i in 100 downto 0 loop
		for j in 50 downto 0 loop 
			a<= std_logic_vector (to_unsigned (j,7));
			b<=std_logic_vector (to_unsigned (i,7));
			
			logica<= std_logic_vector (to_unsigned (j,7)) and std_logic_vector (to_unsigned (i,7));
			if (logica/=s) then 
				assert false
				report "Ocurrio un Error en and";
				errors := true;

			end if;
			
			wait for 50 ns;

		end loop;
		end loop;

		
-- bloque prueba para or
	wait for 50 ns;
		
   control <= "10";
		for i in 100 downto 0 loop
		for j in 50 downto 0 loop 
			a<= std_logic_vector (to_unsigned (j,7));
			b<=std_logic_vector (to_unsigned (i,7));
			
			logica<= std_logic_vector (to_unsigned (j,7)) or std_logic_vector (to_unsigned (i,7));
			if (logica/=s) then 
				assert false
				report "Ocurrio un Error en or";
				errors := true;

			end if;
			
			wait for 50 ns;

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