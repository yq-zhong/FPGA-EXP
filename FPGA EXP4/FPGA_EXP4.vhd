library ieee;
use ieee.std_logic_1164.all;

entity FPGA_EXP4 is
  port(clk  :in std_logic;
       row   :in std_logic_vector(0 to 3);
		 col   :out std_logic_vector(0 to 3);
		 abcdefg  :out std_logic_vector(0 to 6);
		 positiv  :out std_logic
		 );
end FPGA_EXP4;

architecture arch_exp4 of FPGA_EXP4 is
  component keyboard
    port(clk   :in std_logic;
         row   :in std_logic_vector(0 to 3);
		   col   :out std_logic_vector(0 to 3);
		   num   :out std_logic_vector(0 to 3);
			clk_new :buffer std_logic
		   );
  end component;
  
  component display
    port(clk_new :in std_logic;
	      num  :in std_logic_vector(0 to 3);
         abcdefg  :out std_logic_vector(0 to 6);
		   positiv  :out std_logic
		   );
  end component;
  
  signal num :std_logic_vector(0 to 3);
  signal clk_new :std_logic;
begin
  KB: keyboard port map(clk, row, col, num, clk_new);
  DIS:display port map(clk_new, num, abcdefg, positiv);
end arch_exp4;