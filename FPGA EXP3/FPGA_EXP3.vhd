library ieee;
use ieee.std_logic_1164.all;

entity FPGA_EXP3 is
  port(clk      :in std_logic;
  
       num_lock :in std_logic_vector(0 to 3); --
		 cs_lock  :in std_logic_vector(0 to 2);
		 lock     :in std_logic;
		 
		 abcdefg  :out std_logic_vector(0 to 6);
		 cs_dis   :out std_logic_vector(0 to 7)
		);
end FPGA_EXP3;



architecture arch_exp3 of FPGA_EXP3 is
  type states is (s0, s1, s2, s3, s4, s5, s6, s7);
  signal counter :states;
  signal clk_new :std_logic;
  signal clk_count :states;
  --8个锁存器------------------------------------------
  signal num_0   :std_logic_vector(0 to 3) :="0000";
  signal num_1   :std_logic_vector(0 to 3) :="0001";
  signal num_2   :std_logic_vector(0 to 3) :="0010";
  signal num_3   :std_logic_vector(0 to 3) :="0011";
  signal num_4   :std_logic_vector(0 to 3) :="0100";
  signal num_5   :std_logic_vector(0 to 3) :="0101";
  signal num_6   :std_logic_vector(0 to 3) :="0110";
  signal num_7   :std_logic_vector(0 to 3) :="0111";
  --8个锁存器------------------------------------------
  signal num   :std_logic_vector(0 to 3);

  
begin
  p_lock:
  process(lock)
  begin
    if(lock'event and lock = '1') then
	   case cs_lock is
	     when "000" => num_0 <= num_lock;
		  when "001" => num_1 <= num_lock;
		  when "010" => num_2 <= num_lock;
		  when "011" => num_3 <= num_lock;
		  when "100" => num_4 <= num_lock;
		  when "101" => num_5 <= num_lock;
		  when "110" => num_6 <= num_lock;
		  when "111" => num_7 <= num_lock;
		  when others => null;
	   end case;
	 end if; 
  end process;
  
  p_count:
  process(clk_new)
  begin
    if(clk_new'event and clk_new = '1') then
	   case counter is
		  when s0 => counter <= s1;
		             num <= num_1;
		  when s1 => counter <= s2;
		             num <= num_2;
		  when s2 => counter <= s3;
		             num <= num_3;
		  when s3 => counter <= s4;
		             num <= num_4;
		  when s4 => counter <= s5;
		             num <= num_5;
		  when s5 => counter <= s6;
		             num <= num_6;
		  when s6 => counter <= s7;
		             num <= num_7;
		  when s7 => counter <= s0;
		             num <= num_0;
		  when others => null;
		end case;
	 end if;
  end process;
  
  p_div_fre:
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   case clk_count is
		  when s0 => clk_count <= s1;
		  when s1 => clk_count <= s2;
		  when s2 => clk_count <= s3;
		  when s3 => clk_count <= s4;
		  when s4 => clk_count <= s5;
		  when s5 => clk_count <= s6;
		  when s6 => clk_count <= s7;
		  when s7 => clk_count <= s0;
		end case;
	 end if;
  end process;
  
  with clk_count select
    clk_new <= '0' when s0|s1|s2|s3,
	            '1' when others;
  
  p_display:
  process(counter)
  begin
    --阳极选择
    cs_dis <= "00000000";
	 case counter is
	   when s0 => cs_dis(0) <= '1';
		when s1 => cs_dis(1) <= '1';
		when s2 => cs_dis(2) <= '1';
		when s3 => cs_dis(3) <= '1';
		when s4 => cs_dis(4) <= '1';
		when s5 => cs_dis(5) <= '1';
		when s6 => cs_dis(6) <= '1';
		when s7 => cs_dis(7) <= '1';
		--when others => null;
	 end case;
	 
	 --阴极给出数字
	 case num is
	   when "0000" => abcdefg <= "0000001";
		when "0001" => abcdefg <= "1001111";
		when "0010" => abcdefg <= "0010010";
		when "0011" => abcdefg <= "0000110";
		when "0100" => abcdefg <= "1001100";
		when "0101" => abcdefg <= "0100100";
		when "0110" => abcdefg <= "0100000";
		when "0111" => abcdefg <= "0001111";
		when "1000" => abcdefg <= "0000000";
		when "1001" => abcdefg <= "0000100";
		when "1010" => abcdefg <= "0001000";
		when "1011" => abcdefg <= "1100000";
		when "1100" => abcdefg <= "0110001";
		when "1101" => abcdefg <= "1000010";
		when "1110" => abcdefg <= "0110000";
		when "1111" => abcdefg <= "0111000";
		when others => null;
	 end case;
  end process;
  
end arch_exp3;