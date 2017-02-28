onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ahf_mRISC521_brd_tb/Reset_tb
add wave -noupdate /ahf_mRISC521_brd_tb/Clk_tb
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/SW_in_tb
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/Disp_out_tb
add wave -noupdate /ahf_mRISC521_brd_tb/i
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/master/PgCnt
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/master/IR3
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/master/IR2
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/master/IR1
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[12]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[6]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[5]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[4]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[3]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[2]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[1]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/master/R[0]}
add wave -noupdate /ahf_mRISC521_brd_tb/dut/master/Read
add wave -noupdate /ahf_mRISC521_brd_tb/dut/master/Write
add wave -noupdate /ahf_mRISC521_brd_tb/dut/master/holdReg
add wave -noupdate /ahf_mRISC521_brd_tb/dut/master/holdEff
add wave -noupdate -radix hexadecimal -childformat {{{/ahf_mRISC521_brd_tb/dut/master/Data_in_sep[2]} -radix hexadecimal} {{/ahf_mRISC521_brd_tb/dut/master/Data_in_sep[1]} -radix hexadecimal} {{/ahf_mRISC521_brd_tb/dut/master/Data_in_sep[0]} -radix hexadecimal}} -expand -subitemconfig {{/ahf_mRISC521_brd_tb/dut/master/Data_in_sep[2]} {-height 15 -radix hexadecimal} {/ahf_mRISC521_brd_tb/dut/master/Data_in_sep[1]} {-height 15 -radix hexadecimal} {/ahf_mRISC521_brd_tb/dut/master/Data_in_sep[0]} {-height 15 -radix hexadecimal}} /ahf_mRISC521_brd_tb/dut/master/Data_in_sep
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/master/Data_in
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/slave0/R[6]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/slave0/R[5]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/slave0/R[4]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/slave0/R[3]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/slave0/R[2]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/slave0/R[1]}
add wave -noupdate -radix hexadecimal {/ahf_mRISC521_brd_tb/dut/slave0/R[0]}
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/slave0/Data_in
add wave -noupdate /ahf_mRISC521_brd_tb/dut/slave0/Data_out
add wave -noupdate /ahf_mRISC521_brd_tb/dut/slave0/Done_out
add wave -noupdate /ahf_mRISC521_brd_tb/dut/slave0/Read
add wave -noupdate /ahf_mRISC521_brd_tb/dut/slave0/Write
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/slave0/IR3
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/slave0/IR2
add wave -noupdate -radix hexadecimal /ahf_mRISC521_brd_tb/dut/slave0/IR1
add wave -noupdate /ahf_mRISC521_brd_tb/dut/slave0/datastall
add wave -noupdate /ahf_mRISC521_brd_tb/dut/slave0/PgCnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1209354652 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1200700884 ps} {1213136298 ps}
