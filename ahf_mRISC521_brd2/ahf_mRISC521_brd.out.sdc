## Generated SDC file "ahf_mRISC521_brd.out.sdc"

## Copyright (C) 2016  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel MegaCore Function License Agreement, or other 
## applicable license agreement, including, without limitation, 
## that your use is for the sole purpose of programming logic 
## devices manufactured by Intel and sold by Intel or its 
## authorized distributors.  Please refer to the applicable 
## agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition"

## DATE    "Sat Dec 10 19:35:01 2016"

##
## DEVICE  "EP4CE22F17C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLOCK_50}]
create_clock -name {ahf4722_RISC521_slave:slave0|ahf_cram_v:my_cram|cam_addrs[0]} -period 10.000 -waveform { 0.000 5.000 } 


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {b2v_inst|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {b2v_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 10 -master_clock {CLOCK_50} [get_pins {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {b2v_inst|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {b2v_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 10 -phase 30.000 -master_clock {CLOCK_50} [get_pins {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {b2v_inst|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {b2v_inst|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 1 -divide_by 10 -phase 60.000 -master_clock {CLOCK_50} [get_pins {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[2]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {b2v_inst|altpll_component|auto_generated|pll1|clk[0]}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

