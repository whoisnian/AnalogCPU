library ieee;
use ieee.std_logic_1164.all;

entity IR is
	port(	clk: in std_logic;									-- 时钟信号
			clr: in std_logic;									-- 重置信号
			iir: in std_logic;									-- 指令寄存器寄存信号
			ir_in: in std_logic_vector(7 downto 0);		-- 指令寄存器接收端口
			mov_to_a: out std_logic;							-- 向AX中存入立即数
			mov_to_b: out std_logic;							-- 向BX中存入立即数
			mov_b_to_a: out std_logic;							-- 将BX内容复制进AX中
			mov_a_to_b: out std_logic;							-- 将AX内容复制进BX中
			add_to_a: out std_logic;							-- 向AX中加上立即数
			add_to_b: out std_logic;							-- 向BX中加上立即数
			add_b_to_a: out std_logic;							-- 将BX加到Ax中
			add_a_to_b: out std_logic;							-- 将AX加到BX中
			shr_a: out std_logic;								-- 将AX右移一位
			shr_b: out std_logic;								-- 将BX右移一位
			shl_a: out std_logic;								-- 将Ax左移一位
			shl_b: out std_logic;								-- 将BX左移一位
			xchg: out std_logic;									-- 交换AX和BX的内容
			halt: out std_logic);								-- 停机
end IR;

architecture IR_arch of IR is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, clr, iir)
	begin
		if(rising_edge(clk)) then
			if(clr = '0') then									-- 重置指令寄存器
				temp <= "00000000";
			end if;
			if(iir = '0') then
				temp <= ir_in;										-- 指令寄存器寄存内容
			end if;
		end if;
	end process;
	
	process(clk, temp)											-- 分析寄存内容对应的指令，并激活对应的输出信号
	begin
		if(temp = "00000001") then
			mov_to_a <= '1';
		else
			mov_to_a <= '0';
		end if;
		if(temp = "00000010") then
			mov_to_b <= '1';
		else
			mov_to_b <= '0';
		end if;
		if(temp = "00000011") then
			mov_b_to_a <= '1';
		else
			mov_b_to_a <= '0';
		end if;
		if(temp = "00000100") then
			mov_a_to_b <= '1';
		else
			mov_a_to_b <= '0';
		end if;
		if(temp = "00000101") then
			add_to_a <= '1';
		else
			add_to_a <= '0';
		end if;
		if(temp = "00000110") then
			add_to_b <= '1';
		else
			add_to_b <= '0';
		end if;
		if(temp = "00000111") then
			add_b_to_a <= '1';
		else
			add_b_to_a <= '0';
		end if;
		if(temp = "00001000") then
			add_a_to_b <= '1';
		else
			add_a_to_b <= '0';
		end if;
		if(temp = "00001001") then
			shr_a <= '1';
		else
			shr_a <= '0';
		end if;
		if(temp = "00001010") then
			shr_b <= '1';
		else
			shr_b <= '0';
		end if;
		if(temp = "00001011") then
			shl_a <= '1';
		else
			shl_a <= '0';
		end if;
		if(temp = "00001100") then
			shl_b <= '1';
		else
			shl_b <= '0';
		end if;
		if(temp = "00001101") then
			xchg <= '1';
		else
			xchg <= '0';
		end if;
		if(temp = "00001110") then
			halt <= '1';
		else
			halt <= '0';
		end if;
	end process;
end IR_arch;