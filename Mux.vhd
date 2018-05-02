
	-- library IEEE;
	--	use IEEE.std_logic_1164.all;
	--	use IEEE.std_logic_textio.all;
	
	-- library STD;
	--	use STD.textio;
	
	
	--2:1 Multiplexer  3 varianten 
	
	entity Mux is
	port( x1,x0 	: in  bit;
			S			: in  bit;
			E			: in  bit;
			Y1,Y2,Y3	: out bit);
	end Mux;
	
	--E S x1 x0  Y			
	--1 0  0  0  0  
	--1 0	 0  1  1
	--1 0  1  0  0
	--1 0  1  1  1
	
	--1 1  0  0  0  
	--1 1	 0  1  0
	--1 1  1  0  1
	--1 1  1  1  1
	
	--1.Variante
	-- E and ((not S and x0) or (S and x1)) ; 
	
	--2.Variante
	-- with S select
	-- (E and x0) when '0' , 
	-- (E and x1) when '1' ;
	
	--3.variante
	-- (E and x0) when S = '0' 
	-- else (E and x1);
	
	Architecture a_Mux of Mux is
		
		begin
		
		Y1 <= E and ( (not S and x0) or (S and x1) );
		
		with S select 
		Y2 <= (E and x0) when '0',
				(E and x1) when '1';
			
		Y3 <= (E and x0) when S='0' else
				(E and x1);
	
	end a_Mux;
	
	-- testbench für 2 zu 1 MUX 
	
	entity tb_MUX is 
	
	end tb_MUX;
	
	architecture a_tb_MUX of tb_MUX is 
		component Mux 
	
		port( x1,x0 	: in  bit;
				S			: in  bit;
				E			: in  bit;
				Y1,Y2,Y3	: out bit);
		end component;	
		
		signal x1	: bit := '0';
		signal x0	: bit := '0';
		signal  S	: bit := '0';
		signal  E	: bit := '0';
		signal Y1	: bit ;
		signal Y2	: bit ;
		signal Y3	: bit ;
		
		begin 
			DUT : Mux 
					port map(
					x1 => x1,
					x0 => x0,
					S  => S ,
					E  => E ,
					Y1 => Y1,
					Y2 => Y2,
					Y3 => Y3);
					
		x0 <= not x0 after  25ns;
		x1 <= not x1 after  50ns;
		S  <= not S  after 100ns;
		E  <= not E  after 200ns;
		
		
	end a_tb_MUX;