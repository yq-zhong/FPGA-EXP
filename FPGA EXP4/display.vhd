library ieee;
use ieee.std_logic_1164.all;

entity display is
  port(clk_new  :in std_logic;
       num      :in std_logic_vector(0 to 3);
       abcdefg  :out std_logic_vector(0 to 6);
		 positiv  :out std_logic
		 );
end display;

architecture arch_dis of display is
begin
  positiv <= '1';
  --阴极给出数字
  with num select
    abcdefg <= "0000001" when "0000",
	            "1001111" when "0001",
					"0010010" when "0010",
					"0000110" when "0011",
					"1001100" when "0100",
					"0100100" when "0101",
					"0100000" when "0110",
					"0001111" when "0111",
					"0000000" when "1000",
					"0000100" when "1001",
					"0001000" when "1010",
					"1100000" when "1011",
					"0110001" when "1100",
					"1000010" when "1101",
					"0110000" when "1110",
					"0111000" when "1111",
					"ZZZZZZZ" when others;
end arch_dis;