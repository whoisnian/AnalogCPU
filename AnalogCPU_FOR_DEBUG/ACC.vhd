library ieee;
use ieee.std_logic_1164.all;

entity ACC is
	port(	clk: in std_logic;
			clr: in std_logic;
			ia: in std_logic;
			ea: in std_logic;
			ib: in std_logic;
			eb: in std_logic;
			chg: in std_logic;
			acc_in: in std_logic_vector(7 downto 0);
			acc_out: out std_logic_vector(7 downto 0);
			acc_a: out std_logic_vector(7 downto 0);
			acc_b: out std_logic_vector(7 downto 0));
end ACC;

architecture ACC_arch of ACC is
signal temp_a: std_logic_vector(7 downto 0) := "00000000";
signal temp_b: std_logic_vector(7 downto 0) := "00000000";
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
	acc_a <= temp_a;
	acc_b <= temp_b;
	acc_out <= temp_a when ea = '0' else 
				  temp_b when eb = '0' else
				  "ZZZZZZZZ";
end ACC_arch;