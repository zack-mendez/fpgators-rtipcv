------------------------------------------------------------------------
-- Company       : FPGAtors
-- Engineer      : Zack Mendez
-- Create Date   : 3/31/2025
-- Module Name   : ov7670_addr_pkg
-- Project Name  : RTIPCV
-- Target Device : OV7670 Camera Module
-- Tool Versions : Vivado 2024.1
-- Description   : This package defines address constants for the OV7670
--               : camera's configuration registers. These constants are
--               : used to construct control words for SCCB/I2C register
--               : writes in the camera initialization routine.
--
-- Revision      : v1.0
-- Revision Date : 3/31/2025
-- Author        : Zack Mendez
-- Comments      : Initial release. Covers addresses 0x00–0xC9, including
--                 reserved fields and defined registers as per the datasheet.
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
package ov7670_addr_pkg is

  constant OV7670_I2C_WRITE_ADDR : std_logic_vector(7 downto 0) := x"42";
  constant OV7670_I2C_READ_ADDR  : std_logic_vector(7 downto 0) := x"43"; 

  constant GAIN_addr               : std_logic_vector(7 downto 0) := x"00";
  constant BLUE_addr               : std_logic_vector(7 downto 0) := x"01";
  constant RED_addr                : std_logic_vector(7 downto 0) := x"02";
  constant VREF_addr               : std_logic_vector(7 downto 0) := x"03";
  constant COM1_addr               : std_logic_vector(7 downto 0) := x"04";
  constant BAVE_addr               : std_logic_vector(7 downto 0) := x"05";
  constant GbAVE_addr              : std_logic_vector(7 downto 0) := x"06";
  constant AECHH_addr              : std_logic_vector(7 downto 0) := x"07";
  constant RAVE_addr               : std_logic_vector(7 downto 0) := x"08";
  constant COM2_addr               : std_logic_vector(7 downto 0) := x"09";
  constant PID_addr                : std_logic_vector(7 downto 0) := x"0A";
  constant VER_addr                : std_logic_vector(7 downto 0) := x"0B";
  constant COM3_addr               : std_logic_vector(7 downto 0) := x"0C";
  constant COM4_addr               : std_logic_vector(7 downto 0) := x"0D";
  constant COM5_addr               : std_logic_vector(7 downto 0) := x"0E";
  constant COM6_addr               : std_logic_vector(7 downto 0) := x"0F";
  constant AECH_addr               : std_logic_vector(7 downto 0) := x"10";
  constant CLKRC_addr              : std_logic_vector(7 downto 0) := x"11";
  constant COM7_addr               : std_logic_vector(7 downto 0) := x"12";
  constant COM8_addr               : std_logic_vector(7 downto 0) := x"13";
  constant COM9_addr               : std_logic_vector(7 downto 0) := x"14";
  constant COM10_addr              : std_logic_vector(7 downto 0) := x"15";
  constant RSVD_0_addr             : std_logic_vector(7 downto 0) := x"16";
  constant HSTART_addr             : std_logic_vector(7 downto 0) := x"17";
  constant HSTOP_addr              : std_logic_vector(7 downto 0) := x"18";
  constant VSTRT_addr              : std_logic_vector(7 downto 0) := x"19";
  constant VSTOP_addr              : std_logic_vector(7 downto 0) := x"1A";
  constant PSHFT_addr              : std_logic_vector(7 downto 0) := x"1B";
  constant MIDH_addr               : std_logic_vector(7 downto 0) := x"1C";
  constant MIDL_addr               : std_logic_vector(7 downto 0) := x"1D";
  constant MVFP_addr               : std_logic_vector(7 downto 0) := x"1E";
  constant LAEC_addr               : std_logic_vector(7 downto 0) := x"1F";
  constant ADCCTR0_addr            : std_logic_vector(7 downto 0) := x"20";
  constant ADCCTR1_addr            : std_logic_vector(7 downto 0) := x"21";
  constant ADCCTR2_addr            : std_logic_vector(7 downto 0) := x"22";
  constant ADCCTR3_addr            : std_logic_vector(7 downto 0) := x"23";
  constant AEW_addr                : std_logic_vector(7 downto 0) := x"24";
  constant AEB_addr                : std_logic_vector(7 downto 0) := x"25";
  constant VPT_addr                : std_logic_vector(7 downto 0) := x"26";
  constant BBIAS_addr              : std_logic_vector(7 downto 0) := x"27";
  constant GbBIAS_addr             : std_logic_vector(7 downto 0) := x"28";
  constant RSVD_1_addr             : std_logic_vector(7 downto 0) := x"29";
  constant EXHCH_addr              : std_logic_vector(7 downto 0) := x"2A";
  constant EXHCL_addr              : std_logic_vector(7 downto 0) := x"2B";
  constant RBIAS_addr              : std_logic_vector(7 downto 0) := x"2C";
  constant ADVFL_addr              : std_logic_vector(7 downto 0) := x"2D";
  constant ADVFH_addr              : std_logic_vector(7 downto 0) := x"2E";
  constant YAVE_addr               : std_logic_vector(7 downto 0) := x"2F";
  constant HSYST_addr              : std_logic_vector(7 downto 0) := x"30";
  constant HSYEN_addr              : std_logic_vector(7 downto 0) := x"31";
  constant HREF_addr               : std_logic_vector(7 downto 0) := x"32";
  constant CHLF_addr               : std_logic_vector(7 downto 0) := x"33";
  constant ARBLM_addr              : std_logic_vector(7 downto 0) := x"34";
  constant RSVD_2_addr             : std_logic_vector(7 downto 0) := x"35";
  constant RSVD_3_addr             : std_logic_vector(7 downto 0) := x"36";
  constant ADC_addr                : std_logic_vector(7 downto 0) := x"37";
  constant ACOM_addr               : std_logic_vector(7 downto 0) := x"38";
  constant OFON_addr               : std_logic_vector(7 downto 0) := x"39";
  constant TSLB_addr               : std_logic_vector(7 downto 0) := x"3A";
  constant COM11_addr              : std_logic_vector(7 downto 0) := x"3B";
  constant COM12_addr              : std_logic_vector(7 downto 0) := x"3C";
  constant COM13_addr              : std_logic_vector(7 downto 0) := x"3D";
  constant COM14_addr              : std_logic_vector(7 downto 0) := x"3E";
  constant EDGE_addr               : std_logic_vector(7 downto 0) := x"3F";
  constant COM15_addr              : std_logic_vector(7 downto 0) := x"40";
  constant COM16_addr              : std_logic_vector(7 downto 0) := x"41";
  constant COM17_addr              : std_logic_vector(7 downto 0) := x"42";
  constant AWBC1_addr              : std_logic_vector(7 downto 0) := x"43";
  constant AWBC2_addr              : std_logic_vector(7 downto 0) := x"44";
  constant AWBC3_addr              : std_logic_vector(7 downto 0) := x"45";
  constant AWBC4_addr              : std_logic_vector(7 downto 0) := x"46";
  constant AWBC5_addr              : std_logic_vector(7 downto 0) := x"47";
  constant AWBC6_addr              : std_logic_vector(7 downto 0) := x"48";
  constant RSVD_4_addr             : std_logic_vector(7 downto 0) := x"49";
  constant RSVD_5_addr             : std_logic_vector(7 downto 0) := x"4A";
  constant REG4B_addr              : std_logic_vector(7 downto 0) := x"4B";
  constant DNSTH_addr              : std_logic_vector(7 downto 0) := x"4C";
  constant RSVD_6_addr             : std_logic_vector(7 downto 0) := x"4D";
  constant RSVD_7_addr             : std_logic_vector(7 downto 0) := x"4E";
  constant MTX1_addr               : std_logic_vector(7 downto 0) := x"4F";
  constant MTX2_addr               : std_logic_vector(7 downto 0) := x"50";
  constant MTX3_addr               : std_logic_vector(7 downto 0) := x"51";
  constant MTX4_addr               : std_logic_vector(7 downto 0) := x"52";
  constant MTX5_addr               : std_logic_vector(7 downto 0) := x"53";
  constant MTX6_addr               : std_logic_vector(7 downto 0) := x"54";
  constant BRIGHT_addr             : std_logic_vector(7 downto 0) := x"55";
  constant CONTRAS_addr            : std_logic_vector(7 downto 0) := x"56";
  constant CONTRAS_CTR_addr        : std_logic_vector(7 downto 0) := x"57";
  constant MTXS_addr               : std_logic_vector(7 downto 0) := x"58";
  constant RSVD_8_addr             : std_logic_vector(7 downto 0) := x"59";
  constant RSVD_9_addr             : std_logic_vector(7 downto 0) := x"5A";
  constant RSVD_10_addr            : std_logic_vector(7 downto 0) := x"5B";
  constant RSVD_11_addr            : std_logic_vector(7 downto 0) := x"5C";
  constant RSVD_12_addr            : std_logic_vector(7 downto 0) := x"5D";
  constant RSVD_13_addr            : std_logic_vector(7 downto 0) := x"5E";
  constant RSVD_14_addr            : std_logic_vector(7 downto 0) := x"5F";
  constant RSVD_15_addr            : std_logic_vector(7 downto 0) := x"60";
  constant RSVD_16_addr            : std_logic_vector(7 downto 0) := x"61";
  constant LCC1_addr               : std_logic_vector(7 downto 0) := x"62";
  constant LCC2_addr               : std_logic_vector(7 downto 0) := x"63";
  constant LCC3_addr               : std_logic_vector(7 downto 0) := x"64";
  constant LCC4_addr               : std_logic_vector(7 downto 0) := x"65";
  constant LCC5_addr               : std_logic_vector(7 downto 0) := x"66";
  constant MANU_addr               : std_logic_vector(7 downto 0) := x"67";
  constant MANV_addr               : std_logic_vector(7 downto 0) := x"68";
  constant GFIX_addr               : std_logic_vector(7 downto 0) := x"69";
  constant GGAIN_addr              : std_logic_vector(7 downto 0) := x"6A";
  constant DBLV_addr               : std_logic_vector(7 downto 0) := x"6B";
  constant AWBCTR3_addr            : std_logic_vector(7 downto 0) := x"6C";
  constant AWBCTR2_addr            : std_logic_vector(7 downto 0) := x"6D";
  constant AWBCTR1_addr            : std_logic_vector(7 downto 0) := x"6E";
  constant AWBCTR0_addr            : std_logic_vector(7 downto 0) := x"6F";
  constant SCALING_XSC_addr        : std_logic_vector(7 downto 0) := x"70";
  constant SCALING_YSC_addr        : std_logic_vector(7 downto 0) := x"71";
  constant SCALING_DCWCTR_addr     : std_logic_vector(7 downto 0) := x"72";
  constant SCALING_PCLK_DIV_addr   : std_logic_vector(7 downto 0) := x"73";
  constant REG74_addr              : std_logic_vector(7 downto 0) := x"74";
  constant REG75_addr              : std_logic_vector(7 downto 0) := x"75";
  constant REG76_addr              : std_logic_vector(7 downto 0) := x"76";
  constant REG77_addr              : std_logic_vector(7 downto 0) := x"77";
  constant RSVD_17_addr            : std_logic_vector(7 downto 0) := x"78";
  constant RSVD_18_addr            : std_logic_vector(7 downto 0) := x"79";
  constant SLOP_addr               : std_logic_vector(7 downto 0) := x"7A";
  constant GAM1_addr               : std_logic_vector(7 downto 0) := x"7B";
  constant GAM2_addr               : std_logic_vector(7 downto 0) := x"7C";
  constant GAM3_addr               : std_logic_vector(7 downto 0) := x"7D";
  constant GAM4_addr               : std_logic_vector(7 downto 0) := x"7E";
  constant GAM5_addr               : std_logic_vector(7 downto 0) := x"7F";
  constant GAM6_addr               : std_logic_vector(7 downto 0) := x"80";
  constant GAM7_addr               : std_logic_vector(7 downto 0) := x"81";
  constant GAM8_addr               : std_logic_vector(7 downto 0) := x"82";
  constant GAM9_addr               : std_logic_vector(7 downto 0) := x"83";
  constant GAM10_addr              : std_logic_vector(7 downto 0) := x"84";
  constant GAM11_addr              : std_logic_vector(7 downto 0) := x"85";
  constant GAM12_addr              : std_logic_vector(7 downto 0) := x"86";
  constant GAM13_addr              : std_logic_vector(7 downto 0) := x"87";
  constant GAM14_addr              : std_logic_vector(7 downto 0) := x"88";
  constant GAM15_addr              : std_logic_vector(7 downto 0) := x"89";
  constant RSVD_19_addr            : std_logic_vector(7 downto 0) := x"8A";
  constant RSVD_20_addr            : std_logic_vector(7 downto 0) := x"8B";
  constant RGB444_addr             : std_logic_vector(7 downto 0) := x"8C";
  constant DM_LNL_addr             : std_logic_vector(7 downto 0) := x"92";
  constant DM_LNH_addr             : std_logic_vector(7 downto 0) := x"93";
  constant LCC6_addr               : std_logic_vector(7 downto 0) := x"94";
  constant LCC7_addr               : std_logic_vector(7 downto 0) := x"95";
  constant RSVD_21_addr            : std_logic_vector(7 downto 0) := x"96";
  constant RSVD_22_addr            : std_logic_vector(7 downto 0) := x"97";
  constant RSVD_23_addr            : std_logic_vector(7 downto 0) := x"98";
  constant RSVD_24_addr            : std_logic_vector(7 downto 0) := x"99";
  constant RSVD_25_addr            : std_logic_vector(7 downto 0) := x"9A";
  constant RSVD_26_addr            : std_logic_vector(7 downto 0) := x"9B";
  constant RSVD_27_addr            : std_logic_vector(7 downto 0) := x"9C";
  constant BD50ST_addr             : std_logic_vector(7 downto 0) := x"9D";
  constant BD60ST_addr             : std_logic_vector(7 downto 0) := x"9E";
  constant HAECC1_addr             : std_logic_vector(7 downto 0) := x"9F";
  constant HAECC2_addr             : std_logic_vector(7 downto 0) := x"A0";
  constant RSVD_28_addr            : std_logic_vector(7 downto 0) := x"A1";
  constant SCALING_PCLK_DELAY_addr : std_logic_vector(7 downto 0) := x"A2";
  constant NT_CTRL_addr            : std_logic_vector(7 downto 0) := x"A4";
  constant BD50MAX_addr            : std_logic_vector(7 downto 0) := x"A5";
  constant HAECC3_addr             : std_logic_vector(7 downto 0) := x"A6";
  constant HAECC4_addr             : std_logic_vector(7 downto 0) := x"A7";
  constant HAECC5_addr             : std_logic_vector(7 downto 0) := x"A8";
  constant HAECC6_addr             : std_logic_vector(7 downto 0) := x"A9";
  constant HAECC7_addr             : std_logic_vector(7 downto 0) := x"AA";
  constant BD60MAX_addr            : std_logic_vector(7 downto 0) := x"AB";
  constant STR_OPT_addr            : std_logic_vector(7 downto 0) := x"AC";
  constant STR_R_addr              : std_logic_vector(7 downto 0) := x"AD";
  constant STR_G_addr              : std_logic_vector(7 downto 0) := x"AE";
  constant STR_B_addr              : std_logic_vector(7 downto 0) := x"AF";
  constant RSVD_29_addr            : std_logic_vector(7 downto 0) := x"B0";
  constant ABLC1_addr              : std_logic_vector(7 downto 0) := x"B1";
  constant RSVD_30_addr            : std_logic_vector(7 downto 0) := x"B2";
  constant THL_ST_addr             : std_logic_vector(7 downto 0) := x"B3";
  constant THL_DLT_addr            : std_logic_vector(7 downto 0) := x"B5";
  constant RSVD_31_addr            : std_logic_vector(7 downto 0) := x"B6";
  constant RSVD_32_addr            : std_logic_vector(7 downto 0) := x"B7";
  constant RSVD_33_addr            : std_logic_vector(7 downto 0) := x"B8";
  constant RSVD_34_addr            : std_logic_vector(7 downto 0) := x"B9";
  constant RSVD_35_addr            : std_logic_vector(7 downto 0) := x"BA";
  constant RSVD_36_addr            : std_logic_vector(7 downto 0) := x"BB";
  constant RSVD_37_addr            : std_logic_vector(7 downto 0) := x"BC";
  constant RSVD_38_addr            : std_logic_vector(7 downto 0) := x"BD";
  constant AD_CHB_addr             : std_logic_vector(7 downto 0) := x"BE";
  constant AD_CHR_addr             : std_logic_vector(7 downto 0) := x"BF";
  constant AD_CHGb_addr            : std_logic_vector(7 downto 0) := x"C0";
  constant AD_CHGr_addr            : std_logic_vector(7 downto 0) := x"C1";
  constant RSVD_39_addr            : std_logic_vector(7 downto 0) := x"C2";
  constant RSVD_40_addr            : std_logic_vector(7 downto 0) := x"C3";
  constant RSVD_41_addr            : std_logic_vector(7 downto 0) := x"C4";
  constant RSVD_42_addr            : std_logic_vector(7 downto 0) := x"C5";
  constant RSVD_43_addr            : std_logic_vector(7 downto 0) := x"C6";
  constant RSVD_44_addr            : std_logic_vector(7 downto 0) := x"C7";
  constant RSVD_45_addr            : std_logic_vector(7 downto 0) := x"C8";
  constant SATCTR_addr             : std_logic_vector(7 downto 0) := x"C9";

end ov7670_addr_pkg;