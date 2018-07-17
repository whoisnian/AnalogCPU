library ieee;
use ieee.std_logic_1164.all;

entity UART_RX is
	port(	clk_50m: in std_logic;										-- 50M晶振信号
			clr: in std_logic;											-- 重置信号
			clk_bps: in std_logic;										-- 读取信号
			rxd: in std_logic;											-- 串口接收端口
			bps_start: out std_logic;									-- 开始计数信号
			wr: out std_logic := '1';									-- 存储器写入信号
			addr: out std_logic_vector(3 downto 0);				-- 存储器要写入的地址
			ram_in: out std_logic_vector(7 downto 0));			-- 存储器要写入的内容
end UART_RX;

architecture UART_RX_arch of UART_RX is
signal temp: std_logic_vector(3 downto 0) := "0000";
signal rx_active: std_logic;
signal num: integer range 0 to 9 := 0;
shared variable count: integer range 0 to 10000000 := 0;
begin
	process(clk_50m, clr)
	begin
		if(clr = '0') then												-- 重置接收模块
			temp <= "0000";
		elsif(rising_edge(clk_50m)) then								-- 最近接收到的信号
			temp <= temp(2 downto 0) & rxd;
		end if;
	end process;
	rx_active <= '1' when temp = "1100" else '0';				-- 接收到下降沿信号时，准备激活波特率控制模块的开始计数信号
	process(clk_50m, clr)
	begin
		if(clr = '0') then												-- 重置接收模块
			bps_start <= '0';
		elsif(rising_edge(clk_50m)) then
			if(rx_active = '1') then									-- 打开计数信号
				bps_start <= '1';
			elsif((clk_bps = '1') and (num = 9)) then				-- 如果计数达到最大值关闭计数信号
				bps_start <= '0';
			end if;
		end if;
	end process;
	process(clk_50m, clr)
	begin
		if(clr = '0') then												-- 重置接收模块
			num <= 0;
			count := 0;
			addr <= "0000";
			ram_in <= "00000000";
		elsif(rising_edge(clk_50m)) then
			if(clk_bps = '1') then
				if(num = 9) then
					num <= 0;
				else
					num <= num + 1;
				end if;
				if(count <= 9) then										-- 第一次接收并保存数据的低四位作为地址输出端口内容
					case num is 
						when 1 => addr(0) <= rxd;
						when 2 => addr(1) <= rxd;
						when 3 => addr(2) <= rxd;
						when 4 => addr(3) <= rxd;
						when others => null;
					end case;
				elsif(count <= 19) then									-- 第二次接收并保存数据作为数据输出端口内容
					case num is
						when 1 => ram_in(0) <= rxd;
						when 2 => ram_in(1) <= rxd;
						when 3 => ram_in(2) <= rxd;
						when 4 => ram_in(3) <= rxd;
						when 5 => ram_in(4) <= rxd;
						when 6 => ram_in(5) <= rxd;
						when 7 => ram_in(6) <= rxd;
						when 8 => ram_in(7) <= rxd;
						when others => null;
					end case;
				end if;
				count := count + 1;
			end if;
			if(count >= 20) then											-- 接收两次数据后进行一次等待
				count := count + 1;
			end if;
			if(count = 5000000) then
				count := 0;
			end if;
		end if;
	end process;
	wr <= '0' when (count > 20) and (count < 5000000) else '1';			-- 接收两次数据后将wr置0，等待存储器读取，等待时间结束后准备下一次读取
end UART_RX_arch;