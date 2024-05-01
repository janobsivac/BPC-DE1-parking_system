library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Driver is
    Port (
        distance : in  STD_LOGIC_VECTOR (7 downto 0);
        rst : in std_logic;
        segment_data : out STD_LOGIC_VECTOR (6 downto 0);
        LED : out std_logic_vector (8 downto 0)
    );
end Driver;

architecture Behavioral of Driver is
begin
    process(distance)
    begin
    
    if (rst = '1') then
    segment_data <= "1111111";  -- Clear the display
        
        elsif distance >= "00000000" and distance <= "00000101" then -- Display '1' for 0-5cm
            segment_data <= "1001111"; 
             LED <= "000000001";    --LEDs for 0-5cm     
        elsif distance >= "00000110" and distance <= "00001010" then -- Display '2' for 6-10cm
            segment_data <= "0010010";
             LED <= "000000011";    --LEDs for 6-10cm 
        elsif distance >= "00001011" and distance <= "00001111" then -- Display '3' for 11-15cm
            segment_data <= "0000110";
            LED <= "000000111";    --LEDs for 11-15cm
        elsif distance >= "00010000" and distance <= "00010011" then -- Display '4' for 16-20cm
            segment_data <= "1001100";
            LED <= "000001111";    --LEDs for 16-20cm
        elsif distance >= "00010100" and distance <= "00010110" then -- Display '5' for 21-25cm
            segment_data <= "0100100";
            LED <= "000011111";    --LEDs for 21-25cm
        elsif distance >= "00010111" and distance <= "00011001" then -- Display '6' for 26-30cm
            segment_data <= "0100000";
             LED <= "000111111";    --LEDs for 26-30cm            
        elsif distance >= "00011010" and distance <= "00011011" then -- Display '7' for 31-35cm
            segment_data <= "0001111";
             LED <= "001111111";    --LEDs for 31-35cm            
        elsif distance >= "00011100" and distance <= "00011101" then -- Display '8' for 36-40cm
            segment_data <= "0000000";
             LED <= "011111111";    --LEDs for 36-40cm            
        elsif distance >= "00011110" and distance <= "00011111" then -- Display '9' for 41-45cm
            segment_data <= "0000100";
             LED <= "111111111";    --LEDs for 41-45cm    
        else  segment_data <= "1111111";  -- Clear the display
             LED <= "000000000";    
                 
        end if;
    end process;
end Behavioral;
