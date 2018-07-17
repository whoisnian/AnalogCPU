library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(	clk: in std_logic;
			clr: in std_logic;
			ipc: in std_logic;
			pc_out: out std_logic_vector(3 downto 0));
end PC;

architecture PC_arch of PC is
signal temp: std_logic_vector(3 downto 0) := "ZZZZ";
begin
	process(clk, clr, ipc)
	begin
		if(clr = '0') then
			temp <= "0000";
		elsif(rising_edge(clk)) then
			if(ipc = '1') then
				temp <= std_logic_vector(unsigned(temp) + 1);
			end if;
		end if;
	end process;
	pc_out <= temp;
end PC_arch;