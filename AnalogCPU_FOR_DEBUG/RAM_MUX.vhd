library ieee;
use ieee.std_logic_1164.all;

entity RAM_MUX is
	port(	sel: in std_logic;
			addr1: in std_logic_vector(3 downto 0);
			addr2: in std_logic_vector(3 downto 0);
			res: out std_logic_vector(3 downto 0));
end RAM_MUX;

architecture RAM_MUX_arch of RAM_MUX is
begin
	res <= addr1 when sel = '0' else addr2;
end RAM_MUX_arch;