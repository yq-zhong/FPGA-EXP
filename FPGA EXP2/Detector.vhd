library ieee;
use ieee.std_logic_1164.all;

entity Detector is
  port(clk    :in std_logic;
       seq_in :in std_logic;
		 result :out std_logic
      );
end Detector;

architecture arch_Det of Detector is
  type states is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9);
  signal st :states; 
begin
  process(clk)
  begin
    if (clk 'event and clk = '1') then
	   case st is
		  when s0 =>
		    if (seq_in = '1') then st <= s1;
			 else st <= s0;
			 end if;
		  when s1 =>
		    if (seq_in = '0') then st <= s0;
			 else st <= s2;
			 end if;
		  when s2 =>
		    if (seq_in = '0') then st <= s0;
			 else st <= s3;
			 end if;
		  when s3 =>
		    if (seq_in = '0') then st <= s4;
			 else st <= s3;
			 end if;
		  when s4 =>
		    if (seq_in = '0') then st <= s0;
			 else st <= s5;
			 end if;
		  when s5 =>
		    if (seq_in = '0') then st <= s6;
			 else st <= s2;
			 end if;
		  when s6 =>
		    if (seq_in = '0') then st <= s7;
			 else st <= s1;
			 end if;
		  when s7 =>
		    if (seq_in = '0') then st <= s0;
			 else st <= s8;
			 end if;
		  when s8 =>
		    if (seq_in = '0') then st <= s0;
			 else st <= s9;
			 end if;
		  when s9 =>
		    if (seq_in = '0') then st <= s0;
			 else st <= s3;
			 end if;
		end case;
	 end if;
  end process;
  
  with st select
  result <= '1' when s9,
            '0' when others;
end arch_Det;