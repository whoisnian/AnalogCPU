library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
	port(	clk: in std_logic;											-- 时钟信号
			clr: in std_logic;											-- 重置信号
			ipc: in std_logic;											-- 计数信号
			pc_out: out std_logic_vector(3 downto 0));			-- 地址输出端口，连接地址寄存器
end PC;

architecture PC_arch of PC is
signal temp: std_logic_vector(3 downto 0) := "ZZZZ";
begin
	process(clk, clr, ipc)
	begin
		if(clr = '0') then												-- 接收到重置信号时，程序计数器归零
			temp <= "0000";
		elsif(rising_edge(clk)) then
			if(ipc = '1') then											-- ipc信号激活时，程序计数器加一
				temp <= std_logic_vector(unsigned(temp) + 1);
			end if;
		end if;
	end process;
	pc_out <= temp;
end PC_arch;