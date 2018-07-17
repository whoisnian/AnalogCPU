library ieee;
use ieee.std_logic_1164.all;

entity CLK_SOURCE is
	port(	clk_50m: in std_logic;
			clk: out std_logic);
end CLK_SOURCE;

architecture CLK_SOURCE_arch of CLK_SOURCE is
signal temp: std_logic := '0';
begin
	process(clk_50m)
	variable count: integer range 0 to 1 := 0;
	begin
		if(rising_edge(clk_50m)) then
			if(count = 1) then
				count := 0;
				temp <= not temp;
			else
				count := count + 1;
			end if;
		end if;
	end process;
	clk <= temp;
end CLK_SOURCE_arch;