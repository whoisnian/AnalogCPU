library ieee;
use ieee.std_logic_1164.all;

entity ACC is
	port(	clk: in std_logic;											-- 时钟信号
			clr: in std_logic;											-- 重置信号
			ia: in std_logic;												-- 寄存器AX输入信号
			ea: in std_logic;												-- 寄存器AX输出信号
			ib: in std_logic;												-- 寄存器BX输入信号
			eb: in std_logic;												-- 寄存器BX输入信号
			chg: in std_logic;											-- 寄存器交换信号
			acc_in: in std_logic_vector(7 downto 0);				-- 寄存器共用输入接口
			acc_out: out std_logic_vector(7 downto 0);			-- 寄存器共用输出接口
			acc_a: out std_logic_vector(7 downto 0);				-- 寄存器AX实时内容接口
			acc_b: out std_logic_vector(7 downto 0));				-- 寄存器BX实时内容接口
end ACC;

architecture ACC_arch of ACC is
signal temp_a: std_logic_vector(7 downto 0) := "00000000";	-- 寄存器AX
signal temp_b: std_logic_vector(7 downto 0) := "00000000";	-- 寄存器BX
begin
	process(clk, clr, ia, ib, chg)
	begin
		if(rising_edge(clk)) then
			if(clr = '0') then
				temp_a <= "00000000";
				temp_b <= "00000000";
			end if;
			if(ia = '0') then
				temp_a <= acc_in;
			end if;
			if(ib = '0') then
				temp_b <= acc_in;
			end if;
			if(chg = '0') then
				temp_a <= temp_b;
				temp_b <= temp_a;
			end if;
		end if;
	end process;
	acc_a <= temp_a;											-- acc_a实时反映寄存器AX的值
	acc_b <= temp_b;											-- acc_b实时反映寄存器BX的值
	acc_out <= temp_a when ea = '0' else 
				  temp_b when eb = '0' else
				  "ZZZZZZZZ";
end ACC_arch;