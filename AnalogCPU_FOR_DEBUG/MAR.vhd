library ieee;
use ieee.std_logic_1164.all;

entity MAR is
	port(	clk: in std_logic;
			imar: in std_logic;
			mar_in: in std_logic_vector(3 downto 0);
			mar_out: out std_logic_vector(3 downto 0));
end MAR;

architecture MAR_arch of MAR is
signal temp: std_logic_vector(3 downto 0);
begin
	process(clk, imar)
	begin
		if(rising_edge(clk)) then
			if(imar = '0') then
				temp <= mar_in;
			end if;
		end if;
	end process;
	mar_out <= temp;
end MAR_arch;