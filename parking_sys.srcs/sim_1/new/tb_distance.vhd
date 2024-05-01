-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 29.4.2024 10:23:58 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_DistanceCalculation is
end tb_DistanceCalculation;

architecture tb of tb_DistanceCalculation is

    component DistanceCalculation
        port (echo     : in std_logic;
              distance : out std_logic_vector (7 downto 0);
              en_out   : out std_logic;
              clk      : in std_logic);
    end component;

    signal sig_echo     : std_logic;
    signal sig_distance : std_logic_vector (7 downto 0);
    signal sig_en_out   : std_logic;
    signal sig_clk      : std_logic;

    constant TbPeriod : time := 10 us; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : DistanceCalculation
    port map (echo     => sig_echo,
              distance => sig_distance,
              en_out   => sig_en_out,
              clk      => sig_clk);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    sig_clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       sig_echo <= '0';
       wait for 10us;
       sig_echo<='1';
        wait for 20us;
        
       sig_echo <='0';
        

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
      
        wait for 100 ns;
     
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 1000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_DistanceCalculation of tb_DistanceCalculation is
    for tb
    end for;
end cfg_tb_DistanceCalculation;