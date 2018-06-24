library ieee;
use ieee.std_logic_1164.all;

entity Selector is
  port(seq_in_1 :in std_logic;
       seq_in_2 :in std_logic;
		 sel      :in std_logic;
		 seq_out  :out std_logic
      );
end Selector;

architecture arch_Selector of Selector is
  
begin
  with sel select
  seq_out <= seq_in_1 when '1',
             seq_in_2 when '0',
				 'Z'      when others;
end arch_Selector;