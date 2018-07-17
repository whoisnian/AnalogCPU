library ieee;
use ieee.std_logic_1164.all;

entity CLK_SOURCE is
	port(	clk_50m: in std_logic;					-- 50M晶振信号
			clk: out std_logic);						-- 时钟信号
end CLK_SOURCE;

architecture CLK_SOURCE_arch of CLK_SOURCE is
signal temp: std_logic := '0';
begin
	process(clk_50m)
	variable count: integer range 0 to 1000000 := 0;
	begin
		if(rising_edge(clk_50m)) then
		if(count = 1000000) then				-- 每1000000个上升沿改变一次输出，相当于周期扩大2000000倍
				count := 0;
				temp <= not temp;
			else
				count := count + 1;
			end if;
		end if;
	end process;
	clk <= temp;
end CLK_SOURCE_arch;