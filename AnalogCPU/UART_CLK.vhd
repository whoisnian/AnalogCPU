library ieee;
use ieee.std_logic_1164.all;

entity UART_CLK is
	port(	clk_50m: in std_logic;									-- 50M晶振信号
			clr: in std_logic;										-- 重置信号
			bps_start: in std_logic;								-- 开始计数信号
			clk_bps: out std_logic);								-- 读取信号
end UART_CLK;

architecture UART_CLK_arch of UART_CLK is
shared variable count: integer range 0 to 5208 := 0;
begin
	process(clk_50m, clr)
	begin
		if(clr = '0') then
			count := 0;
		elsif(rising_edge(clk_50m)) then
			if((count = 5208) or (bps_start = '0')) then		-- 收到停止计数信号或者计数达到最大时重置计数器
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;
	clk_bps <= '1' when count = 2604 else '0';				-- 计数到达数据位的中间时发送读取信号
end UART_CLK_arch;