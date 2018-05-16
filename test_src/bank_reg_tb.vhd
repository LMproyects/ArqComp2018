--Test bench para el banco de registros

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
           

ENTITY bank_reg_tb IS 
	 generic (   
            clk_period : time := 10 ns -- per le tempistiche
        ); 
END ENTITY bank_reg_tb;

ARCHITECTURE Behavioral OF bank_reg_tb IS
  -- Declaro el componente del banco de registros
COMPONENT bank_reg
	GENERIC(
    n_reg : integer := 64;  -- cantidad de bits registros
    bit_dir_reg : integer := 5
    );  -- cantidad de registros
    PORT(
      A_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);
      B_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);
      C_i : IN     std_logic_vector(bit_dir_reg-1 downto 0);    
      Reg_W_i: IN		std_logic;
      CLK_i : IN     std_logic;
      W_c_i : IN     std_logic_vector(n_reg-1 downto 0);
      R_a_o : OUT    std_logic_vector(n_reg-1 downto 0);
      R_b_o : OUT    std_logic_vector(n_reg-1 downto 0)
      );
END COMPONENT;

CONSTANT n_reg : integer := 64; 
CONSTANT bit_dir_reg : integer := 5;


signal A_i,B_i,C_i: std_logic_vector(bit_dir_reg-1 downto 0);
signal W_c_i, R_a_o, R_b_o: std_logic_vector(n_reg-1 downto 0);
signal CLK_i, Reg_W_i: std_logic;
signal R_a_aux, R_b_aux: std_logic_vector(n_reg-1 downto 0); -- señales que se usan en stimul_proc para comparar el resultado del banco de registro

BEGIN
  -- put concurrent statements here.
--intancio el componente 
uut: bank_reg generic map(n_reg,bit_dir_reg)
		port map(A_i,B_i,C_i,Reg_W_i,CLK_i,W_c_i,R_a_o,R_b_o);

-- Se crea el proceso del clock

stimul_clk: process

begin
  CLK_i <= '0';
  wait for clk_period/2;
  CLK_i <= '1';
  wait for clk_period/2;
end process;

stimul_proc: process
  variable errors: boolean := false;  -- variable para detectar errores
 
begin

  
  Reg_W_i <= '1';	-- Se coloca el banco en modo escritura
  
  wait for 2*clk_period;	--tiempo de estabilizacion
 -- Se coloca un valor conocido en los registros.
  
  FOR i IN 0 TO 2**bit_dir_reg-1 LOOP
  
  	C_i <= std_logic_vector(to_unsigned(i,bit_dir_reg));	-- Direccion 
  	W_c_i <= std_logic_vector(to_unsigned(i,n_reg));	-- Valor que se guarda en el banco de registros (del 0 al 31)
  	
  	wait for clk_period*1.5; -- espera un periodo de clock y vuelve a escribir;
  
  END LOOP;
  -- Aqui ya se encuentran los valores almacenados en el banco de registros	
  
  Reg_W_i <= '0';	-- modo solo lectura 
  
  --wait for clk_period;
  
  FOR i IN 0 TO 2**bit_dir_reg-1 LOOP
    
    A_i <= std_logic_vector(to_unsigned(i,bit_dir_reg)); -- direccion que se quiere leer
    B_i <= std_logic_vector(to_unsigned(i,bit_dir_reg)); -- direccion que se quiere leer
      
    R_a_aux <= std_logic_vector(to_unsigned(i,n_reg)); -- Se almacena el valor que deberia haber en la salida cuando se lee el registro
    R_b_aux <= std_logic_vector(to_unsigned(i,n_reg)); 
    
    wait for clk_period*1.5;
        
    if R_a_o /= R_a_aux then -- se controla que el valor leido sea correcto
    	 assert false
    	 report "ERROR EN LECTURA DE A";
    	 errors := true;
  	end if;
  	if R_b_o /= R_b_aux then -- se controla que el valor leido sea correcto
    	 assert false
    	 report "ERROR EN LECTURA DE B";
    	 errors := true;
  	end if;
  	wait for clk_period;
  		
  END LOOP;
 
  -- Reportar si hubo errores
  assert not errors 
  report "Fallo el testeo"
  severity note;

  assert errors
  report "Paso el testeo"
  severity note; 
  wait;

end process;


  
END ARCHITECTURE Behavioral; -- Of entity bank_reg_tb
