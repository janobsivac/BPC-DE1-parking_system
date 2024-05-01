library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DistanceCalculation is
    Port (
        echo     : in  STD_LOGIC;			-- Vstupní signál echo ze senzoru
        distance : out STD_LOGIC_VECTOR (7 downto 0);   -- Výstupní signál představující vypočtenou vzdálenost
        en_out : out std_logic;				-- Výstupní signál, který posílá znamení triggeru pro vyslání signálu
        clk    : in std_logic 				-- Vstupní hodinový signál
        
    );
end DistanceCalculation;

architecture Behavioral of DistanceCalculation is
    signal distance_value : std_logic_vector(7 downto 0) := (others => '0');

    signal sig_distance : integer := 0;			--založené signály pro výpočty
    signal sig_running : std_logic;
    signal counter : integer range 0 to 1000 :=0;
    signal result_counter : integer :=0;
    signal result : integer :=0;
    signal echo_delayed : std_logic;
    signal vzdalenost : integer :=0;
    
    
begin

    process(clk)
        begin
        if rising_edge(clk) then
        echo_delayed <= echo;				-- Zpoždění echo signálu pro detekci náběžných a sestupných hran
        end if;
    end process;
    
    
    process(clk)
    begin
    if rising_edge(clk) then
    
        sig_running <= '0';
        counter <=  0;

        if (echo and not echo_delayed)='1' then           -- Detekce náběžné hrany echo signálu

           
                counter <= counter + 1;			  -- Spusteni citace
        
        elsif ( not echo and echo_delayed)='1' then       -- Detekce sestupné hrany echo signálu
            result_counter <= counter;			  -- ulozeni hodnoty
       
       
        result <= result_counter * 10;			  -- Škálování result_counteru pro získání výsledku v mikrosekundách
        
        
        vzdalenost <= ((result * 340) / 2); 		  -- Výpočet vzdálenosti na základě času letu echo pulzu

              
        if vzdalenost < 46 then 			  -- Maximální námi měřená vzdálenost    
           distance_value <= std_logic_vector(to_unsigned(vzdalenost, 8));  --ukládání vzdálenosti v 8 bitech
        else
           distance_value <= "11111111"; -- Nemerena vzdalenost
        end if;
       end if;
         
      sig_running <= '1';
                                                          
        if sig_running = '1' then			-- Aktivace výstupního signálu en_out
            en_out <= '1';
            
        end if;        
   end if;
        
    end process;
    
    distance <= distance_value;				-- Přiřazení vypočtené vzdálenosti výstupnímu signálu
    
end Behavioral;
    
    distance <= distance_value;
    
end Behavioral;
