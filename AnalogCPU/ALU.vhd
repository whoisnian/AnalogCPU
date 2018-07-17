library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(	clk: in std_logic;											-- 时钟信号
			sum: in std_logic;											-- 将寄存器AX和BX值相加
			sum_a: in std_logic;											-- 将寄存器AX值加上数据总线内容
			sum_b: in std_logic;											-- 将寄存器BX值加上数据总线内容
			shr: in std_logic;											-- 将数据总线值右移
			shl: in std_logic;											-- 将数据总线值左移
			eout: in std_logic;											-- 输出计算结果
			acc_a: in std_logic_vector(7 downto 0);				-- 寄存器AX内容
			acc_b: in std_logic_vector(7 downto 0);				-- 寄存器BX内容
			dr: in std_logic_vector(7 downto 0);					-- 数据总线内容
			alu_out: out std_logic_vector(7 downto 0));			-- 计算结果
end ALU;

architecture ALU_arch of ALU is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, sum, sum_a, sum_b, shr, shl)
	begin
		if(rising_edge(clk)) then
			if(sum = '0') then
				temp <= std_logic_vector(unsigned(acc_a) + unsigned(acc_b));
			end if;
			if(sum_a = '0') then
				temp <= std_logic_vector(unsigned(acc_a) + unsigned(dr));
			end if;
			if(sum_b = '0') then
				temp <= std_logic_vector(unsigned(acc_b) + unsigned(dr));
			end if;
			if(shr = '0') then
				temp <= '0' & dr(7 downto 1);
			end if;
			if(shl = '0') then
				temp <= dr(6 downto 0) & '0';
			end if;
		end if;
	end process;
	alu_out <= temp when eout = '0' else "ZZZZZZZZ";		-- 默认高阻态
end ALU_arch;