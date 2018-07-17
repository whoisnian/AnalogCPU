library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(	clk: in std_logic;
			sum: in std_logic;
			sum_a: in std_logic;
			sum_b: in std_logic;
			shr: in std_logic;
			shl: in std_logic;
			eout: in std_logic;
			acc_a: in std_logic_vector(7 downto 0);
			acc_b: in std_logic_vector(7 downto 0);
			dr: in std_logic_vector(7 downto 0);
			alu_out: out std_logic_vector(7 downto 0));
end ALU;

architecture ALU_arch of ALU is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, sum, sum_a, sum_b, shr, shl)
	begin
		if(falling_edge(clk)) then
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
	alu_out <= temp when eout = '0' else "ZZZZZZZZ";
end ALU_arch;