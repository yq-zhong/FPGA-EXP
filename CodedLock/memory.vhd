library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;

entity memory is
  port(lock     :in std_logic; --上升沿将键盘输入的数锁存
       set      :in std_logic; --1表示设置密码，0无效 
		 clk      :in std_logic;
		 
		 input_3  :in std_logic_vector(0 to 3);  --从键盘送来的最早输入的数
		 input_2  :in std_logic_vector(0 to 3);
		 input_1  :in std_logic_vector(0 to 3);
		 input_0  :in std_logic_vector(0 to 3);  --从键盘送来的最后输入的数
		 
		 psw_3 :out std_logic_vector(0 to 3);  --密码
       psw_2 :out std_logic_vector(0 to 3);
       psw_1 :out std_logic_vector(0 to 3);
       psw_0 :out std_logic_vector(0 to 3);
  
       num_3 :out std_logic_vector(0 to 3);  --解锁的数
       num_2 :out std_logic_vector(0 to 3);
       num_1 :out std_logic_vector(0 to 3);
       num_0 :out std_logic_vector(0 to 3)
       );
end memory;

architecture arch_mem of memory is
begin
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   if(lock = '1') then
		  case set is
	       when '1' =>
		      psw_3 <= input_3;
			   psw_2 <= input_2;
			   psw_1 <= input_1;
			   psw_0 <= input_0;
		    when others => null;
	     end case;
		end if;
	 end if; 
  end process;
end arch_mem;