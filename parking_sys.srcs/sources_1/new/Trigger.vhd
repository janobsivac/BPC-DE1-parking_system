library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

entity Trigger is
 generic (
        N_PERIODS : integer := 3 -- Default number of clk periodes to generate one pulse
    );
    Port (
        clk     : in  STD_LOGIC;  -- Vstup hodin
        rst     : in  STD_LOGIC;  -- Vstup reset
        trigger : out STD_LOGIC;  -- Výstupní signál impulzu
        en_in   : in  std_logic   -- Vstup povolení čítání
    );
end Trigger;

architecture Behavioral of Trigger is
    signal trigger_counter : integer range 0 to N_PERIODS - 1;
    
begin

    
    
    p_clk_enable : process(clk) is
    begin
    
      if (rising_edge(clk) and en_in = '1') then 		--reakce na nabeznou hranu hodinoveho signalu a vstupniho signalu enable
        if rst = '1' then					--podmínka pro rst
            trigger_counter <= 0;				--nastaveni hodnoty pro rst

        elsif (trigger_counter < (N_PERIODS - 1)) then 		
                                                               
           trigger_counter <= trigger_counter + 1;		--spusteny counter
         else
                                                               
           trigger_counter <= 0;
          
            end if;
        end if;
        
        if (en_in = '0') then
                    trigger_counter <= 0;			--reset čítače pokud není umožněno čítat (en_in)
        end if;
        
    end process p_clk_enable;
    
    -- Generování impulzu, když čítač dosáhne zadaného počtu period
    trigger <= '1' when (trigger_counter = N_PERIODS - 1) else '0';

end Behavioral;
