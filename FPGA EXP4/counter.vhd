library ieee;
use ieee.std_logic_1164.all;

entity counter is
  port(clk    :in std_logic;
       state  :buffer std_logic_vector(0 to 1)
		 );
end counter;

architecture arch_count of counter is
begin
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   case state is
		  when "00" => state <= "01";
		  when "01" => state <= "10";
		  when "10" => state <= "11";
		  when "11" => state <= "00";
		  when others => null;
		end case;
	 end if;
  end process;
end arch_count;