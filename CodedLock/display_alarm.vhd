library ieee;
use ieee.std_logic_1164.all;

entity display_alarm is
  port(clk   :in std_logic;
       clk_flash :in std_logic;
       lock  :in std_logic;
		 set   :in std_logic; --1为设置密码，0为输入密码
		 start :in std_logic;
       
       psw_3 :in std_logic_vector(0 to 3);  --密码
       psw_2 :in std_logic_vector(0 to 3);
       psw_1 :in std_logic_vector(0 to 3);
       psw_0 :in std_logic_vector(0 to 3);
  
       num_3 :in std_logic_vector(0 to 3);  --解锁的数
       num_2 :in std_logic_vector(0 to 3);
       num_1 :in std_logic_vector(0 to 3);
       num_0 :in std_logic_vector(0 to 3);
		 
		 cs_dis  :out std_logic_vector(0 to 7); --数码管片选
		 abcdefg :out std_logic_vector(0 to 6);
		 flash   :buffer std_logic
		 );
end display_alarm;

architecture arch_display_alarm of display_alarm is
  type states is (s0, s1, s2, s3, s4, s5, s6, s7);
  signal counter :states;
  signal num_dis :std_logic_vector(0 to 3);
  signal alarm   :std_logic;
  signal isright :boolean; --密码输入完毕后判读密码是否正确
begin
  p_count:
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   case counter is
		  when s0 => counter <= s1;
		             num_dis <= psw_2;
		  when s1 => counter <= s2;
		             num_dis <= psw_1;
		  when s2 => counter <= s3;
		             num_dis <= psw_0;
		  when s3 => counter <= s4;
		             num_dis <= num_3;
		  when s4 => counter <= s5;
		             num_dis <= num_2;
		  when s5 => counter <= s6;
		             num_dis <= num_1;
		  when s6 => counter <= s7;
		             num_dis <= num_0;
		  when s7 => counter <= s0;
		             num_dis <= psw_3;
		  when others => null;
		end case;
	 end if;
  end process;
  
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
	 end case;
	 
	 --阴极给出数字
	 case num_dis is
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
  
  p_set_alarm:
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   case set is
		  when '1' => --设置密码
		    alarm <= '0';
			 isright <= false;
		  when '0' => --输入密码
		    case lock is
		      when '1' =>
		        if(psw_3 /= num_3 or psw_2 /= num_2 or psw_1 /= num_1 or psw_0 /= num_0) then
			       alarm <= '1';
				    isright <= false;
			     else
			       alarm <= '0';
				    isright <= true;
			     end if;
		      when '0' => 
		        alarm <= '0';
			     isright <= false;
		    end case;
		  when others => null;
		end case;   
	 end if;
  end process;
  
  
  p_alarm:
  process(clk_flash)
  begin
    if(clk_flash'event and clk_flash = '1') then
	    case alarm is
		    when '0' => --非警报状态
			    case isright is
				   when true => --密码正确
						flash <= '1';
					when false => --密码不正确，此时实际上是正在输密码
						flash <= '0';
				 end case;
			 when '1' => --警报状态
			    case flash is
				    when '1' => flash <= '0';
					 when '0' => flash <= '1';
				 end case;
			 when others => null;
		 end case;
	 end if;
  end process;
  
end arch_display_alarm;