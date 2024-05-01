library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

entity Trigger is
 generic (
        N_PERIODS : integer := 3 -- Default number of clk periodes to generate one pulse
    );
    Port (
        clk : in  STD_LOGIC;
        rst       : in  STD_LOGIC;
        trigger   : out STD_LOGIC;
        en_in        : in std_logic
    );
end Trigger;

architecture Behavioral of Trigger is
    signal trigger_counter : integer range 0 to N_PERIODS - 1;
    
begin

    
    
    p_clk_enable : process(clk) is
    begin
    
      if (rising_edge(clk) and en_in = '1') then  --reakce na příchozí en_in a rst tlačítko
        if rst = '1' then
            trigger_counter <= 0;

        elsif (trigger_counter < (N_PERIODS - 1)) then 
                                                               
           trigger_counter <= trigger_counter + 1;
         else
                                                               
           trigger_counter <= 0;
          
            end if;
        end if;
        
        if (en_in = '0') then
                    trigger_counter <= 0;
        end if;
        
    end process p_clk_enable;
    
    
    trigger <= '1' when (trigger_counter = N_PERIODS - 1) else '0';

end Behavioral;
