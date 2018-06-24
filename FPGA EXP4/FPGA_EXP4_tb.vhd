library ieee;
use ieee.std_logic_1164.all;

entity FPGA_EXP4_tb is
end FPGA_EXP4_tb;

architecture arch_exp4_tb of FPGA_EXP4_tb is
  component FPGA_EXP4
    port(clk      :in std_logic;
         row      :in std_logic_vector(0 to 3);
		   col      :out std_logic_vector(0 to 3);
		   abcdefg  :out std_logic_vector(0 to 6);
		   positiv  :out std_logic
		   );
  end component;
  
  signal clk      :std_logic;
  signal row      :std_logic_vector(0 to 3);
  signal col      :std_logic_vector(0 to 3);
  signal abcdefg  :std_logic_vector(0 to 6);
  signal positiv  :std_logic;
begin
  tb:FPGA_EXP4 port map(clk, row, col, abcdefg, positiv);

  p_clk:
  process
  begin
    clk <= '0';
	 wait for 10 ns;
	 clk <= '1';
	 wait for 10 ns;
  end process;
  
  process
  begin
    row <= "1011";
	 wait for 40 us;
		
	 row <= "1101";
	 wait for 40 us;
  end process;
  
  
end arch_exp4_tb;