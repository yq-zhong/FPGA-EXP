library ieee;
use ieee.std_logic_1164.all;

entity FPGA_EXP3_tb is
end FPGA_EXP3_tb;

architecture arch_exp3_tb of FPGA_EXP3_tb is
  component FPGA_EXP3
    port(clk      :in std_logic;
         num_lock :in std_logic_vector(0 to 3);
		   cs_lock  :in std_logic_vector(0 to 2);
		   lock     :in std_logic;
		   abcdefg  :out std_logic_vector(0 to 6);
		   cs_dis   :out std_logic_vector(0 to 7)
		  );
  end component;
  signal clk      :std_logic;
  signal num_lock :std_logic_vector(0 to 3);
  signal cs_lock  :std_logic_vector(0 to 2);
  signal lock     :std_logic;
  signal abcdefg  :std_logic_vector(0 to 6);
  signal cs_dis   :std_logic_vector(0 to 7);
	
begin
	tb :FPGA_EXP3 port map(clk, num_lock, cs_lock, lock, abcdefg, cs_dis);
	
	process
	begin
	  wait for 100 ns;
	  num_lock <= "1111";
	  cs_lock <= "010";
	  lock <= '0';
	  wait for 10 ns;
	  lock <= '1';
	  wait for 10 ns;
	end process;
	
	
	p_clk:
	process
	begin
    clk <= '0';
	   wait for 10 ns;
	 clk <= '1';
	   wait for 10 ns;
   end process;
end arch_exp3_tb;