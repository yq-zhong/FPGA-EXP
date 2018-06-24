library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity keyboard is
  port(clk   :in std_logic;
       row   :in std_logic_vector(0 to 3);
		 col   :out std_logic_vector(0 to 3);
		 num   :out std_logic_vector(0 to 3);
		 clk_new :buffer std_logic
		 );
end keyboard;

architecture arch_key of keyboard is
  type states is (st0, st1, st2,st3);
  signal state :states;
  signal counter :std_logic_vector(9 downto 0) :="0000000000";
begin
  p_fre_div:  
  process(clk)
  begin
    if(clk'event and clk = '1') then
	   counter <= counter + 1;
	   clk_new <= counter(9);
	 end if;
  end process;

  p_st_col:
  process(clk_new)
  begin
    if(clk_new'event and clk_new = '1') then
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
  
  p_col:
  process(clk_new)
  begin
    if(clk_new'event and clk_new = '0') then
	   case state is 
		  when st0 =>
		    case row is 
			   when "0111" => num <= "0001";  --1
				when "1011" => num <= "0100";  --4
				when "1101" => num <= "0111";  --7
				when "1110" => num <= "1110";  --E
				when others => null;
			 end case;
		  when st1 =>
		    case row is 
			   when "0111" => num <= "0010";  --2
				when "1011" => num <= "0101";  --5
				when "1101" => num <= "1000";  --8
				when "1110" => num <= "0000";  --0
				when others => null;
			 end case;
		  when st2 =>
		    case row is 
			   when "0111" => num <= "0011";  --3
				when "1011" => num <= "0110";  --6
				when "1101" => num <= "1001";  --9
				when "1110" => num <= "1111";  --F
				when others => null;
			 end case;
		  when st3 =>
		    case row is 
			   when "0111" => num <= "1010";  --A
				when "1011" => num <= "1011";  --B
				when "1101" => num <= "1100";  --C
				when "1110" => num <= "1101";  --D
				when others => null;
			 end case;
		end case;
	 end if;
  end process;
  
  
end arch_key;