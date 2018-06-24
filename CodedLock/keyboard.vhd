library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity keyboard is
  port(clk   :in std_logic;--1024分频
       row   :in std_logic_vector(0 to 3);
		 col   :out std_logic_vector(0 to 3);
		 
		 psw_3 :out std_logic_vector(0 to 3);
		 psw_2 :out std_logic_vector(0 to 3);
		 psw_1 :out std_logic_vector(0 to 3);
		 psw_0 :out std_logic_vector(0 to 3);
		 
		 num_3 :out std_logic_vector(0 to 3);
		 num_2 :out std_logic_vector(0 to 3);
		 num_1 :out std_logic_vector(0 to 3);
		 num_0 :out std_logic_vector(0 to 3);
		 
		 lock  :out std_logic;
		 set   :in std_logic;
		 start :in std_logic   --上升沿表示开始输入
		 );
end keyboard;

architecture arch_key of keyboard is
  type states is (st0, st1, st2,st3);
  signal state :states;
  signal st_num:states;    --指示当前输入的是哪位数
  signal flag_new :std_logic; --上升沿表示键盘有新的数输入
  signal num :std_logic_vector(0 to 3);
  signal isnum_col_0, isnum_col_1, isnum_col_2, isnum_col_3 : boolean;
begin
  p_st_col:
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   case state is
		  when st0 =>
		    state <= st1;
			 col <= "1011";
		  when st1 =>
		    state <= st2;
			 col <= "1101";
		  when st2 =>
		    state <= st3;
			 col <= "1110";
		  when st3 =>
		    state <= st0;
			 col <= "0111";
		end case;
	 end if;
  end process;
  
  p_col_output:
  process(clk)
  begin
    if(clk'event and clk = '0') then
	   case state is 
		  when st0 =>
		    case row is 
			   when "0111" => num <= "0001"; isnum_col_0 <= true;  --1
				when "1011" => num <= "0100"; isnum_col_0 <= true;  --4
				when "1101" => num <= "0111"; isnum_col_0 <= true;  --7
				when "1110" => num <= "1110"; isnum_col_0 <= true;  --E
				when others => isnum_col_0 <= false;
			 end case;
		  when st1 =>
		    case row is 
			   when "0111" => num <= "0010"; isnum_col_1 <= true;  --2
				when "1011" => num <= "0101"; isnum_col_1 <= true;  --5
				when "1101" => num <= "1000"; isnum_col_1 <= true;  --8
				when "1110" => num <= "0000"; isnum_col_1 <= true;  --0
				when others => isnum_col_1 <= false;
			 end case;
		  when st2 =>
		    case row is 
			   when "0111" => num <= "0011"; isnum_col_2 <= true;  --3
				when "1011" => num <= "0110"; isnum_col_2 <= true;  --6
				when "1101" => num <= "1001"; isnum_col_2 <= true;  --9
				when "1110" => num <= "1111"; isnum_col_2 <= true;  --F
				when others => isnum_col_2 <= false;
			 end case;
		  when st3 =>
		    case row is 
			   when "0111" => num <= "1010"; isnum_col_3 <= true;  --A
				when "1011" => num <= "1011"; isnum_col_3 <= true;  --B
				when "1101" => num <= "1100"; isnum_col_3 <= true;  --C
				when "1110" => num <= "1101"; isnum_col_3 <= true;  --D
				when others => isnum_col_3 <= false;
			 end case;
		end case;
	 end if;
  end process;
  
  p_change_flag:
  process(state)
  begin
    if(state = st3) then
	   if(isnum_col_0 = false and isnum_col_1 = false and isnum_col_2 = false and isnum_col_3 = false) then
		  flag_new <= '0';
		else
		  flag_new <= '1';
		end if;
	 end if;
  end process;
  
  p_input:
  process(start, flag_new)
  begin
    if(start = '1') then
	    st_num <= st3;
	 elsif(flag_new'event and flag_new = '1') then
	    case st_num is
		    when st3 => st_num <= st2;
			 when st2 => st_num <= st1;
			 when st1 => st_num <= st0;
			 when others => null;
		 end case;
	 else null;
	 end if;
  end process;
  
  p_new_num_input:
  process(flag_new)
  begin
    if(flag_new'event and flag_new = '1') then
	   case set is
		  when '1' =>
		    case st_num is
		      when st3 => psw_3 <= num; lock <= '0';
		      when st2 => psw_2 <= num; lock <= '0';
		      when st1 => psw_1 <= num; lock <= '0';
		      when st0 => psw_0 <= num; lock <= '1'; --4位已全部输入
		    end case;
		  when '0' =>
		    case st_num is
		      when st3 => num_3 <= num; lock <= '0';
		      when st2 => num_2 <= num; lock <= '0';
		      when st1 => num_1 <= num; lock <= '0';
		      when st0 => num_0 <= num; lock <= '1'; --4位已全部输入
		    end case;
		  when others => null;
		end case;
	 end if;
  end process;
  
end arch_key;