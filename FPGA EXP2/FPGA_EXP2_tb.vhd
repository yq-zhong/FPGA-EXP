library ieee;
use ieee.std_logic_1164.all;

entity FPGA_EXP2_tb is
end FPGA_EXP2_tb;

architecture arch_FE2_tb of FPGA_EXP2_tb is
  component FPGA_EXP2
    port(clk   :in std_logic;
		   sel   :in std_logic;
		   result:out std_logic
		  );
  end component;
  signal clk, sel, result :std_logic;
  
begin
  tb: FPGA_EXP2 port map(clk, sel, result);
  
  process
  begin
    for i in 0 to 49 loop
		sel <= '0';
		wait for 20 ns;
	 end loop;
	 
	 for i in 0 to 49 loop
		sel <= '1';
		wait for 20 ns;
	 end loop;
  end process;

  --generate clk signal
  process
  begin
    clk <= '0';
	 wait for 10 ns;
	 clk <= '1';
	 wait for 10 ns;
  end process;
end arch_FE2_tb;