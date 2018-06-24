library ieee;
use ieee.std_logic_1164.all; 

entity SeqGen_1 is --contain 111010011
  port(clk   :in std_logic;
		 seq_1 :out std_logic
      );
end SeqGen_1;

architecture arch_SeqGen_1 of SeqGen_1 is
  type states is(s0, s1, s2, s3, s4, s5, s6, s7, s8);
  signal st  :states;
begin
  process(clk)
  begin
    if (clk'event and clk = '1') then
	   case st is
		  when s0 => st <= s1;
		  when s1 => st <= s2;
		  when s2 => st <= s3;
		  when s3 => st <= s4;
		  when s4 => st <= s5;
		  when s5 => st <= s6;
		  when s6 => st <= s7;
		  when s7 => st <= s8;
		  when s8 => st <= s0;
		end case;
	 end if;  
  end process;
  
  with st select
  seq_1 <= '1' when s0|s1|s2|s4|s7|s8,
           '0' when others;
end arch_SeqGen_1;