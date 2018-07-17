library ieee;
use ieee.std_logic_1164.all;

entity RAM_MUX is
	port(	sel: in std_logic;								-- 选择信号
			addr1: in std_logic_vector(3 downto 0);	-- 写入地址
			addr2: in std_logic_vector(3 downto 0);	-- 读取地址
			res: out std_logic_vector(3 downto 0));	-- 结果
end RAM_MUX;

architecture RAM_MUX_arch of RAM_MUX is
begin
	res <= addr1 when sel = '0' else addr2;			-- 当wr为0时，结果为要写入的地址；当wr为1时，结果为要读取的地址
end RAM_MUX_arch;