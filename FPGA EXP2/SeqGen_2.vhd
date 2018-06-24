library ieee;
use ieee.std_logic_1164.all;

entity SeqGen_2 is
  port(clk   :in std_logic;
		 seq_2 :out std_logic
      );
end SeqGen_2;

architecture arch_SeqGen_2 of SeqGen_2 is
  type states is (s0, s1);
  signal st :states;
begin
  process(clk)
  begin
    if (clk 'event and clk = '1') then
	   case st is
		  when s0 => st <= s1;
		  when s1 => st <= s0;
		end case;
	 end if;
  end process;
  
  with st select
  seq_2 <= '0' when s0,
           '1' when s1;
end arch_SeqGen_2;