library ieee;
use ieee.std_logic_1164.all;

entity CodedLock_tb is
end CodedLock_tb;

architecture arch_tb of CodedLock_tb is
  component FPGA_EXP_CodedLock
    port(clk    :in std_logic;--原始50MHz时钟
         set    :in std_logic;--1为设置密码,0为输入密码
		   start  :in std_logic;--上升沿表示键盘开始输入第一个数
		 
		   row   :in std_logic_vector(0 to 3);--键盘行输入扫描信号
		   col   :out std_logic_vector(0 to 3);--键盘列输出扫描信号
		 
		   cs_dis  :out std_logic_vector(0 to 7); --数码管片选
		   abcdefg :out std_logic_vector(0 to 6); --显示的数
		   buzz    :buffer std_logic; --报警时蜂鸣
		   flash   :buffer std_logic  --报警时闪烁
		   );
  end component;
  
  signal clk :std_logic;
  signal clk_keyboard, clk_dis, clk_flash :std_logic; 
  signal lock :std_logic;
  signal psw_3, psw_2, psw_1, psw_0 :std_logic_vector(0 to 3);
  signal num_3, num_2, num_1, num_0 :std_logic_vector(0 to 3);
  signal input_3, input_2, input_1, input_0 :std_logic_vector(0 to 3);
begin
  p_clk:
  process
  begin
    clk <= '0';
	 wait for 10 ns;
	 clk <= '1';
	 wait for 10 ns;
  end process;
  
end arch_tb;