library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TopLevel is
    Port (
        CLK100MHZ    : in  STD_LOGIC;
        BTNC         : in  STD_LOGIC; 
        echo_in      : in  STD_LOGIC;
        trigger_out  : out STD_LOGIC;
        CA           : out std_logic; 
        CB           : out std_logic; 
        CC           : out std_logic; 
        CD           : out std_logic; 
        CE           : out std_logic; 
        CF           : out std_logic; 
        CG           : out std_logic;  
        AN : out STD_LOGIC_VECTOR (7 downto 0);
        DP : out STD_LOGIC;
        LED : out std_logic_vector (8 downto 0));
        
end TopLevel;

architecture Behavioral of TopLevel is

    component clk_gen is
    port(   clk : in std_logic;
            clk_mod : out std_logic;
            divide_value : in integer:= 2000
            );
    end component;

    component Trigger is
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

    component DistanceCalculation is
        Port (
            echo     : in  STD_LOGIC;
            distance : out STD_LOGIC_VECTOR (7 downto 0);
            en_out : out std_logic;
            clk    : in std_logic 
        );
    end component;

    component Driver is
        Port (
            distance : in  STD_LOGIC_VECTOR (7 downto 0);
            segment_data : out STD_LOGIC_VECTOR (6 downto 0);
            rst : in std_logic;
            LED : out std_logic_vector (8 downto 0)
        );
    end component;

    signal distance_signal : std_logic_vector(7 downto 0);
    signal sig_running : std_logic;
    signal clk_mod_signal : std_logic;

begin

    clock_instance : clk_gen
    port map(
    clk => CLK100MHZ,
    clk_mod => clk_mod_signal);

    trigger_instance: Trigger 
    generic map (
            N_PERIODS => 2
        )
    port map (
        clk => clk_mod_signal,
        rst => BTNC,
        trigger => trigger_out,
        en_in => sig_running 
    );

    distance_instance: DistanceCalculation port map (
        echo => echo_in,
        distance => distance_signal,
        en_out => sig_running,
        clk => clk_mod_signal
    );

    driver_instance: Driver port map (
        distance => distance_signal,
        rst => BTNC,
        segment_data(6) => CA,
        segment_data(5) => CB,
        segment_data(4) => CC,
        segment_data(3) => CD,
        segment_data(2) => CE,
        segment_data(1) => CF,
        segment_data(0) => CG,
        
        LED => LED                 
        );

 
    
    AN <= b"1111_1110";
    DP <= '1';
end Behavioral;
