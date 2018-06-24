library ieee;
use ieee.std_logic_1164.all;

entity FPGA_EXP2 is
  port(clk   :in std_logic;
		 sel   :in std_logic;
		 result:out std_logic
		 );
end FPGA_EXP2;

architecture arch_FPGA_EXP2 of FPGA_EXP2 is
  component SeqGen_1
    port(clk   :in std_logic;
		   seq_1 :out std_logic
		  );
  end component;
  
  component SeqGen_2
    port(clk   :in std_logic;
		   seq_2 :out std_logic
        );
  end component;
  
  component Selector
    port(seq_in_1 :in std_logic;
         seq_in_2 :in std_logic;
		   sel      :in std_logic;
		   seq_out  :out std_logic
        );
  end component;
  
  component Detector
    port(clk    :in std_logic;
         seq_in :in std_logic;
		   result :out std_logic
        );
  end component;
  
  signal seq_1 :std_logic;
  signal seq_2 :std_logic;
  signal seq_sel :std_logic;
  
begin
  SG1:SeqGen_1 port map(clk, seq_1);
  SG2:SeqGen_2 port map(clk, seq_2);
  SL :Selector port map(seq_1, seq_2, sel, seq_sel);
  DT :Detector port map(clk, seq_sel, result);
end arch_FPGA_EXP2;