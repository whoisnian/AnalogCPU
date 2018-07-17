library ieee;
use ieee.std_logic_1164.all;

entity UART_CLK is
	port(	clk_50m: in std_logic;
			clr: in std_logic;
			bps_start: in std_logic;
			clk_bps: out std_logic);
end UART_CLK;

architecture UART_CLK_arch of UART_CLK is
--shared variable count: integer range 0 to 5208 := 0;
shared variable count: integer range 0 to 32 := 0;
begin
	process(clk_50m, clr)
	begin
		if(clr = '0') then
			count := 0;
		elsif(rising_edge(clk_50m)) then
--			if((count = 5208) or (bps_start = '0')) then
			if((count = 32) or (bps_start = '0')) then
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;
--	clk_bps <= '1' when count = 2604 else '0';
	clk_bps <= '1' when count = 16 else '0';
end UART_CLK_arch;