library ieee;
use ieee.std_logic_1164.all;

entity IR is
	port(	clk: in std_logic;
			clr: in std_logic;
			iir: in std_logic;
			ir_in: in std_logic_vector(7 downto 0);
			mov_to_a: out std_logic;
			mov_to_b: out std_logic;
			mov_b_to_a: out std_logic;
			mov_a_to_b: out std_logic;
			add_to_a: out std_logic;
			add_to_b: out std_logic;
			add_b_to_a: out std_logic;
			add_a_to_b: out std_logic;
			shr_a: out std_logic;
			shr_b: out std_logic;
			shl_a: out std_logic;
			shl_b: out std_logic;
			xchg: out std_logic;
			halt: out std_logic);
end IR;

architecture IR_arch of IR is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, clr, iir)
	begin
		if(rising_edge(clk)) then
			if(clr = '0') then
				temp <= "00000000";
			end if;
			if(iir = '0') then
				temp <= ir_in;
			end if;
		end if;
	end process;
	
	process(clk, temp)
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