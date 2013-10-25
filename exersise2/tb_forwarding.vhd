--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:08:00 10/25/2013
-- Design Name:   
-- Module Name:   C:/Users/torbjlan/dmkonsttdt4255_work/exersise2/tb_forwarding.vhd
-- Project Name:  exersise2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Forwarding
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_forwarding IS
END tb_forwarding;
 
ARCHITECTURE behavior OF tb_forwarding IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Forwarding
    PORT(
         ExmemregisterRD : IN  std_logic_vector(4 downto 0);
         MEMWbregisterRD : IN  std_logic_vector(4 downto 0);
         MEMWBregwrite : IN  std_logic;
         EXMEMregwrite : IN  std_logic;
         RS : IN  std_logic_vector(4 downto 0);
         RT : IN  std_logic_vector(4 downto 0);
         forwardA : OUT  std_logic_vector(1 downto 0);
         forwardB : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ExmemregisterRD : std_logic_vector(4 downto 0) := (others => '0');
   signal MEMWbregisterRD : std_logic_vector(4 downto 0) := (others => '0');
   signal MEMWBregwrite : std_logic := '0';
   signal EXMEMregwrite : std_logic := '0';
   signal RS : std_logic_vector(4 downto 0) := (others => '0');
   signal RT : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal forwardA : std_logic_vector(1 downto 0);
   signal forwardB : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Forwarding PORT MAP (
          ExmemregisterRD => ExmemregisterRD,
          MEMWbregisterRD => MEMWbregisterRD,
          MEMWBregwrite => MEMWBregwrite,
          EXMEMregwrite => EXMEMregwrite,
          RS => RS,
          RT => RT,
          forwardA => forwardA,
          forwardB => forwardB
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 100 ns;	
		
		-- The test will first test the ForwardA value,
		-- then ForwardB.
		-- For all hazards, the correct combination will first be set, then
		-- tested by breaking one of the conditions, one at a time, for all conditions.
		-- The output will be reset to it's correct between every of these tests
		-- NOTE TO SELF: NEEDS BETTER DESCRIPTION

		-- Testing first forwardA
		
		-- Default output is 00 at start.
		-- Setting default RS input:
		RS <= "10101";
		
		wait for 40 ns;
		
		-- Testing EX Hazard
		
		-- Setting EXMEMregwrite to 1
		-- Setting ExmemregisterRD to same as RS
		-- Output should be 10
		EXMEMregwrite <= '1';
		ExmemregisterRD <= "10101;
		
		wait for 40 ns;
		-- Setting EXMEMregwrite to 0
		-- Output should be 00
		EXMEMregwrite <= '0';
		
		wait for 40 ns;
		-- Resetting output to 10
		EXMEMregwrite <= '1';
		
		wait for 40 ns;
		-- Setting EXMEMRegisterRD to be differen from RS:
		ExmemregisterRD <= "11111";
		
		wait for 40 ns;
		-- Resetting output to 10
		ExmemregisterRD <= "10101";
		
		wait for 40 ns;
		-- Setting both RS and register to be 00000
		RS <= "00000";
		ExmemregisterRD <= RS;
		
		wait for 40 ns;
		-- Resetting output to 10
		RS <= "10101";
		ExmemregisterRD <= RS;
		

      wait;
   end process;

END;