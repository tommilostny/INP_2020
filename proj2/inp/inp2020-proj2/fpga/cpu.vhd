-- cpu.vhd: Simple 8-bit CPU (BrainF*ck interpreter)
-- Copyright (C) 2020 Brno University of Technology,
--                    Faculty of Information Technology
-- Author(s): Tomáš Milostný
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity cpu is
 port (
   CLK   : in std_logic;  -- hodinovy signal
   RESET : in std_logic;  -- asynchronni reset procesoru
   EN    : in std_logic;  -- povoleni cinnosti procesoru
 
   -- synchronni pamet ROM
   CODE_ADDR : out std_logic_vector(11 downto 0); -- adresa do pameti
   CODE_DATA : in std_logic_vector(7 downto 0);   -- CODE_DATA <- rom[CODE_ADDR] pokud CODE_EN='1'
   CODE_EN   : out std_logic;                     -- povoleni cinnosti
   
   -- synchronni pamet RAM
   DATA_ADDR  : out std_logic_vector(9 downto 0); -- adresa do pameti
   DATA_WDATA : out std_logic_vector(7 downto 0); -- ram[DATA_ADDR] <- DATA_WDATA pokud DATA_EN='1'
   DATA_RDATA : in std_logic_vector(7 downto 0);  -- DATA_RDATA <- ram[DATA_ADDR] pokud DATA_EN='1'
   DATA_WE    : out std_logic;                    -- cteni (0) / zapis (1)
   DATA_EN    : out std_logic;                    -- povoleni cinnosti 
   
   -- vstupni port
   IN_DATA   : in std_logic_vector(7 downto 0);   -- IN_DATA <- stav klavesnice pokud IN_VLD='1' a IN_REQ='1'
   IN_VLD    : in std_logic;                      -- data platna
   IN_REQ    : out std_logic;                     -- pozadavek na vstup data
   
   -- vystupni port
   OUT_DATA : out  std_logic_vector(7 downto 0);  -- zapisovana data
   OUT_BUSY : in std_logic;                       -- LCD je zaneprazdnen (1), nelze zapisovat
   OUT_WE   : out std_logic                       -- LCD <- OUT_DATA pokud OUT_WE='1' a OUT_BUSY='0'
 );
end cpu;


-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of cpu is
    --PC
    signal pc_register: std_logic_vector(11 downto 0);
    signal pc_inc: std_logic;
    signal pc_dec: std_logic;
    signal pc_ld: std_logic;

    --RAS
    signal ras_register: std_logic_vector(11 downto 0);

    --PTR
    signal ptr_register: std_logic_vector(9 downto 0);
    signal ptr_inc: std_logic;
    signal ptr_dec: std_logic;

    --MX
    signal mx_sel: std_logic_vector(1 downto 0);
    signal mx_out: std_logic_vector(7 downto 0);

    --FSM
    type state_t is 
    (
        START, FETCH, DECODE,
        EXEC_PTR_INC, EXEC_PTR_DEC,
        EXEC_VALUE_INC1, EXEC_VALUE_INC2, EXEC_VALUE_INC3,
        EXEC_VALUE_DEC1, EXEC_VALUE_DEC2, EXEC_VALUE_DEC3,
        EXEC_WHILE_START, EXEC_WHILE_CHECK, EXEC_WHILE_LOOP, EXEC_WHILE_LOOP_EN, EXEC_WHILE_END,
        EXEC_PUTCHAR1, EXEC_PUTCHAR2,
        EXEC_GETCHAR1, EXEC_GETCHAR2,
        EXEC_RETURN
    );
    signal state: state_t := START;
    signal next_state: state_t;
begin

    ---- Program counter ----
    pc : process( CLK, RESET, pc_inc, pc_dec, pc_ld )
    begin
        if ( RESET = '1' ) then
            pc_register <= (others => '0');
        elsif rising_edge(CLK) then
            if ( pc_inc = '1' ) then
                pc_register <= pc_register + 1;
            elsif ( pc_dec = '1' ) then
                pc_register <= pc_register - 1;
            elsif ( pc_ld = '1' ) then
                pc_register <= ras_register;
            end if ;
        end if ;
    end process ; -- pc

    CODE_ADDR <= pc_register;
    ---- End of program counter ----


    ---- Pointer ----
    ptr : process( CLK, RESET, ptr_inc, ptr_dec )
    begin
        if ( RESET = '1' ) then
            ptr_register <= (others => '0');
        elsif rising_edge(CLK) then
            if ( ptr_inc = '1' ) then
                ptr_register <= ptr_register + 1;
            elsif ( ptr_dec = '1' ) then
                ptr_register <= ptr_register - 1;
            end if ;
        end if ;
    end process ; -- ptr

    DATA_ADDR <= ptr_register;
    ---- End of pointer ----


    ---- Multiplexer ----
    mx : process( CLK, RESET, mx_sel )
    begin
        if ( RESET = '1' ) then
            mx_out <= (others => '0');
        elsif rising_edge(CLK) then
            case( mx_sel ) is
            
                when "01" =>
                    mx_out <= DATA_RDATA + 1;

                when "10" =>
                    mx_out <= DATA_RDATA - 1;
            
                when others =>
                    mx_out <= IN_DATA;
            
            end case ;
        end if ;
    end process ; -- mx

    DATA_WDATA <= mx_out;
    ---- End of multiplexer ----


    ---- Finite state machine logic ----
    state_logic : process( CLK, RESET, EN )
    begin
        if ( RESET = '1' ) then
            state <= START;
        elsif ( rising_edge(CLK) and EN = '1' ) then
            state <= next_state;
        end if ;
    end process ; -- state_logic

    fsm_mealy : process( state, CODE_DATA, IN_VLD, OUT_BUSY, DATA_RDATA, pc_register )
    begin
        -- Init FSM outputs
        CODE_EN <= '0';
        IN_REQ <= '0';
        OUT_WE <= '0';
        DATA_WE <= '0';
        DATA_EN <= '0';
        pc_inc <= '0';
        pc_dec <= '0';
        pc_ld <= '0';
        ptr_inc <= '0';
        ptr_dec <= '0';

        case( state ) is
        
            when START =>
                next_state <= FETCH;

            when FETCH =>
                CODE_EN <= '1';
                next_state <= DECODE;

            when DECODE =>
                case( CODE_DATA ) is
                
                    when x"3E" => -- >
                        next_state <= EXEC_PTR_INC;

                    when x"3C" => -- <
                        next_state <= EXEC_PTR_DEC;

                    when x"2B" => -- +
                        next_state <= EXEC_VALUE_INC1;

                    when x"2D" => -- -
                        next_state <= EXEC_VALUE_DEC1;

                    when x"5B" => -- [
                        next_state <= EXEC_WHILE_START;

                    when x"5D" => -- ]
                        next_state <= EXEC_WHILE_END;

                    when x"2E" => -- .
                        next_state <= EXEC_PUTCHAR1;

                    when x"2C" => -- ,
                        next_state <= EXEC_GETCHAR1;

                    when x"00" => -- null
                        next_state <= EXEC_RETURN;

                    when others =>
                        pc_inc <= '1';
                        next_state <= FETCH;
                end case ; -- when DECODE
        
            when EXEC_PTR_INC =>
                ptr_inc <= '1';
                pc_inc <= '1';
                next_state <= FETCH;
            
            when EXEC_PTR_DEC =>
                ptr_dec <= '1';
                pc_inc <= '1';
                next_state <= FETCH;
            
            when EXEC_VALUE_INC1 =>
                DATA_EN <= '1';
                DATA_WE <= '0'; -- read
                next_state <= EXEC_VALUE_INC2;

            when EXEC_VALUE_INC2 =>
                mx_sel <= "01"; -- set MX to increment DATA_RDATA
                next_state <= EXEC_VALUE_INC3;

            when EXEC_VALUE_INC3 =>
                DATA_EN <= '1';
                DATA_WE <= '1'; -- write
                pc_inc <= '1';
                next_state <= FETCH;

            when EXEC_VALUE_DEC1 =>
                DATA_EN <= '1';
                DATA_WE <= '0';
                next_state <= EXEC_VALUE_DEC2;

            when EXEC_VALUE_DEC2 =>
                mx_sel <= "10"; -- set MX to decrement DATA_RDATA
                next_state <= EXEC_VALUE_DEC3;

            when EXEC_VALUE_DEC3 =>
                DATA_EN <= '1';
                DATA_WE <= '1';
                pc_inc <= '1';
                next_state <= FETCH;

            when EXEC_WHILE_START =>
                pc_inc <= '1';
                DATA_EN <= '1';
                DATA_WE <= '0';
                next_state <= EXEC_WHILE_CHECK;

            when EXEC_WHILE_CHECK =>
                if ( DATA_RDATA = "00000000" ) then
                    CODE_EN <= '1';
                    next_state <= EXEC_WHILE_LOOP;
                else
                    ras_register <= pc_register;
                    next_state <= FETCH;
                end if ;

            when EXEC_WHILE_LOOP =>
                if ( CODE_DATA = x"5D") then -- found end ']' ?
                    ras_register <= "000000000000";
                    next_state <= EXEC_WHILE_LOOP_EN;
                else
                    next_state <= FETCH;
                end if ;
                pc_inc <= '1';

            when EXEC_WHILE_LOOP_EN =>
                CODE_EN <= '1';
                next_state <= EXEC_WHILE_LOOP;

            when EXEC_WHILE_END =>
                if ( DATA_RDATA = "00000000" ) then
                    pc_inc <= '1';
                else
                    pc_ld <= '1';
                end if ;
                next_state <= FETCH;
            
            when EXEC_PUTCHAR1 =>
                DATA_EN <= '1';
                DATA_WE <= '0';
                next_state <= EXEC_PUTCHAR2;

            when EXEC_PUTCHAR2 =>
                if ( OUT_BUSY = '1' ) then
                    DATA_EN <= '1';
                    DATA_WE <= '0';
                else
                    OUT_WE <= '1';
                    OUT_DATA <= DATA_RDATA;
                    pc_inc <= '1';
                    next_state <= FETCH;
                end if ;
            
            when EXEC_GETCHAR1 =>
                IN_REQ <= '1';
                mx_sel <= "00"; -- set MX to read
                next_state <= EXEC_GETCHAR2;

            when EXEC_GETCHAR2 =>
                if ( IN_VLD = '1' ) then
                    DATA_EN <= '1';
                    DATA_WE <= '1';
                    pc_inc <= '1';
                    next_state <= FETCH;
                else
                    IN_REQ <= '1';
                    mx_sel <= "00";
                end if ;
            
            when EXEC_RETURN =>
                next_state <= FETCH;

            when others =>
                pc_inc <= '1';
                next_state <= FETCH;
        
        end case ;
    end process ; -- fsm_mealy
    ---- End of finite state machine logic ----
 
end behavioral;
