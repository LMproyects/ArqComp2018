-- Autor: Marcos Postemsky
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ripple_carry_adder_tb IS
END ripple_carry_adder_tb;
 
ARCHITECTURE behavior OF ripple_carry_adder_tb IS 
 
    --Declaracion del componente 

    COMPONENT ripple_carry_adder 
    	generic (n:	INTEGER:=4); --Se define 8 por defecto
		port( carry_in:	in std_logic;
			x,y:	in std_logic_vector(n-1 downto 0);
			suma:		out std_logic_vector(n-1 downto 0);
			carry_out: out std_logic
	); 
	END COMPONENT;
	
	constant ancho : integer := 8;
	signal a,b,s: std_logic_vector(ancho-1 downto 0);
	signal cin,cout: std_logic;
	signal suma: std_logic_vector(ancho downto 0);

	
	
	begin
	--instancio
	uut: ripple_carry_adder generic map (ancho)
			port map(cin,a,b,s,cout);
	 -- Stimulus process
	 
   stim_proc: process
	
	variable errors: boolean := false;
	
   begin		
	
	-- prueba con Carry_in=0
	cin<='0';
		for i in 255 downto 0 loop
		for j in 255 downto 0 loop 
			a<= std_logic_vector (to_unsigned (j,8));
			b<=std_logic_vector (to_unsigned (i,8));
			suma <= std_logic_vector (to_unsigned (i+j,9));
			wait for 50 ns;
			if (suma(7 downto 0)/=s) then 
				assert false
				report "Ocurrio un Error con Cin=0.";
				errors := true;
			end if;
			if (cout /= suma(8)) then
				assert false
				report "Ocurrio un Error con Cout.";
				errors := true;
			end if;
		end loop;
		end loop;
		
	-- Prueba con Carry_in=1
		cin<='1';
		for i in 255 downto 0 loop
		for j in 255 downto 0 loop 
			a<= std_logic_vector (to_unsigned (j,8));
			b<=std_logic_vector (to_unsigned (i,8));
			suma <= std_logic_vector (to_unsigned (i+j+1,9));
			wait for 50 ns;
			if (suma(7 downto 0)/=s) then 
				assert false
				report "Ocurrio un Error en la suma con Cout=0.";
				errors := true;
			end if;
			if (cout /= suma(8)) then
				assert false
				report "Ocurrio un Error con Cout.";
				errors := true;
			end if;
		end loop;
		end loop;
		
		-- se verifica y muestra un mensaje para saber si paso o no el testeo
		
		assert not errors
		report "Fallo el testeo"
		severity note;
		assert errors
		report "Paso el testeo"
		severity note;
			
      wait;
   end process;
	
	
	end;
	