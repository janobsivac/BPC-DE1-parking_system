library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_gen is
    port (
        clk : in std_logic;                 -- Vstupní hodinový signál
        clk_mod : out std_logic;            -- Generovaný hodinový signál
        divide_value : in integer := 2000   -- Hodnota dělení pro generovanou frekvenci (výchozí: 2000)
    );
end clk_gen;

architecture Behavioral of clk_gen is

    signal counter, divide : integer := 0;   -- Vnitřní čítač a hodnota dělení inicializované na 0

begin

    divide <= divide_value;                 -- Nastavení hodnoty dělení

    process(clk)
    begin				    
        if rising_edge(clk) then           
            if counter < divide/2-1 then    -- Podmínka pro proběhnutí couteru pro clk_mod <= '0'
                counter <= counter + 1;      -- Spuštění čítače
                clk_mod <= '0';              
            elsif counter < divide-1 then   -- Podmínka pro proběhnnutí couteru pro clk_mod <= '1'
                counter <= counter + 1;      -- Spuštění čítače
                clk_mod <= '1';              
            else                             
                clk_mod <= '0';    		-- Resetovani          
                counter <= 0;                
            end if;
        end if;
    end process;   

end Behavioral;
