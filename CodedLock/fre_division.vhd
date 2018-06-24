library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fre_division is
  port(clk:            in std_logic;  --50MHz
       clk_keyboard:   out std_logic; --1024分频
       clk_dis:        out std_logic; --16分频
		 clk_flash:      out std_logic  --4M分频
		 );
end fre_division;

architecture arch_of_frediv of fre_division is
  signal counter_keyboard :std_logic_vector(0 to 9) :="0000000000";
  signal counter_dis      :std_logic_vector(0 to 3) :="0000";
  signal counter_flash    :std_logic_vector(0 to 21):="0000000000000000000000";
begin
  p_keyboard:
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   counter_keyboard <= counter_keyboard + 1;
		clk_keyboard <= counter_keyboard(0);
	 end if;
  end process;
  
  p_dis:
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   counter_dis <= counter_dis + 1;
		clk_dis <= counter_dis(0);
	 end if;
  end process;
  
  p_flash:
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   counter_flash <= counter_flash + 1;
		clk_flash <= counter_flash(0);
	 end if;
  end process;
end arch_of_frediv;