library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopLevel is                             --definovaní portu v top_level
    Port (
        CLK100MHZ    : in  STD_LOGIC; --hodiny
        BTNC         : in  STD_LOGIC; --rst tlacitko
        echo_in      : in  STD_LOGIC; --vstupní signál ze senzoru
        trigger_out  : out STD_LOGIC; --výstupní signál do senzoru
        CA           : out std_logic; --katody pro 7segmentovy displej 
        CB           : out std_logic; 
        CC           : out std_logic; 
        CD           : out std_logic; 
        CE           : out std_logic; 
        CF           : out std_logic; 
        CG           : out std_logic;  
        AN : out STD_LOGIC_VECTOR (7 downto 0); --anody
        DP : out STD_LOGIC;
        LED : out std_logic_vector (8 downto 0)); --ledky pro vzdalenost
        
end TopLevel;

architecture Behavioral of TopLevel is

    component clk_gen is --component ke cloclConverter
    port(   clk : in std_logic;
            clk_mod : out std_logic;
            divide_value : in integer:= 2000
            );
    end component;

    component Trigger is --component k Triggeru
    generic (
    N_PERIODS : integer
    );
        Port (
            clk : in  STD_LOGIC;
            rst : in  STD_LOGIC;
            trigger : out STD_LOGIC;
            en_in   : in std_logic
        );
    end component;

    component DistanceCalculation is --component k DistanceCalculation
        Port (
            echo     : in  STD_LOGIC;
            distance : out STD_LOGIC_VECTOR (7 downto 0);
            en_out : out std_logic;
            clk    : in std_logic 
        );
    end component;

    component Driver is --component k Driveru
        Port (
            distance : in  STD_LOGIC_VECTOR (7 downto 0);
            segment_data : out STD_LOGIC_VECTOR (6 downto 0);
            rst : in std_logic;
            LED : out std_logic_vector (8 downto 0)
        );
    end component;

    signal distance_signal : std_logic_vector(7 downto 0); --vytvorene signály pro propojeni componentu
    signal sig_running : std_logic;
    signal clk_mod_signal : std_logic;

begin

    clock_instance : clk_gen    --napojeni vstupnich_vystupnich portu 
    port map(
    clk => CLK100MHZ,
    clk_mod => clk_mod_signal);

    trigger_instance: Trigger     --napojeni vstupnich_vystupnich portu 
    generic map (
            N_PERIODS => 2
        )
    port map (
        clk => clk_mod_signal,
        rst => BTNC,
        trigger => trigger_out,
        en_in => sig_running 
    );

    distance_instance: DistanceCalculation port map (    --napojeni vstupnich_vystupnich portu 
        echo => echo_in,
        distance => distance_signal,
        en_out => sig_running,
        clk => clk_mod_signal
    );

    driver_instance: Driver port map (    --napojeni vstupnich_vystupnich portu 
        distance => distance_signal,
        rst => BTNC,
        segment_data(6) => CA, --napojeni segment_data na katody
        segment_data(5) => CB,
        segment_data(4) => CC,
        segment_data(3) => CD,
        segment_data(2) => CE,
        segment_data(1) => CF,
        segment_data(0) => CG,
        
        LED => LED                 
        );

 
    
    AN <= b"1111_1110"; --urceni rozsviceni 7segmentoveho dispeje
    DP <= '1';
end Behavioral;

