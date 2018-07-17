library ieee;
use ieee.std_logic_1164.all;

entity DR is
	port(	clk: in std_logic;
			idr: in std_logic;
			edr: in std_logic;
			dr_in: in std_logic_vector(7 downto 0);
			dr_out: out std_logic_vector(7 downto 0));
end DR;

architecture DR_arch of DR is
signal temp: std_logic_vector(7 downto 0);
begin
	process(clk, idr)
	begin
		if(rising_edge(clk)) then
			if(idr = '1') then
				temp <= dr_in;
			end if;
		end if;
	end process;
	dr_out <= temp when edr = '0' else "ZZZZZZZZ";
end DR_arch;