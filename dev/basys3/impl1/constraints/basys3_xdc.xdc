set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk100]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk100]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk100]
	
# LEDs
set_property PACKAGE_PIN U16 [get_ports {config_done}]     
    set_property IOSTANDARD LVCMOS33 [get_ports {config_done}] 
    
# Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]      
 
#Buttons
set_property PACKAGE_PIN T18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN U18 [get_ports btnc]      
 set_property IOSTANDARD LVCMOS33 [get_ports btnc]
set_property PACKAGE_PIN W19 [get_ports btnl]                        
     set_property IOSTANDARD LVCMOS33 [get_ports btnl]
#set_property PACKAGE_PIN T17 [get_ports btnr]      
 #        set_property IOSTANDARD LVCMOS33 [get_ports btnr]



##VGA Connector
set_property PACKAGE_PIN G19 [get_ports {red[0]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {red[0]}]
set_property PACKAGE_PIN H19 [get_ports {red[1]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {red[1]}]
set_property PACKAGE_PIN J19 [get_ports {red[2]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {red[2]}]
set_property PACKAGE_PIN N19 [get_ports {red[3]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {red[3]}]
set_property PACKAGE_PIN N18 [get_ports {blue[0]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {blue[0]}]
set_property PACKAGE_PIN L18 [get_ports {blue[1]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {blue[1]}]
set_property PACKAGE_PIN K18 [get_ports {blue[2]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {blue[2]}]
set_property PACKAGE_PIN J18 [get_ports {blue[3]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {blue[3]}]
set_property PACKAGE_PIN J17 [get_ports {green[0]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {green[0]}]
set_property PACKAGE_PIN H17 [get_ports {green[1]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {green[1]}]
set_property PACKAGE_PIN G17 [get_ports {green[2]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {green[2]}]
set_property PACKAGE_PIN D17 [get_ports {green[3]}]                
    set_property IOSTANDARD LVCMOS33 [get_ports {green[3]}]
set_property PACKAGE_PIN P19 [get_ports h_sync]                        
    set_property IOSTANDARD LVCMOS33 [get_ports h_sync]
set_property PACKAGE_PIN R19 [get_ports v_sync]                        
    set_property IOSTANDARD LVCMOS33 [get_ports v_sync]
	
#Pmod Header JB
#Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {ov7670_sioc}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_sioc}]
#Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {ov7670_vsync}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_vsync}]
#Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {ov7670_pclk}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_pclk}]
	set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {ov7670_pclk_IBUF}]	
#Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {ov7670_data[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[7]}]
#Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {ov7670_siod}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_siod}]
#Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {ov7670_href}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_href}]
#Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {ov7670_xclk}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_xclk}]
#Sch name = JB10 
set_property PACKAGE_PIN C16 [get_ports {ov7670_data[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[6]}]
  

#Pmod Header JC
#Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {ov7670_data[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[5]}]
#Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {ov7670_data[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[3]}]
#Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {ov7670_data[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[1]}]
#Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {ov7670_reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_reset}]
#Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {ov7670_data[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[4]}]
#Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {ov7670_data[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[2]}]
#Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {ov7670_data[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_data[0]}]
#Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {ov7670_pwdn}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {ov7670_pwdn}]
