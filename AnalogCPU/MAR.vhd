library ieee;
use ieee.std_logic_1164.all;

entity MAR is
	port(	clk: in std_logic;										-- 时钟信号
			imar: in std_logic;										-- 地址寄存器寄存信号
			mar_in: in std_logic_vector(3 downto 0);			-- 从程序计数器读取地址端口
			mar_out: out std_logic_vector(3 downto 0));		-- 输出地址端口，连接地址总线
end MAR;

architecture MAR_arch of MAR is
signal temp: std_logic_vector(3 downto 0);
begin
	process(clk, imar)
	begin
		if(rising_edge(clk)) then
			if(imar = '0') then										-- imar信号激活时读取地址
				temp <= mar_in;
			end if;
		end if;
	end process;
	mar_out <= temp;
end MAR_arch;