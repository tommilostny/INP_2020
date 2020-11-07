proc isim_script {} {

   add_divider "Signals of the Vigenere Interface"
   add_wave_label "" "CLK" /testbench/clk
   add_wave_label "" "RST" /testbench/rst
   add_wave_label "-radix ascii" "DATA" /testbench/tb_data
   add_wave_label "-radix ascii" "KEY" /testbench/tb_key
   add_wave_label "-radix ascii" "CODE" /testbench/tb_code

   add_divider "Vigenere Inner Signals"
   # sem doplnte vase vnitrni signaly. chcete-li v diagramu zobrazit desitkove
   # cislo, vlozte do prvnich uvozovek: -radix dec

   add_wave_label "-radix unsigned" "SHIFT" /testbench/uut/shift
   add_wave_label "-radix ascii" "PLUS" /testbench/uut/plus_corrected
   add_wave_label "-radix ascii" "MINUS" /testbench/uut/minus_corrected

   add_wave_label "" "STATE" /testbench/uut/state
   add_wave_label "" "NEXT_STATE" /testbench/uut/next_state
   add_wave_label "" "FSM_MEALY_OUTPUT" /testbench/uut/fsm_mealy_output

   run 8 ns
}
