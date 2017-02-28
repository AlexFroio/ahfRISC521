transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_mRISC521_brd.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_RISC521_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_crom_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_cram_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_8to3_enc.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_2to1Mux_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_CAM_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_RISC521_slave.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_mainpll.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_rom1.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_cache_v.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_ram1.v}
vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/db {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/db/ahf_mainpll_altpll.v}

vlog -vlog01compat -work work +incdir+C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2 {C:/Users/alexa_000/Documents/ahfRISC521/ahf_mRISC521_brd2/ahf_mRISC521_brd_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  ahf_mRISC521_brd_tb

add wave *
view structure
view signals
run -all
