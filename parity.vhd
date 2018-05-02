library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_textio.all;
		
library STD;
	use STD.textio;
	
entity parity is 
	port(	S    	: in std_logic;								-- even = 0 / odd = 1 paritybit
			Data 	: in std_logic_vector(2 downto 0);	-- InputData 
			Pout	: out std_logic_vector(3 downto 0)  -- InputData + paritybit an der 0ten stelle
		 );
end parity;

architecture a_parity of parity is

	begin
		
		process( Data(2 downto 0) , S )
		
			variable Pset 		: std_logic;
			variable i			: integer;		--Zählvariabel
		
			variable Podd		: std_logic_vector(3 downto 0):="1010";	--warheitstabelle
			variable Peven		: std_logic_vector(3 downto 0):="0101";
			
			begin
				
				i := 0 ;
				
				if Data(0) ='1' then i:= i+1; end if;
				
				if Data(1) ='1' then i:= i+1; end if;
				
				if Data(2) ='1' then i:= i+1; end if;
				
				if S = '0'
				then Pset := Peven(i);end if;
				
				if S = '1'
				then Pset := Podd(i);end if;
				
				Pout(3 downto 0) <= Data(2 downto 0) & Pset ;
			
		end Process;	
				
				
end a_parity;

-------------testbench
library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_textio.all;
		
library STD;
	use STD.textio;
	
entity tb_parity is

end tb_parity;

architecture  a_tb_parity of tb_parity is
	component parity 
	port(	S    	: in std_logic;							-- even = 0 / odd = 1 paritybit
			Data 	: in std_logic_vector(2 downto 0);			-- InputData 
			Pout	: out std_logic_vector(3 downto 0)  		-- InputData + paritybit an der 0ten stelle
		  );
	end component;
	
	signal S 		: std_logic:='0';
	signal Data 	: std_logic_vector(2 downto 0):="000";
	signal Pout 	: std_logic_vector(3 downto 0):="0000";
	
	signal B_Maske : std_logic;
	signal B_Pout	: std_logic;
	
	begin 
	
	dut : Parity
	port map( S 	=> S,
				 Data => Data,
				 Pout => Pout  );
				 
	data(0) 	<= not data(0) after 25ns;
	data(1) 	<= not data(1) after 50ns;
	data(2) 	<= not data(2) after 100ns;
	S 			<= not S 		after 200ns;
	
	process( Pout(0)'Transaction ) -- wenn paritybit zugewiesen wird vergleichen wir mit der Wahrheittabelle
	
		variable i 		: integer:=0;
		constant Mask 	: std_logic_vector(15 downto 0):="0110100110010110"; -- erst even dann odd
		
		begin 
			
			if(i<17)
				
				then
				if(pout(3)='1') or (pout(3)='0') 
					
					then
					B_pout  <= Mask(i) xor Pout(0);
					B_Maske <= Mask(i);
				
					i:=i+1;
				
				end if;
			
			end if;
	
	end Process;

end a_tb_parity;
	
	
	
	