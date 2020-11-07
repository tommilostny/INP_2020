library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- rozhrani Vigenerovy sifry
entity vigenere is
   port(
         CLK : in std_logic;
         RST : in std_logic;
         DATA : in std_logic_vector(7 downto 0);
         KEY : in std_logic_vector(7 downto 0);

         CODE : out std_logic_vector(7 downto 0)
    );
end vigenere;

architecture behavioral of vigenere is
    --Vigenere
    signal shift: std_logic_vector(7 downto 0);
    signal plus_corrected: std_logic_vector(7 downto 0);
    signal minus_corrected: std_logic_vector(7 downto 0);

    --Mealy FSM
    type state_t is (ADD, SUB);
    signal state: state_t := ADD;
    signal next_state: state_t := SUB;
    signal fsm_mealy_output: std_logic_vector(1 downto 0);

begin
    ---- Vigenere shifting ----
    shift_process: process ( DATA, KEY )
    begin
        shift <= KEY - 64;
    end process; -- shift_process

    plus_process : process( DATA, shift )
        variable temp: std_logic_vector(7 downto 0);
    begin
        temp := DATA + shift;
        if ( temp > 90 ) then
            temp := temp - 26;
        end if;
        plus_corrected <= temp;
    end process; -- plus_process

    minus_process : process( DATA, shift )
        variable temp: std_logic_vector(7 downto 0);
    begin
        temp := DATA - shift;
        if ( temp < 65 ) then
            temp := temp + 26;
        end if;
        minus_corrected <= temp;
    end process; -- minus_process
    ---- End of Vigenere shifting ----


    ---- Mealy finite state machine logic ----
    state_logic : process( CLK, RST )
    begin
        if ( RST = '1' ) then
            state <= ADD;
        elsif rising_edge(CLK) then
            state <= next_state;
        end if;
    end process; -- state_logic

    fsm_mealy : process( state, DATA, RST )
    begin
        case( state ) is
            when ADD =>
                next_state <= SUB;
                fsm_mealy_output <= "01"; --add
        
            when SUB =>
                next_state <= ADD;
                fsm_mealy_output <= "10"; --sub
        end case;

        if ( RST = '1' or ( DATA > 47 and DATA < 58 )) then
            fsm_mealy_output <= "11";
        end if;
    end process; -- fsm_mealy
    ---- End of Mealy finite state machine logic ----


    ---- Multiplexer ----
    mux : process( fsm_mealy_output, plus_corrected, minus_corrected )
    begin
        case( fsm_mealy_output ) is
            when "01" =>
                CODE <= plus_corrected;
            
            when "10" =>
                CODE <= minus_corrected;

            when others =>
                CODE <= "00100011"; -- '#'
        end case;
    end process; -- mux
    ---- End of Multiplexer ----

end behavioral;
