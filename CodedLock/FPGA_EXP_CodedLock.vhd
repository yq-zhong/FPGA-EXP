library ieee;
use ieee.std_logic_1164.all;

entity FPGA_EXP_CodedLock is
  port(clk    :in std_logic;--原始50MHz时钟
       set    :in std_logic;--1为设置密码,0为输入密码
		 start  :in std_logic;--上升沿表示键盘开始输入第一个数
		 
		 row   :in std_logic_vector(0 to 3);--键盘行输入扫描信号
		 col   :out std_logic_vector(0 to 3);--键盘列输出扫描信号
		 
		 cs_dis  :out std_logic_vector(0 to 7); --数码管片选
		 abcdefg :out std_logic_vector(0 to 6); --显示的数
		 flash   :buffer std_logic  --报警时闪烁
		 );
end FPGA_EXP_CodedLock;



architecture arch_CodedLock of FPGA_EXP_CodedLock is
  component fre_division
    port(clk:            in std_logic;  --50MHz
         clk_keyboard:   out std_logic; --512分频
         clk_dis:        out std_logic; --16分频
		   clk_flash:      out std_logic  --1M分频
		   );
  end component;
  
  component keyboard
    port(clk   :in std_logic;--512分频
         row   :in std_logic_vector(0 to 3);
		   col   :out std_logic_vector(0 to 3);
		   
			psw_3 :out std_logic_vector(0 to 3);
		   psw_2 :out std_logic_vector(0 to 3);
		   psw_1 :out std_logic_vector(0 to 3);
		   psw_0 :out std_logic_vector(0 to 3);
			
		   num_3 :out std_logic_vector(0 to 3);
		   num_2 :out std_logic_vector(0 to 3);
		   num_1 :out std_logic_vector(0 to 3);
		   num_0 :out std_logic_vector(0 to 3);
		 
		   lock  :out std_logic;
			set   :in std_logic;
		   start :in std_logic   
		   );
  end component;
  
  component display_alarm
    port(clk   :in std_logic;
         clk_flash :in std_logic;
         lock  :in std_logic;
			set   :in std_logic;
       
         psw_3 :in std_logic_vector(0 to 3);  --密码
         psw_2 :in std_logic_vector(0 to 3);
         psw_1 :in std_logic_vector(0 to 3);
         psw_0 :in std_logic_vector(0 to 3);
  
         num_3 :in std_logic_vector(0 to 3);  --解锁的数
         num_2 :in std_logic_vector(0 to 3);
         num_1 :in std_logic_vector(0 to 3);
         num_0 :in std_logic_vector(0 to 3);
		 
		   cs_dis  :out std_logic_vector(0 to 7); --数码管片选
		   abcdefg :out std_logic_vector(0 to 6);
		   flash   :buffer std_logic
		   );
  end component;
 
  signal clk_keyboard, clk_dis, clk_flash :std_logic; 
  signal lock :std_logic;
  signal psw_3, psw_2, psw_1, psw_0 :std_logic_vector(0 to 3);
  signal num_3, num_2, num_1, num_0 :std_logic_vector(0 to 3);
begin
  fd:fre_division port map(clk, clk_keyboard, clk_dis, clk_flash);
  kb:keyboard port map(clk_keyboard, row, col, psw_3, psw_2, psw_1, psw_0, num_3, num_2, num_1, num_0, lock, set, start);
  da:display_alarm port map(clk_dis, clk_flash, lock, set, psw_3, psw_2, psw_1, psw_0, num_3, num_2, num_1, num_0, cs_dis, abcdefg, flash);
end arch_CodedLock;