library IEEE;
	use IEEE.std_logic_1164.all;

	
	entity schiebe is
	port(P_Daten			: in std_logic_vector(4 downto 0);		--paralle daten
		  Daten_R,Daten_L	: in std_logic;								--serielle dasten, rd schiebt von rechts, ld schiebt von links
		  S0,S1				: in std_logic;								--steuereingänge	
		  clk_schiebe		: in std_logic;								--clock
		  Out_R,Out_L		: out std_logic;								--serielle ausgänge
		  P_Out				: out std_logic	);							--paralle ausgänge
	end schiebe;
	
	architecture a_schiebe of schiebe is
	
	component d_ff 
	port(		D	: in std_logic;
				CLK: in std_logic;
				Q	: out std_logic	);	
	end component;
	
	signal D 	: std_logic_vector(4 downto 0);
	signal clk 	: std_logic_vector(4 downto 0);
	signal Q 	: std_logic_vector(4 downto 0);
	
	begin 
	
	ffGenerate : for i IN 0 to 4 generate
		
		ff0 : d_ff
		port map	(	D 		=> D(i),
						CLK 	=> CLK(i),
						Q		=> Q(i)		);
	
	end generate;
	
	end a_schiebe;