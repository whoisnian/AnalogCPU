library ieee;
use ieee.std_logic_1164.all;

entity COUNTER is
	port(	clk: in std_logic;								-- 时钟信号
			clr: in std_logic;								-- 重置信号
			t: out std_logic_vector(7 downto 0));		-- 每个节拍周期包含8个节拍
end COUNTER;

architecture COUNTER_arch of COUNTER is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, clr)
	begin
		if(clr = '0') then
			temp <= "00000001";
		elsif(rising_edge(clk)) then						-- 检测到时钟信号的上升沿时，变到下一个节拍
			temp <= temp(6 downto 0) & temp(7);
		end if;
	end process;
	t <= temp;
end COUNTER_arch;