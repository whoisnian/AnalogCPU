library ieee;
use ieee.std_logic_1164.all;

entity CTRL is
	port(	clk: in std_logic;							-- 时钟信号
			mov_to_a: in std_logic;						-- 向AX中存入立即数
			mov_to_b: in std_logic;						-- 向BX中存入立即数
			mov_b_to_a: in std_logic;					-- 将BX内容复制进AX中
			mov_a_to_b: in std_logic;					-- 将AX内容复制进BX中
			add_to_a: in std_logic;						-- 向AX中加上立即数
			add_to_b: in std_logic;						-- 向BX中加上立即数
			add_b_to_a: in std_logic;					-- 将BX加到Ax中
			add_a_to_b: in std_logic;					-- 将AX加到BX中
			shr_a: in std_logic;							-- 将AX右移一位
			shr_b: in std_logic;							-- 将BX右移一位
			shl_a: in std_logic;							-- 将Ax左移一位
			shl_b: in std_logic;							-- 将BX左移一位
			xchg: in std_logic;							-- 交换AX和BX的内容
			halt: in std_logic;							-- 停机
			t: in std_logic_vector(7 downto 0);		-- 节拍信号
			ipc: out std_logic;							-- 地址计数器计数信号
			imar: out std_logic;							-- 地址寄存器寄存信号
			idr: out std_logic;							-- 数据寄存器寄存信号
			edr: out std_logic;							-- 数据寄存器取出信号
			iir: out std_logic;							-- 指令寄存器寄存信号
			ia: out std_logic;							-- 寄存器Ax寄存信号
			ea: out std_logic;							-- 寄存器Ax取出信号
			ib: out std_logic;							-- 寄存器Bx寄存信号
			eb: out std_logic;							-- 寄存器Bx取出信号
			sum: out std_logic;							-- 寄存器AX和BX求和信号
			sum_a: out std_logic;						-- 寄存器AX加入立即数信号
			sum_b: out std_logic;						-- 寄存器BX加入立即数信号
			shr: out std_logic;							-- 右移信号
			shl: out std_logic;							-- 左移信号
			chg: out std_logic;							-- 寄存器交换信号
			eout: out std_logic);						-- 算术逻辑单元输出信号
end CTRL;

architecture CTRL_arch of CTRL is
begin
	process(mov_to_a, mov_to_b, mov_b_to_a, mov_a_to_b, add_to_a, add_to_b, add_b_to_a, add_a_to_b, shr_a, shr_b, shl_a, shl_b, xchg, halt)
	begin
		if(halt = '1') then				-- 停机
			ipc <= '0';
		else									-- 确定一个节拍周期中各个节拍应发出的信号，控制其它单元进行运算
			ipc <= t(2) or (t(5) and mov_to_a) or (t(5) and mov_to_b) or (t(5) and add_to_a) or (t(5) and add_to_b);
			imar <= not (t(0) or (t(3) and mov_to_a) or (t(3) and mov_to_b) or (t(3) and add_to_a) or (t(3) and add_to_b));
			idr <= t(1) or (t(4) and mov_to_a) or (t(4) and mov_to_b) or (t(4) and add_to_a) or (t(4) and add_to_b);
			edr <= (t(3) and mov_b_to_a) or (t(3) and mov_a_to_b) or (t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b) or (t(3) and shr_a) or (t(4) and shr_a) or (t(3) and shr_b) or (t(4) and shr_b) or (t(3) and shl_a) or (t(4) and shl_a) or (t(3) and shl_b) or (t(4) and shl_b);
			iir <= not t(2);
			ia <= not ((t(6) and mov_to_a) or (t(3) and mov_b_to_a) or (t(6) and add_to_a) or (t(4) and add_b_to_a) or (t(4) and shr_a) or (t(4) and shl_a));
			ea <= not ((t(3) and mov_a_to_b) or (t(3) and shr_a) or (t(3) and shl_a));
			ib <= not ((t(6) and mov_to_b) or (t(3) and mov_a_to_b) or (t(6) and add_to_b) or (t(4) and add_a_to_b) or (t(4) and shr_b) or (t(4) and shl_b));
			eb <= not ((t(3) and mov_b_to_a) or (t(3) and shr_b) or (t(3) and shl_b));
			sum <= not ((t(3) and add_b_to_a) or (t(3) and add_a_to_b));
			sum_a <= not (t(5) and add_to_a);
			sum_b <= not (t(5) and add_to_b);
			shr <= not ((t(3) and shr_a) or (t(3) and shr_b));
			shl <= not ((t(3) and shl_a) or (t(3) and shl_b));
			chg <= not (t(3) and xchg);
			eout <= not ((t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b) or (t(4) and shr_a) or (t(4) and shr_b) or (t(4) and shl_a) or (t(4) and shl_b));
		end if;
	end process;
end CTRL_arch;