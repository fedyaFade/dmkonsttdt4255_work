--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:54:20 05/03/2012
-- Design Name:   
-- Module Name:   E:/My-documents/Dropbox/tdt4255_final/single_cycle/tb_toplevel.vhd
-- Project Name:  single_cycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: toplevel
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_toplevel IS
END tb_toplevel;
 
ARCHITECTURE behavior OF tb_toplevel IS 
 
  -- Component Declaration for the Unit Under Test (UUT)
  COMPONENT toplevel
	Port (
		clk            : in STD_LOGIC;
		reset          : in STD_LOGIC;
		command        : in  STD_LOGIC_VECTOR (0 to 31);
		bus_address_in : in  STD_LOGIC_VECTOR (0 to 31);
		bus_data_in    : in  STD_LOGIC_VECTOR (0 to 31);
		status         : out  STD_LOGIC_VECTOR (0 to 31);
		bus_data_out   : out  STD_LOGIC_VECTOR (0 to 31)
	); 
   END COMPONENT;
    
   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal command : std_logic_vector(0 to 31) := (others => '0');
   signal bus_address_in : std_logic_vector(0 to 31) := (others => '0');
   signal bus_data_in : std_logic_vector(0 to 31) := (others => '0');

 	--Outputs
   signal status : std_logic_vector(0 to 31);
   signal bus_data_out : std_logic_vector(0 to 31);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
	
	constant zero : std_logic_vector(0 to 31)  := "00000000000000000000000000000000";
	constant zero64b: std_logic_vector(0 to 63):="0000000000000000000000000000000000000000000000000000000000000000";
	constant addr1 : std_logic_vector(0 to 31) := "00000000000000000000000000000001";
	constant addr2 : std_logic_vector(0 to 31) := "00000000000000000000000000000010";
	constant addr3 : std_logic_vector(0 to 31) := "00000000000000000000000000000011";
	constant addr4 : std_logic_vector(0 to 31) := "00000000000000000000000000000100";
	constant addr5 : std_logic_vector(0 to 31) := "00000000000000000000000000000101";
	constant addr6 : std_logic_vector(0 to 31) := "00000000000000000000000000000110";
	constant addr7 : std_logic_vector(0 to 31) := "00000000000000000000000000000111";
	constant addr8 : std_logic_vector(0 to 31) := "00000000000000000000000000001000";
	constant addr9 : std_logic_vector(0 to 31) := "00000000000000000000000000001001";
	constant addr10: std_logic_vector(0 to 31) := "00000000000000000000000000001010";
  constant addr11: std_logic_vector(0 to 31) := "00000000000000000000000000001011";
  constant addr12: std_logic_vector(0 to 31) := "00000000000000000000000000001100";
  constant addr13: std_logic_vector(0 to 31) := "00000000000000000000000000001101";
  constant addr14: std_logic_vector(0 to 31) := "00000000000000000000000000001110";
  constant addr15: std_logic_vector(0 to 31) := "00000000000000000000000000001111";
  constant addr16: std_logic_vector(0 to 31) := "00000000000000000000000000010000";
  constant addr17: std_logic_vector(0 to 31) := "00000000000000000000000000010001";
  constant addr18: std_logic_vector(0 to 31) := "00000000000000000000000000010010";
  constant addr19: std_logic_vector(0 to 31) := "00000000000000000000000000010011";

  -- This is written to memory initially
  constant data1 : std_logic_vector(0 to 31):= "00000000000000000000000000000001";--fix this datasize problem
	constant data2 : std_logic_vector(0 to 31):= "00000000000000000000000000100000";
  
  -- These are the instructions executed by the CPU (loaded to instruction-memory)
  -- See ins.txt for what they actually mean (that is a file used when loading them to the FPGA)
  constant ins0  : std_logic_vector(0 to 31) := X"8C010002";
  constant ins1  : std_logic_vector(0 to 31) := X"8C020002";
  constant ins2  : std_logic_vector(0 to 31) := X"8C020002";
  constant ins3  : std_logic_vector(0 to 31) := X"00000000";--wvliwmultiply $2,$2
  constant ins4  : std_logic_vector(0 to 31) := X"8C0B0001";
  constant ins5  : std_logic_vector(0 to 31) := X"8C0C0002";
  constant ins6  : std_logic_vector(0 to 31) := X"00221820";--add $3, $1, $2
  constant ins7  : std_logic_vector(0 to 31) := X"AC030004";
  constant ins8  : std_logic_vector(0 to 31) := X"AC030006";
  constant ins9  : std_logic_vector(0 to 31) := X"00007812";--MFLO $15
  constant ins10 : std_logic_vector(0 to 31) := X"3C030006";--lui $3, 6 forwarded to the add insturction 
  constant ins11 : std_logic_vector(0 to 31) := X"AC030008";--sw $3, 8($0)
  constant ins12 : std_logic_vector(0 to 31) := X"00231820";--add $3, $1, $3
  constant ins13 : std_logic_vector(0 to 31) := X"AC030009";
  	     constant ins14 : std_logic_vector(0 to 31) := X"00000000";--lw adresse 1 i 11
		    	     constant ins15 : std_logic_vector(0 to 31) := X"00000000"; --lw adresse 2 i 12
					  		    	     constant ins16 : std_logic_vector(0 to 31) := X"016B5820"; --add $11,$11,$11
    constant ins17 : std_logic_vector(0 to 31) := X"018B082A";--slt 1 12 11
  constant ins18 : std_logic_vector(0 to 31) := X"156CFFFD";--bne $11, $12, -3
  constant ins19 : std_logic_vector(0 to 31) := X"1000FFFD";
   
  -- Used to control the COM-module
  constant CMD_IDLE	: std_logic_vector(0 to 31) := "00000000000000000000000000000000";
	constant CMD_WI	  : std_logic_vector(0 to 31) := "00000000000000000000000000000001";
	constant CMD_RD	  : std_logic_vector(0 to 31) := "00000000000000000000000000000010";
	constant CMD_WD	  : std_logic_vector(0 to 31) := "00000000000000000000000000000011";
	constant CMD_RUN	: std_logic_vector(0 to 31) := "00000000000000000000000000000100";
	
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: toplevel PORT MAP (
    clk => clk,
    reset => reset,
    command => command,
    bus_address_in => bus_address_in,
    bus_data_in => bus_data_in,
    status => status,
    bus_data_out => bus_data_out
  );
		  
  -- Clock process definitions
  clk_process :process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;
 

  -- Stimulus process
  stim_proc: process
  begin		
	
    -- hold reset state for 40 ns.
	 reset<='1';
    wait for 40 ns;	
	 reset<='0';

    -- insert stimulus here 
    
		-- INSTR: WRITE DATA TO DMEM
		command <= CMD_WD;					
    bus_address_in <= addr1;
    bus_data_in <= data1;
    wait for clk_period*3;
      
    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
		
    command <= CMD_WD;					
    bus_address_in <= addr2;
    bus_data_in <= data2;
    wait for clk_period*3;
      
    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
		
    -- Add instruction 0
		command <= CMD_WI;					
    bus_address_in <= zero;
    bus_data_in <= ins0;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 1
    command <= CMD_WI;          
    bus_address_in <= addr1;
    bus_data_in <= ins1;
    wait for clk_period*3;
    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
    -- Add instruction 2
    command <= CMD_WI;          
    bus_address_in <= addr2;
    bus_data_in <= ins2;
    wait for clk_period*3;

     command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 3
    command <= CMD_WI;          
    bus_address_in <= addr3;
    bus_data_in <= ins3;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 4
    command <= CMD_WI;          
    bus_address_in <= addr4;
    bus_data_in <= ins4;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 5
    command <= CMD_WI;          
    bus_address_in <= addr5;
    bus_data_in <= ins5;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 6
    command <= CMD_WI;          
    bus_address_in <= addr6;
    bus_data_in <= ins6;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 7
    command <= CMD_WI;          
    bus_address_in <= addr7;
    bus_data_in <= ins7;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 8
    command <= CMD_WI;          
    bus_address_in <= addr8;
    bus_data_in <= ins8;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 9
    command <= CMD_WI;          
    bus_address_in <= addr9;
    bus_data_in <= ins9;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 10
    command <= CMD_WI;          
    bus_address_in <= addr10;
    bus_data_in <= ins10;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 11
    command <= CMD_WI;          
    bus_address_in <= addr11;
    bus_data_in <= ins11;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 12
    command <= CMD_WI;          
    bus_address_in <= addr12;
    bus_data_in <= ins12;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 13
    command <= CMD_WI;          
    bus_address_in <= addr13;
    bus_data_in <= ins13;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 14
    command <= CMD_WI;          
    bus_address_in <= addr14;
    bus_data_in <= ins14;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;

    -- Add instruction 15
    command <= CMD_WI;          
    bus_address_in <= addr15;
    bus_data_in <= ins15;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
	 
	     -- Add instruction 16
    command <= CMD_WI;          
    bus_address_in <= addr16;
    bus_data_in <= ins16;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
	 	 
	     -- Add instruction 17
    command <= CMD_WI;          
    bus_address_in <= addr17;
    bus_data_in <= ins17;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
	 
	 	     -- Add instruction 18
    command <= CMD_WI;          
    bus_address_in <= addr18;
    bus_data_in <= ins18;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
	 
	 	 
	 	     -- Add instruction 19
    command <= CMD_WI;          
    bus_address_in <= addr19;
    bus_data_in <= ins19;
    wait for clk_period*3;

    command <= CMD_IDLE;					
    bus_address_in <= zero;
    bus_data_in <= zero;
    wait for clk_period*3;
		
    -- Run CPU!
		command <= CMD_RUN;					
    bus_address_in <= zero;
    bus_data_in <= zero;
		wait for clk_period*100;

    wait;
    
 end process;

END;
