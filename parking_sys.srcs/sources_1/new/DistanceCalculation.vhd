library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DistanceCalculation is
    Port (
        echo     : in  STD_LOGIC;
        distance : out STD_LOGIC_VECTOR (7 downto 0);
        en_out : out std_logic;
        clk    : in std_logic 
        
    );
end DistanceCalculation;

architecture Behavioral of DistanceCalculation is
    signal distance_value : std_logic_vector(7 downto 0) := (others => '0');

    signal sig_distance : integer := 0;
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
        echo_delayed <= echo;
        end if;
    end process;
    
    
    process(clk)
    begin
    if rising_edge(clk) then
    
        sig_running <= '0';
        counter <=  0;

        if (echo and not echo_delayed)='1' then           -- zjisteni nastupne hrany ECHO
           
                counter <= counter + 1;
        
        elsif ( not echo and echo_delayed)='1' then          -- zjisteni sestupne hrany ECHO
            result_counter <= counter;
       
       
        result <= result_counter * 10;
        
        
        vzdalenost <= ((result * 340) / 2); 

              
        if vzdalenost < 46 then -- Maximální námi m??ená vzdálenost
           distance_value <= std_logic_vector(to_unsigned(vzdalenost, 8));
        else
           distance_value <= "11111111"; -- Nemerena vzdalenost
        end if;
       end if;
         
      sig_running <= '1';
                                                          
        if sig_running = '1' then
            en_out <= '1';
            
        end if;        
   end if;
        
        

        
    end process;
    
    distance <= distance_value;
    
end Behavioral;