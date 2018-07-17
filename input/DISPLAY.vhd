library ieee;
use ieee.std_logic_1164.all;

entity DISPLAY is
	port(	clk_50m: in std_logic;
			addr: in std_logic_vector(3 downto 0);
			data: in std_logic_vector(7 downto 0);
			sel: out std_logic_vector(5 downto 0);
			dig: out std_logic_vector(7 downto 0));
end DISPLAY;

architecture DISPLAY_arch of DISPLAY is
signal temp: std_logic_vector(3 downto 0);
begin
	process(clk_50m)
	variable count: integer range 0 to 6000 := 0;
	begin
		if(rising_edge(clk_50m)) then
			if(count <= 1000) then
				sel <= "111110";
				temp <= addr(3 downto 0);
			elsif(count <= 4000) then
				sel <= "111111";
				temp <= "0000";
			elsif(count <= 5000) then
				sel <= "101111";
				temp <= data(7 downto 4);
			elsif(count <= 6000) then
				sel <= "011111";
				temp <= data(3 downto 0);
			end if;
			if(count = 6000) then
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;
	dig <= not x"3F" when temp = "0000" else
			 not x"06" when temp = "0001" else
			 not x"5B" when temp = "0010" else
			 not x"4F" when temp = "0011" else
			 not x"66" when temp = "0100" else
			 not x"6D" when temp = "0101" else
			 not x"7D" when temp = "0110" else
			 not x"07" when temp = "0111" else
			 not x"7F" when temp = "1000" else
			 not x"6F" when temp = "1001" else
			 not x"77" when temp = "1010" else
			 not x"7C" when temp = "1011" else
			 not x"39" when temp = "1100" else
			 not x"5E" when temp = "1101" else
			 not x"79" when temp = "1110" else
			 not x"71" when temp = "1111" else
			 x"00";
end DISPLAY_arch;