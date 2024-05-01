-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 29.4.2024 08:16:40 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Trigger is
end tb_Trigger;

architecture tb of tb_Trigger is

    component Trigger
        port (clk     : in std_logic;
              rst     : in std_logic;
              trigger : out std_logic;
              en_in   : in std_logic);
    end component;

    signal sig_clk     : std_logic;
    signal sig_rst     : std_logic;
    signal sig_trigger : std_logic;
    signal sig_en_in   : std_logic;

    constant TbPeriod : time := 10 us; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Trigger
    port map (clk     => sig_clk,
              rst     => sig_rst,
              trigger => sig_trigger,
              en_in   => sig_en_in);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    sig_clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        sig_en_in <= '0';
        wait for 5 us;
        sig_en_in <= '1';
        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        sig_rst <= '1';
        wait for 5 us;
        sig_rst <= '0';
        
        wait for 30us;
        
        sig_en_in <= '0';
        wait for 20 us;
        sig_en_in <= '1';
        


        
   
        -- EDIT Add stimuli here
        wait for 10000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Trigger of tb_Trigger is
    for tb
    end for;
end cfg_tb_Trigger;