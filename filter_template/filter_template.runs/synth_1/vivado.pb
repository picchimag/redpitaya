
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:042

00:00:072	
507.6842	
200.113Z17-268h px� 
>
Refreshing IP repositories
234*coregenZ19-234h px� 
�
�Failed to load user IP repository '%s'; %s
If this directory should no longer be in your list of user repositories, go to the IP Settings dialog and remove it.
1318*coregen2A
?c:/Users/magrini/Documents/programming/redpitaya/template/cores2 
Can't find the specified path.Z19-2248h px� 
j
"Loaded Vivado IP repository '%s'.
1332*coregen2!
C:/Xilinx/Vivado/2024.1/data/ipZ19-2313h px� 
�
�The host OS only allows 260 characters in a normal path. The IP cache path is more than 80 characters. If you experience issues with IP caching, please consider changing the IP cache to a location with a shorter path. Alternately consider using the OS subst command to map part of the path to a drive letter. 
Current IP cache path is %s 2293*coregen2[
Yc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.cache/ipZ19-4995h px� 
�
Command: %s
53*	vivadotcl2�
�synth_design -top system_wrapper -part xc7z010clg400-1 -directive PerformanceOptimized -fsm_extraction one_hot -keep_equivalent_registers -resource_sharing off -no_lc -shreg_min_size 5Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
z
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7z010Z17-347h px� 
j
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7z010Z17-349h px� 
D
Loading part %s157*device2
xc7z010clg400-1Z21-403h px� 
Z
$Part: %s does not have CEAM library.966*device2
xc7z010clg400-1Z21-9227h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
19436Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:08 . Memory (MB): peak = 1391.785 ; gain = 447.043
h px� 
�
synthesizing module '%s'%s4497*oasys2
system_wrapper2
 2�
}C:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/hdl/system_wrapper.v2
138@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
37428@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
adc_imp_ZPM6712
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
138@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_adc_0_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_adc_0_0/synth/system_adc_0_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
axis_red_pitaya_adc2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/6dd9/56ac/axis_red_pitaya_adc.v2
48@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
axis_red_pitaya_adc2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/6dd9/56ac/axis_red_pitaya_adc.v2
48@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_adc_0_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_adc_0_0/synth/system_adc_0_0.v2
538@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
system_xlslice_0_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlslice_0_0/synth/system_xlslice_0_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
xlslice_v1_0_4_xlslice2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v2
588@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
xlslice_v1_0_4_xlslice2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v2
588@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_xlslice_0_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlslice_0_0/synth/system_xlslice_0_0.v2
538@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
system_xlslice_1_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlslice_1_0/synth/system_xlslice_1_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2(
&xlslice_v1_0_4_xlslice__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v2
588@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2(
&xlslice_v1_0_4_xlslice__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v2
588@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_xlslice_1_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlslice_1_0/synth/system_xlslice_1_0.v2
538@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
adc_imp_ZPM6712
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
138@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
dac_imp_10A61H22
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
608@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_dac_0_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_dac_0_0/synth/system_dac_0_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
axis_red_pitaya_dac2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/67aa/56ac/axis_red_pitaya_dac.v2
48@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
ODDR2
 29
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1001028@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ODDR2
 2
02
129
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1001028@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
axis_red_pitaya_dac2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/67aa/56ac/axis_red_pitaya_dac.v2
48@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_dac_0_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_dac_0_0/synth/system_dac_0_0.v2
538@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
s_axis_tready2
system_dac_0_02
dac_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
1128@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
dac_02
system_dac_0_02
122
112{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
1128@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2
system_xlconcat_0_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlconcat_0_0/synth/system_xlconcat_0_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
xlconcat_v2_1_6_xlconcat2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/6120/hdl/xlconcat_v2_1_vl_rfs.v2
598@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
xlconcat_v2_1_6_xlconcat2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/6120/hdl/xlconcat_v2_1_vl_rfs.v2
598@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_xlconcat_0_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlconcat_0_0/synth/system_xlconcat_0_0.v2
538@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dac_imp_10A61H22
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
608@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
iir2nd_imp_ETYQWW2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
1308@Z8-6157h px� 
�
synthesizing module '%s'638*oasys2
system_axi_gpio_0_02�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/synth/system_axi_gpio_0_0.vhd2
898@Z8-638h px� 
M
%s
*synth25
3	Parameter C_FAMILY bound to: zynq - type: string 
h p
x
� 
U
%s
*synth2=
;	Parameter C_S_AXI_ADDR_WIDTH bound to: 9 - type: integer 
h p
x
� 
V
%s
*synth2>
<	Parameter C_S_AXI_DATA_WIDTH bound to: 32 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter C_GPIO_WIDTH bound to: 32 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter C_GPIO2_WIDTH bound to: 32 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter C_ALL_INPUTS bound to: 0 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter C_ALL_INPUTS_2 bound to: 0 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter C_ALL_OUTPUTS bound to: 0 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter C_ALL_OUTPUTS_2 bound to: 0 - type: integer 
h p
x
� 
V
%s
*synth2>
<	Parameter C_INTERRUPT_PRESENT bound to: 0 - type: integer 
h p
x
� 
d
%s
*synth2L
J	Parameter C_DOUT_DEFAULT bound to: 32'b00000000000000000000000000000000 
h p
x
� 
c
%s
*synth2K
I	Parameter C_TRI_DEFAULT bound to: 32'b11111111111111111111111111111111 
h p
x
� 
L
%s
*synth24
2	Parameter C_IS_DUAL bound to: 1 - type: integer 
h p
x
� 
f
%s
*synth2N
L	Parameter C_DOUT_DEFAULT_2 bound to: 32'b00000000000000000000000000000000 
h p
x
� 
e
%s
*synth2M
K	Parameter C_TRI_DEFAULT_2 bound to: 32'b11111111111111111111111111111111 
h p
x
� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2

axi_gpio2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
12702
U02

axi_gpio2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/synth/system_axi_gpio_0_0.vhd2
1798@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2

axi_gpio2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
13568@Z8-638h px� 
�
synthesizing module '%s'638*oasys2
axi_lite_ipif2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
29488@Z8-638h px� 
�
synthesizing module '%s'638*oasys2
slave_attachment2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
23418@Z8-638h px� 
�
synthesizing module '%s'638*oasys2
address_decoder2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
17758@Z8-638h px� 
�
synthesizing module '%s'638*oasys2
	pselect_f2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	pselect_f2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
pselect_f__parameterized02�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
pselect_f__parameterized02
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
pselect_f__parameterized12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
pselect_f__parameterized12
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
pselect_f__parameterized22�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
pselect_f__parameterized22
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
15348@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
address_decoder2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
17758@Z8-256h px� 
�
default block is never used226*oasys2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
25508@Z8-226h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
slave_attachment2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
23418@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
axi_lite_ipif2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd2
29488@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
	GPIO_Core2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
1818@Z8-638h px� 
�
default block is never used226*oasys2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
8388@Z8-226h px� 
�
synthesizing module '%s'638*oasys2

cdc_sync2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
1068@Z8-638h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2#
!CROSS2_PLEVEL_IN2SCNDRY_IN_cdc_to2
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7368@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d22
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7728@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d32
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
7888@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d42
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
8048@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d42
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
8048@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d42
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
8048@Z8-113h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
,binding component instance '%s' to cell '%s'113*oasys2,
*CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d42
FDR2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
8048@Z8-113h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-1132
100Z17-14h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

cdc_sync2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
1068@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
	GPIO_Core2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
1818@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

axi_gpio2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
13568@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
system_axi_gpio_0_02
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/synth/system_axi_gpio_0_0.vhd2
898@Z8-256h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
	gpio_io_t2
system_axi_gpio_0_02

axi_gpio_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
3648@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2

gpio2_io_t2
system_axi_gpio_0_02

axi_gpio_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
3648@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2

axi_gpio_02
system_axi_gpio_0_02
252
232{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
3648@Z8-7023h px� 
�
synthesizing module '%s'638*oasys2
system_axi_gpio_0_12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/synth/system_axi_gpio_0_1.vhd2
898@Z8-638h px� 
M
%s
*synth25
3	Parameter C_FAMILY bound to: zynq - type: string 
h p
x
� 
U
%s
*synth2=
;	Parameter C_S_AXI_ADDR_WIDTH bound to: 9 - type: integer 
h p
x
� 
V
%s
*synth2>
<	Parameter C_S_AXI_DATA_WIDTH bound to: 32 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter C_GPIO_WIDTH bound to: 32 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter C_GPIO2_WIDTH bound to: 32 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter C_ALL_INPUTS bound to: 0 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter C_ALL_INPUTS_2 bound to: 0 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter C_ALL_OUTPUTS bound to: 0 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter C_ALL_OUTPUTS_2 bound to: 0 - type: integer 
h p
x
� 
V
%s
*synth2>
<	Parameter C_INTERRUPT_PRESENT bound to: 0 - type: integer 
h p
x
� 
d
%s
*synth2L
J	Parameter C_DOUT_DEFAULT bound to: 32'b00000000000000000000000000000000 
h p
x
� 
c
%s
*synth2K
I	Parameter C_TRI_DEFAULT bound to: 32'b11111111111111111111111111111111 
h p
x
� 
L
%s
*synth24
2	Parameter C_IS_DUAL bound to: 1 - type: integer 
h p
x
� 
f
%s
*synth2N
L	Parameter C_DOUT_DEFAULT_2 bound to: 32'b00000000000000000000000000000000 
h p
x
� 
e
%s
*synth2M
K	Parameter C_TRI_DEFAULT_2 bound to: 32'b11111111111111111111111111111111 
h p
x
� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2

axi_gpio2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
12702
U02

axi_gpio2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/synth/system_axi_gpio_0_1.vhd2
1798@Z8-3491h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
system_axi_gpio_0_12
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/synth/system_axi_gpio_0_1.vhd2
898@Z8-256h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
	gpio_io_t2
system_axi_gpio_0_12

axi_gpio_12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
3888@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2

gpio2_io_t2
system_axi_gpio_0_12

axi_gpio_12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
3888@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2

axi_gpio_12
system_axi_gpio_0_12
252
232{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
3888@Z8-7023h px� 
�
synthesizing module '%s'638*oasys2
system_axi_gpio_0_22�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/synth/system_axi_gpio_0_2.vhd2
898@Z8-638h px� 
M
%s
*synth25
3	Parameter C_FAMILY bound to: zynq - type: string 
h p
x
� 
U
%s
*synth2=
;	Parameter C_S_AXI_ADDR_WIDTH bound to: 9 - type: integer 
h p
x
� 
V
%s
*synth2>
<	Parameter C_S_AXI_DATA_WIDTH bound to: 32 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter C_GPIO_WIDTH bound to: 32 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter C_GPIO2_WIDTH bound to: 32 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter C_ALL_INPUTS bound to: 0 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter C_ALL_INPUTS_2 bound to: 0 - type: integer 
h p
x
� 
P
%s
*synth28
6	Parameter C_ALL_OUTPUTS bound to: 0 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter C_ALL_OUTPUTS_2 bound to: 0 - type: integer 
h p
x
� 
V
%s
*synth2>
<	Parameter C_INTERRUPT_PRESENT bound to: 0 - type: integer 
h p
x
� 
d
%s
*synth2L
J	Parameter C_DOUT_DEFAULT bound to: 32'b00000000000000000000000000000000 
h p
x
� 
c
%s
*synth2K
I	Parameter C_TRI_DEFAULT bound to: 32'b11111111111111111111111111111111 
h p
x
� 
L
%s
*synth24
2	Parameter C_IS_DUAL bound to: 1 - type: integer 
h p
x
� 
f
%s
*synth2N
L	Parameter C_DOUT_DEFAULT_2 bound to: 32'b00000000000000000000000000000000 
h p
x
� 
e
%s
*synth2M
K	Parameter C_TRI_DEFAULT_2 bound to: 32'b11111111111111111111111111111111 
h p
x
� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2

axi_gpio2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
12702
U02

axi_gpio2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/synth/system_axi_gpio_0_2.vhd2
1798@Z8-3491h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
system_axi_gpio_0_22
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/synth/system_axi_gpio_0_2.vhd2
898@Z8-256h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
	gpio_io_t2
system_axi_gpio_0_22

axi_gpio_22{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
4128@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2

gpio2_io_t2
system_axi_gpio_0_22

axi_gpio_22{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
4128@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2

axi_gpio_22
system_axi_gpio_0_22
252
232{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
4128@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2!
system_iir_filter_2nd_order_0_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_iir_filter_2nd_order_0_0/synth/system_iir_filter_2nd_order_0_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
iir_filter_2nd_order2
 2�
�C:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/sources_1/imports/verilog/iir_filter_2nd_order.v2
48@Z8-6157h px� 
Q
%s
*synth29
7	Parameter IN_DATA_WIDTH bound to: 16 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter OUT_DATA_WIDTH bound to: 16 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter IN_COEFF_WIDTH bound to: 32 - type: integer 
h p
x
� 
N
%s
*synth26
4	Parameter DATA_WIDTH bound to: 18 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter COEFF_WIDTH bound to: 25 - type: integer 
h p
x
� 
J
%s
*synth22
0	Parameter B_SHIFT bound to: 7 - type: integer 
h p
x
� 
K
%s
*synth23
1	Parameter LOG_DIV bound to: 12 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
iir_filter_2nd_order2
 2
02
12�
�C:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/sources_1/imports/verilog/iir_filter_2nd_order.v2
48@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
system_iir_filter_2nd_order_0_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_iir_filter_2nd_order_0_0/synth/system_iir_filter_2nd_order_0_0.v2
538@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
system_xlconstant_0_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlconstant_0_0/synth/system_xlconstant_0_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
xlconstant_v1_1_9_xlconstant2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v2
688@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
xlconstant_v1_1_9_xlconstant2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v2
688@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_xlconstant_0_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xlconstant_0_0/synth/system_xlconstant_0_0.v2
538@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
iir2nd_imp_ETYQWW2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
1308@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
system_pll_0_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0.v2
688@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_pll_0_0_clk_wiz2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0_clk_wiz.v2
688@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
IBUFDS2
 29
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
736588@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
IBUFDS2
 2
02
129
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
736588@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	PLLE2_ADV2
 29
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1147508@Z8-6157h px� 
S
%s
*synth2;
9	Parameter BANDWIDTH bound to: OPTIMIZED - type: string 
h p
x
� 
P
%s
*synth28
6	Parameter CLKFBOUT_MULT bound to: 8 - type: integer 
h p
x
� 
W
%s
*synth2?
=	Parameter CLKFBOUT_PHASE bound to: 0.000000 - type: double 
h p
x
� 
V
%s
*synth2>
<	Parameter CLKIN1_PERIOD bound to: 8.000000 - type: double 
h p
x
� 
Q
%s
*synth29
7	Parameter CLKOUT0_DIVIDE bound to: 8 - type: integer 
h p
x
� 
[
%s
*synth2C
A	Parameter CLKOUT0_DUTY_CYCLE bound to: 0.500000 - type: double 
h p
x
� 
V
%s
*synth2>
<	Parameter CLKOUT0_PHASE bound to: 0.000000 - type: double 
h p
x
� 
Q
%s
*synth29
7	Parameter CLKOUT1_DIVIDE bound to: 4 - type: integer 
h p
x
� 
[
%s
*synth2C
A	Parameter CLKOUT1_DUTY_CYCLE bound to: 0.500000 - type: double 
h p
x
� 
X
%s
*synth2@
>	Parameter CLKOUT1_PHASE bound to: 157.500000 - type: double 
h p
x
� 
Q
%s
*synth29
7	Parameter CLKOUT2_DIVIDE bound to: 4 - type: integer 
h p
x
� 
[
%s
*synth2C
A	Parameter CLKOUT2_DUTY_CYCLE bound to: 0.500000 - type: double 
h p
x
� 
X
%s
*synth2@
>	Parameter CLKOUT2_PHASE bound to: 202.500000 - type: double 
h p
x
� 
R
%s
*synth2:
8	Parameter CLKOUT3_DIVIDE bound to: 32 - type: integer 
h p
x
� 
[
%s
*synth2C
A	Parameter CLKOUT3_DUTY_CYCLE bound to: 0.500000 - type: double 
h p
x
� 
V
%s
*synth2>
<	Parameter CLKOUT3_PHASE bound to: 0.000000 - type: double 
h p
x
� 
R
%s
*synth2:
8	Parameter COMPENSATION bound to: ZHOLD - type: string 
h p
x
� 
P
%s
*synth28
6	Parameter DIVCLK_DIVIDE bound to: 1 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter STARTUP_WAIT bound to: FALSE - type: string 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	PLLE2_ADV2
 2
02
129
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1147508@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
BUFG2
 29
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2
19518@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
BUFG2
 2
02
129
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2
19518@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_pll_0_0_clk_wiz2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0_clk_wiz.v2
688@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_pll_0_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0.v2
688@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
soc_imp_QM05TO2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
31768@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_axi_interconnect_0_02
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
40868@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
m00_couplers_imp_1Q18GCT2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
4518@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_auto_pc_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_0/synth/system_auto_pc_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys27
5axi_protocol_converter_v2_1_31_axi_protocol_converter2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
52858@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2$
"axi_protocol_converter_v2_1_31_b2s2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
47048@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2/
-axi_protocol_converter_v2_1_31_b2s_aw_channel2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
43608@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys23
1axi_protocol_converter_v2_1_31_b2s_cmd_translator2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
37208@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2-
+axi_protocol_converter_v2_1_31_b2s_incr_cmd2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
32168@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2-
+axi_protocol_converter_v2_1_31_b2s_incr_cmd2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
32168@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2-
+axi_protocol_converter_v2_1_31_b2s_wrap_cmd2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
29828@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2-
+axi_protocol_converter_v2_1_31_b2s_wrap_cmd2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
29828@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys23
1axi_protocol_converter_v2_1_31_b2s_cmd_translator2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
37208@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2/
-axi_protocol_converter_v2_1_31_b2s_wr_cmd_fsm2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
33928@Z8-6157h px� 
�
default block is never used226*oasys2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
34468@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2/
-axi_protocol_converter_v2_1_31_b2s_wr_cmd_fsm2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
33928@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2/
-axi_protocol_converter_v2_1_31_b2s_aw_channel2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
43608@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2.
,axi_protocol_converter_v2_1_31_b2s_b_channel2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
39068@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys20
.axi_protocol_converter_v2_1_31_b2s_simple_fifo2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys20
.axi_protocol_converter_v2_1_31_b2s_simple_fifo2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_protocol_converter_v2_1_31_b2s_simple_fifo__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_protocol_converter_v2_1_31_b2s_simple_fifo__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2.
,axi_protocol_converter_v2_1_31_b2s_b_channel2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
39068@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2/
-axi_protocol_converter_v2_1_31_b2s_ar_channel2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
45168@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2/
-axi_protocol_converter_v2_1_31_b2s_rd_cmd_fsm2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
35468@Z8-6157h px� 
�
default block is never used226*oasys2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
36088@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2/
-axi_protocol_converter_v2_1_31_b2s_rd_cmd_fsm2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
35468@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2/
-axi_protocol_converter_v2_1_31_b2s_ar_channel2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
45168@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2.
,axi_protocol_converter_v2_1_31_b2s_r_channel2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
41558@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_protocol_converter_v2_1_31_b2s_simple_fifo__parameterized12
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_protocol_converter_v2_1_31_b2s_simple_fifo__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_protocol_converter_v2_1_31_b2s_simple_fifo__parameterized22
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_protocol_converter_v2_1_31_b2s_simple_fifo__parameterized22
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
28528@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2.
,axi_protocol_converter_v2_1_31_b2s_r_channel2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
41558@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2/
-axi_register_slice_v2_1_31_axi_register_slice2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
37188@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2&
$axi_infrastructure_v1_1_0_axi2vector2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
598@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2&
$axi_infrastructure_v1_1_0_axi2vector2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
598@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2&
$axi_infrastructure_v1_1_0_vector2axi2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
4738@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2&
$axi_infrastructure_v1_1_0_vector2axi2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
4738@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys20
.axi_register_slice_v2_1_31_axic_register_slice2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys20
.axi_register_slice_v2_1_31_axic_register_slice2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized12
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized22
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized22
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2/
-axi_register_slice_v2_1_31_axi_register_slice2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
37188@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
SI_REG2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
48718@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
SI_REG2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
48718@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2?
=axi_register_slice_v2_1_31_axi_register_slice__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
37188@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys26
4axi_infrastructure_v1_1_0_axi2vector__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
598@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys26
4axi_infrastructure_v1_1_0_axi2vector__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
598@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys26
4axi_infrastructure_v1_1_0_vector2axi__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
4738@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys26
4axi_infrastructure_v1_1_0_vector2axi__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
4738@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized32
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized32
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized42
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized42
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized52
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized52
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized62
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized62
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2?
=axi_register_slice_v2_1_31_axi_register_slice__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
37188@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
MI_REG2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
51268@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
MI_REG2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
51268@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2$
"axi_protocol_converter_v2_1_31_b2s2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
47048@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys27
5axi_protocol_converter_v2_1_31_axi_protocol_converter2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
52858@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_auto_pc_02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_0/synth/system_auto_pc_0.v2
538@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_awprot2
system_auto_pc_02	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
6908@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_arprot2
system_auto_pc_02	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
6908@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2	
auto_pc2
system_auto_pc_02
602
582{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
6908@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m00_couplers_imp_1Q18GCT2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
4518@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
m01_couplers_imp_VMJT5O2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
7518@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_auto_pc_12
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_1/synth/system_auto_pc_1.v2
538@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_auto_pc_12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_1/synth/system_auto_pc_1.v2
538@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_awprot2
system_auto_pc_12	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
9908@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_arprot2
system_auto_pc_12	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
9908@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2	
auto_pc2
system_auto_pc_12
602
582{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
9908@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m01_couplers_imp_VMJT5O2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
7518@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
m02_couplers_imp_OH0KHA2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
10518@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_auto_pc_22
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_2/synth/system_auto_pc_2.v2
538@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_auto_pc_22
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_2/synth/system_auto_pc_2.v2
538@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_awprot2
system_auto_pc_22	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
12908@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_arprot2
system_auto_pc_22	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
12908@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2	
auto_pc2
system_auto_pc_22
602
582{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
12908@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m02_couplers_imp_OH0KHA2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
10518@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
m03_couplers_imp_1WCT7WF2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
13518@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m03_couplers_imp_1WCT7WF2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
13518@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
m04_couplers_imp_3876MI2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
16378@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m04_couplers_imp_3876MI2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
16378@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
m05_couplers_imp_1A01GBF2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
19238@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m05_couplers_imp_1A01GBF2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
19238@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
m06_couplers_imp_12UI90P2
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
22098@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m06_couplers_imp_12UI90P2
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
22098@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
m07_couplers_imp_9JRZY02
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
24958@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
m07_couplers_imp_9JRZY02
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
24958@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
s00_couplers_imp_1SEIN302
 2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
27818@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
system_auto_pc_32
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_3/synth/system_auto_pc_3.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2G
Eaxi_protocol_converter_v2_1_31_axi_protocol_converter__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
52858@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2G
Eaxi_protocol_converter_v2_1_31_axi_protocol_converter__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
52858@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
system_auto_pc_32
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_auto_pc_3/synth/system_auto_pc_3.v2
538@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_awregion2
system_auto_pc_32	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
30968@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
m_axi_arregion2
system_auto_pc_32	
auto_pc2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
30968@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2	
auto_pc2
system_auto_pc_32
792
772{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
30968@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
s00_couplers_imp_1SEIN302
 2
02
12{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
27818@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
system_xbar_02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_xbar_0/synth/system_xbar_0.v2
538@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2#
!axi_crossbar_v2_1_32_axi_crossbar2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
48718@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
axi_crossbar_v2_1_32_crossbar2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
22328@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2$
"axi_crossbar_v2_1_32_si_transactor2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
37918@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2#
!axi_crossbar_v2_1_32_addr_decoder2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
7908@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2-
+generic_baseblocks_v2_1_2_comparator_static2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
21198@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2%
#generic_baseblocks_v2_1_2_carry_and2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
608@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2%
#generic_baseblocks_v2_1_2_carry_and2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
608@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2-
+generic_baseblocks_v2_1_2_comparator_static2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
21198@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2=
;generic_baseblocks_v2_1_2_comparator_static__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
21198@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2=
;generic_baseblocks_v2_1_2_comparator_static__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
21198@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2=
;generic_baseblocks_v2_1_2_comparator_static__parameterized12
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
21198@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2=
;generic_baseblocks_v2_1_2_comparator_static__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
21198@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
!axi_crossbar_v2_1_32_addr_decoder2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
7908@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2%
#axi_data_fifo_v2_1_30_axic_srl_fifo2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
6948@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2!
axi_data_fifo_v2_1_30_ndeep_srl2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
11298@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2	
SRLC32E2
 29
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1374128@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2	
SRLC32E2
 2
02
129
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1374128@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
axi_data_fifo_v2_1_30_ndeep_srl2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
11298@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2%
#axi_data_fifo_v2_1_30_axic_srl_fifo2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
6948@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2#
!axi_crossbar_v2_1_32_arbiter_resp2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
10208@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
!axi_crossbar_v2_1_32_arbiter_resp2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
10208@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2#
!generic_baseblocks_v2_1_2_mux_enc2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
24368@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
MUXF72
 29
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
886378@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
MUXF72
 2
02
129
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
886378@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
MUXF82
 29
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
886748@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
MUXF82
 2
02
129
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
886748@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
!generic_baseblocks_v2_1_2_mux_enc2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
24368@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2$
"axi_crossbar_v2_1_32_si_transactor2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
37918@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys24
2axi_crossbar_v2_1_32_si_transactor__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
37918@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys23
1generic_baseblocks_v2_1_2_mux_enc__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
24368@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys23
1generic_baseblocks_v2_1_2_mux_enc__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v2
24368@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys24
2axi_crossbar_v2_1_32_si_transactor__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
37918@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
axi_crossbar_v2_1_32_splitter2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
44518@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
axi_crossbar_v2_1_32_splitter2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
44518@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2#
!axi_crossbar_v2_1_32_wdata_router2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
47248@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2)
'axi_data_fifo_v2_1_30_axic_reg_srl_fifo2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
8848@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys21
/axi_data_fifo_v2_1_30_ndeep_srl__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
11298@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys21
/axi_data_fifo_v2_1_30_ndeep_srl__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
11298@Z8-6155h px� 
�
-case statement is not full and has no default155*oasys2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
9828@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2)
'axi_data_fifo_v2_1_30_axic_reg_srl_fifo2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
8848@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
!axi_crossbar_v2_1_32_wdata_router2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
47248@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys25
3axi_data_fifo_v2_1_30_axic_srl_fifo__parameterized02
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
6948@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys25
3axi_data_fifo_v2_1_30_axic_srl_fifo__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
6948@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2 
axi_crossbar_v2_1_32_wdata_mux2
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
45508@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2 
axi_crossbar_v2_1_32_wdata_mux2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
45508@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2?
=axi_register_slice_v2_1_31_axi_register_slice__parameterized12
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
37188@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys26
4axi_infrastructure_v1_1_0_axi2vector__parameterized12
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
598@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys26
4axi_infrastructure_v1_1_0_axi2vector__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
598@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys26
4axi_infrastructure_v1_1_0_vector2axi__parameterized12
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
4738@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys26
4axi_infrastructure_v1_1_0_vector2axi__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v2
4738@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized72
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized72
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized82
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized82
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized92
 2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6157h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-61572
100Z17-14h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized92
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2A
?axi_register_slice_v2_1_31_axic_register_slice__parameterized102
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
14928@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2?
=axi_register_slice_v2_1_31_axi_register_slice__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
37188@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys21
/axi_data_fifo_v2_1_30_ndeep_srl__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
11298@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys25
3axi_data_fifo_v2_1_30_axic_srl_fifo__parameterized12
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
6948@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys20
.axi_crossbar_v2_1_32_wdata_mux__parameterized02
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
45508@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
aclk2x2/
-axi_register_slice_v2_1_31_axi_register_slice2
reg_slice_mi2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
reg_slice_mi2/
-axi_register_slice_v2_1_31_axi_register_slice2
932
922�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
31168@Z8-7023h px� 
�
-case statement is not full and has no default155*oasys2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
36268@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
!axi_crossbar_v2_1_32_decerr_slave2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
34938@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
!axi_crossbar_v2_1_32_addr_arbiter2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
4208@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
axi_crossbar_v2_1_32_crossbar2
 2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
22328@Z8-6155h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-61552
100Z17-14h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_araddr2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arburst2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arcache2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arlen2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arlock2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arprot2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arqos2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arregion2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arsize2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_arvalid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awaddr2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awburst2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awcache2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awlen2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awlock2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awprot2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awqos2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awregion2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awsize2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_awvalid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_bready2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_rready2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_wdata2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_wlast2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_wstrb2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M03_AXI_wvalid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_araddr2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arburst2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arcache2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arlen2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arlock2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arprot2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arqos2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arregion2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arsize2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_arvalid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awaddr2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awburst2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awcache2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awlen2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awlock2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awprot2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awqos2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awregion2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awsize2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_awvalid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_bready2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_rready2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_wdata2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_wlast2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_wstrb2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M04_AXI_wvalid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_araddr2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arburst2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arcache2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arlen2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arlock2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arprot2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arqos2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arregion2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arsize2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_arvalid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_awaddr2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_awburst2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_awcache2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_awid2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_awlen2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_awlock2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
M05_AXI_awprot2
system_axi_interconnect_0_02
axi_interconnect_02{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7071h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-70712
100Z17-14h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
axi_interconnect_02
system_axi_interconnect_0_02
3042
1642{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
34988@Z8-7023h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
inst2,
*processing_system7_v5_5_processing_system72
6852
6722�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_ps_0_0/synth/system_ps_0_0.v2
3748@Z8-7023h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
ps_02
system_ps_0_02
822
662{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
36658@Z8-7023h px� 
�
synthesizing module '%s'638*oasys2
system_rst_0_02�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/synth/system_rst_0_0.vhd2
748@Z8-638h px� 
M
%s
*synth25
3	Parameter C_FAMILY bound to: zynq - type: string 
h p
x
� 
R
%s
*synth2:
8	Parameter C_EXT_RST_WIDTH bound to: 4 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter C_AUX_RST_WIDTH bound to: 4 - type: integer 
h p
x
� 
F
%s
*synth2.
,	Parameter C_EXT_RESET_HIGH bound to: 1'b0 
h p
x
� 
F
%s
*synth2.
,	Parameter C_AUX_RESET_HIGH bound to: 1'b0 
h p
x
� 
P
%s
*synth28
6	Parameter C_NUM_BUS_RST bound to: 1 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter C_NUM_PERP_RST bound to: 1 - type: integer 
h p
x
� 
]
%s
*synth2E
C	Parameter C_NUM_INTERCONNECT_ARESETN bound to: 1 - type: integer 
h p
x
� 
U
%s
*synth2=
;	Parameter C_NUM_PERP_ARESETN bound to: 1 - type: integer 
h p
x
� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
proc_sys_reset2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
12712
U02
proc_sys_reset2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/synth/system_rst_0_0.vhd2
1298@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
proc_sys_reset2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
13308@Z8-638h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b1 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b1 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b1 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
synthesizing module '%s'638*oasys2
lpf2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
8218@Z8-638h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
SRL1627
5C:/Xilinx/Vivado/2024.1/scripts/rt/data/unisim_comp.v2
1372462
	POR_SRL_I2
SRL162�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
8738@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
cdc_sync__parameterized02�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
1068@Z8-638h px� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
cdc_sync__parameterized02
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd2
1068@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
lpf2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
8218@Z8-256h px� 
�
synthesizing module '%s'638*oasys2
sequence_psr2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
3048@Z8-638h px� 
�
synthesizing module '%s'638*oasys2	
upcnt_n2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
1268@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2	
upcnt_n2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
1268@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
sequence_psr2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
3048@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
proc_sys_reset2
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd2
13308@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
system_rst_0_02
02
12�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/synth/system_rst_0_0.vhd2
748@Z8-256h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
rst_02
system_rst_0_02
102
72{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
37328@Z8-7023h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[0].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[1].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[2].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[3].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[4].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[5].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[6].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[7].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[8].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys24
2Dual.ALLOUT0_ND_G0.READ_REG_GEN[9].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[10].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[11].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[12].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[13].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[14].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[15].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[16].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[17].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[18].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[19].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[20].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[21].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[22].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[23].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[24].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[25].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[26].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[27].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[28].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[29].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[30].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys25
3Dual.ALLOUT0_ND_G0.READ_REG_GEN[31].GPIO_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
6228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[0].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[1].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[2].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[3].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[4].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[5].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[6].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[7].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[8].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys26
4Dual.ALLOUT0_ND_G2.READ_REG2_GEN[9].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[10].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[11].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[12].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[13].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[14].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[15].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[16].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[17].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[18].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[19].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[20].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[21].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[22].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[23].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[24].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[25].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[26].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[27].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[28].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[29].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[30].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys27
5Dual.ALLOUT0_ND_G2.READ_REG2_GEN[31].GPIO2_DBus_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/4208/hdl/axi_gpio_v2_0_vh_rfs.vhd2
7538@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
gain_reg_reg2�
�C:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/sources_1/imports/verilog/iir_filter_2nd_order.v2
868@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
state_r1_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
35968@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
s_arlen_r_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v2
35978@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
areset_d1_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
7478@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
S_READY_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
7868@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[0].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[1].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[2].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[3].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[4].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[5].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[6].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[7].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[0].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[1].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[2].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[3].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[4].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[5].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[6].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2U
Sgen_multi_thread.gen_thread_loop[7].gen_debug_r_multi_thread.debug_r_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
43388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
areset_d1_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
7478@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
S_READY_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
7868@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
areset_d1_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
7478@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
S_READY_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v2
7868@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[0].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[1].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[2].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[3].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[4].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[5].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[6].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[7].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2E
Cgen_master_slots[8].gen_mi_write.gen_debug_w.debug_w_beat_cnt_i_reg2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v2
29918@Z8-6014h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
adc_enc_n_o2
system2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
38078@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
adc_enc_p_o2
system2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
38088@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
	dac_pwm_o2
system2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
38118@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
led_o2
system2{
wc:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/synth/system.v2
38178@Z8-3848h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

prmry_aclk2
cdc_sync__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
prmry_resetn2
cdc_sync__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
prmry_vect_in[1]2
cdc_sync__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
prmry_vect_in[0]2
cdc_sync__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
scndry_resetn2
cdc_sync__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_COL2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_CRS2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RX_DV2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RX_ER2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[7]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[6]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[5]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[4]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[3]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[1]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET0_GMII_RXD[0]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_COL2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_CRS2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RX_DV2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RX_ER2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[7]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[6]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[5]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[4]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[3]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[1]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ENET1_GMII_RXD[0]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_GP0_ARSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_GP0_AWSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_GP1_ARSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_GP1_AWSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_ACP_ARSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_ACP_AWSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP0_ARSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP0_AWSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP1_ARSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP1_AWSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP2_ARSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP2_AWSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP3_ARSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
S_AXI_HP3_AWSIZE[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FCLK_CLKTRIG3_N2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FCLK_CLKTRIG2_N2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FCLK_CLKTRIG1_N2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FCLK_CLKTRIG0_N2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[31]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[30]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[29]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[28]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[27]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[26]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[25]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[24]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[23]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[22]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[21]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[20]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[19]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[18]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[17]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[16]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[15]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[14]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[13]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[12]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[11]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[10]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[9]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[8]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[7]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[6]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[5]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[4]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[3]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[1]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_DATA[0]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_VALID2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_ATID[3]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_ATID[2]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_ATID[1]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
FTMD_TRACEIN_ATID[0]2,
*processing_system7_v5_5_processing_system7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ACLK2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ARESET2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized7Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ACLK2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
ARESET2@
>axi_register_slice_v2_1_31_axic_register_slice__parameterized0Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
m_axi_buser[0]26
4axi_infrastructure_v1_1_0_vector2axi__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
m_axi_ruser[0]26
4axi_infrastructure_v1_1_0_vector2axi__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_awuser[0]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[11]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[10]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[9]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[8]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[7]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[6]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[5]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[4]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
s_axi_wid[3]26
4axi_infrastructure_v1_1_0_axi2vector__parameterized1Z8-7129h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-71292
100Z17-14h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:08 ; elapsed = 00:00:17 . Memory (MB): peak = 1717.152 ; gain = 772.410
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:08 ; elapsed = 00:00:17 . Memory (MB): peak = 1717.152 ; gain = 772.410
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:08 ; elapsed = 00:00:17 . Memory (MB): peak = 1717.152 ; gain = 772.410
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.5382

1717.1522
0.000Z17-268h px� 
V
-Analyzing %s Unisim elements for replacement
17*netlist2
1313Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
1Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0_board.xdc2
system_i/pll_0/inst	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0_board.xdc2
system_i/pll_0/inst	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0.xdc2
system_i/pll_0/inst	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0.xdc2
system_i/pll_0/inst	8Z20-847h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_pll_0_0/system_pll_0_0.xdc2"
 .Xil/system_wrapper_propImpl.xdcZ1-236h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_ps_0_0/system_ps_0_0.xdc2
system_i/soc/ps_0/inst	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_ps_0_0/system_ps_0_0.xdc2
system_i/soc/ps_0/inst	8Z20-847h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_ps_0_0/system_ps_0_0.xdc2"
 .Xil/system_wrapper_propImpl.xdcZ1-236h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0_board.xdc2
system_i/soc/rst_0/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0_board.xdc2
system_i/soc/rst_0/U0	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0.xdc2
system_i/soc/rst_0/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0.xdc2
system_i/soc/rst_0/U0	8Z20-847h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0.xdc2"
 .Xil/system_wrapper_propImpl.xdcZ1-236h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0_board.xdc2!
system_i/iir2nd/axi_gpio_0/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0_board.xdc2!
system_i/iir2nd/axi_gpio_0/U0	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0.xdc2!
system_i/iir2nd/axi_gpio_0/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_0/system_axi_gpio_0_0.xdc2!
system_i/iir2nd/axi_gpio_0/U0	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1_board.xdc2!
system_i/iir2nd/axi_gpio_1/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1_board.xdc2!
system_i/iir2nd/axi_gpio_1/U0	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1.xdc2!
system_i/iir2nd/axi_gpio_1/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1.xdc2!
system_i/iir2nd/axi_gpio_1/U0	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2_board.xdc2!
system_i/iir2nd/axi_gpio_2/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2_board.xdc2!
system_i/iir2nd/axi_gpio_2/U0	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2.xdc2!
system_i/iir2nd/axi_gpio_2/U0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_axi_gpio_0_2/system_axi_gpio_0_2.xdc2!
system_i/iir2nd/axi_gpio_2/U0	8Z20-847h px� 
8
Deriving generated clocks
2*timingZ38-2h px� 
�
Parsing XDC File [%s]
179*designutils2z
vC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/constrs_1/imports/cfg/clocks.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2z
vC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/constrs_1/imports/cfg/clocks.xdc8Z20-178h px� 
�
Parsing XDC File [%s]
179*designutils2y
uC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/constrs_1/imports/cfg/ports.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2y
uC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/constrs_1/imports/cfg/ports.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2w
uC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.srcs/constrs_1/imports/cfg/ports.xdc2"
 .Xil/system_wrapper_propImpl.xdcZ1-236h px� 
�
Parsing XDC File [%s]
179*designutils2p
lC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.runs/synth_1/dont_touch.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2p
lC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.runs/synth_1/dont_touch.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2n
lC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.runs/synth_1/dont_touch.xdc2"
 .Xil/system_wrapper_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0072

1819.2732
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2m
k  A total of 1165 instances were transformed.
  FDR => FDRE: 1164 instances
  SRL16 => SRL16E: 1 instance 
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:012
00:00:00.1202

1819.2732
0.000Z17-268h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:18 ; elapsed = 00:00:29 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Loading part: xc7z010clg400-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:18 ; elapsed = 00:00:29 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:18 ; elapsed = 00:00:30 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
t
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
slave_attachmentZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2/
-axi_protocol_converter_v2_1_31_b2s_wr_cmd_fsmZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2/
-axi_protocol_converter_v2_1_31_b2s_rd_cmd_fsmZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2)
'axi_data_fifo_v2_1_30_axic_reg_srl_fifoZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
gen_axi.write_cs_reg2#
!axi_crossbar_v2_1_32_decerr_slaveZ8-802h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                 iSTATE2 |                             0001 |                               00
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                             0010 |                               01
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                             0100 |                               10
h p
x
� 
y
%s
*synth2a
_                 iSTATE1 |                             1000 |                               11
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2
slave_attachmentZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                 SM_IDLE |                             0010 |                               00
h p
x
� 
y
%s
*synth2a
_               SM_CMD_EN |                             1000 |                               01
h p
x
� 
y
%s
*synth2a
_         SM_CMD_ACCEPTED |                             0100 |                               10
h p
x
� 
y
%s
*synth2a
_            SM_DONE_WAIT |                             0001 |                               11
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2/
-axi_protocol_converter_v2_1_31_b2s_wr_cmd_fsmZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                 SM_IDLE |                             0010 |                               00
h p
x
� 
y
%s
*synth2a
_               SM_CMD_EN |                             1000 |                               01
h p
x
� 
y
%s
*synth2a
_         SM_CMD_ACCEPTED |                             0100 |                               10
h p
x
� 
y
%s
*synth2a
_                 SM_DONE |                             0001 |                               11
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2/
-axi_protocol_converter_v2_1_31_b2s_rd_cmd_fsmZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                    ZERO |                             1000 |                               10
h p
x
� 
y
%s
*synth2a
_                     ONE |                             0010 |                               11
h p
x
� 
y
%s
*synth2a
_                     TWO |                             0001 |                               01
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                             0100 |                               00
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2)
'axi_data_fifo_v2_1_30_axic_reg_srl_fifoZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_            P_WRITE_IDLE |                              001 |                               00
h p
x
� 
y
%s
*synth2a
_            P_WRITE_DATA |                              010 |                               01
h p
x
� 
y
%s
*synth2a
_            P_WRITE_RESP |                              100 |                               10
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
gen_axi.write_cs_reg2	
one-hot2#
!axi_crossbar_v2_1_32_decerr_slaveZ8-3354h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:20 ; elapsed = 00:00:32 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   6 Input   43 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   30 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   12 Bit       Adders := 25    
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 18    
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 81    
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit       Adders := 10    
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit       Adders := 7     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit       Adders := 2     
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   2 Input      1 Bit         XORs := 26    
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               75 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	               73 Bit    Registers := 12    
h p
x
� 
H
%s
*synth20
.	               47 Bit    Registers := 24    
h p
x
� 
H
%s
*synth20
.	               32 Bit    Registers := 24    
h p
x
� 
H
%s
*synth20
.	               30 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               25 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	               20 Bit    Registers := 12    
h p
x
� 
H
%s
*synth20
.	               18 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	               16 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               14 Bit    Registers := 19    
h p
x
� 
H
%s
*synth20
.	               12 Bit    Registers := 46    
h p
x
� 
H
%s
*synth20
.	                9 Bit    Registers := 15    
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 9     
h p
x
� 
H
%s
*synth20
.	                6 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 12    
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 40    
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 12    
h p
x
� 
H
%s
*synth20
.	                2 Bit    Registers := 64    
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 609   
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   73 Bit        Muxes := 12    
h p
x
� 
F
%s
*synth2.
,	   2 Input   72 Bit        Muxes := 18    
h p
x
� 
F
%s
*synth2.
,	   2 Input   64 Bit        Muxes := 16    
h p
x
� 
F
%s
*synth2.
,	   2 Input   47 Bit        Muxes := 24    
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit        Muxes := 39    
h p
x
� 
F
%s
*synth2.
,	   4 Input   20 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input   14 Bit        Muxes := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input   12 Bit        Muxes := 18    
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit        Muxes := 17    
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 18    
h p
x
� 
F
%s
*synth2.
,	   4 Input    4 Bit        Muxes := 9     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 134   
h p
x
� 
F
%s
*synth2.
,	   3 Input    4 Bit        Muxes := 17    
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit        Muxes := 72    
h p
x
� 
F
%s
*synth2.
,	   3 Input    2 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   4 Input    2 Bit        Muxes := 18    
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 391   
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 12    
h p
x
� 
F
%s
*synth2.
,	   3 Input    1 Bit        Muxes := 8     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
p
%s
*synth2X
VPart Resources:
DSPs: 80 (col length:40)
BRAMs: 120 (col length: RAMB18 40 RAMB36 20)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
]
%s
*synth2E
CDSP Report: Generating DSP inst/b1_x10, operation Mode is: A2*B''.
h p
x
� 
]
%s
*synth2E
CDSP Report: register inst/x0_reg is absorbed into DSP inst/b1_x10.
h p
x
� 
]
%s
*synth2E
CDSP Report: register inst/x1_reg is absorbed into DSP inst/b1_x10.
h p
x
� 
a
%s
*synth2I
GDSP Report: register inst/b1_reg_reg is absorbed into DSP inst/b1_x10.
h p
x
� 
]
%s
*synth2E
CDSP Report: operator inst/b1_x10 is absorbed into DSP inst/b1_x10.
h p
x
� 
\
%s
*synth2D
BDSP Report: Generating DSP inst/b0_x00, operation Mode is: A2*B2.
h p
x
� 
]
%s
*synth2E
CDSP Report: register inst/x0_reg is absorbed into DSP inst/b0_x00.
h p
x
� 
a
%s
*synth2I
GDSP Report: register inst/b0_reg_reg is absorbed into DSP inst/b0_x00.
h p
x
� 
]
%s
*synth2E
CDSP Report: operator inst/b0_x00 is absorbed into DSP inst/b0_x00.
h p
x
� 
`
%s
*synth2H
FDSP Report: Generating DSP inst/b2_x20, operation Mode is: A2*BCIN''.
h p
x
� 
]
%s
*synth2E
CDSP Report: register inst/x1_reg is absorbed into DSP inst/b2_x20.
h p
x
� 
]
%s
*synth2E
CDSP Report: register inst/x2_reg is absorbed into DSP inst/b2_x20.
h p
x
� 
a
%s
*synth2I
GDSP Report: register inst/b2_reg_reg is absorbed into DSP inst/b2_x20.
h p
x
� 
]
%s
*synth2E
CDSP Report: operator inst/b2_x20 is absorbed into DSP inst/b2_x20.
h p
x
� 
[
%s
*synth2C
ADSP Report: Generating DSP inst/a1_y1, operation Mode is: A2*B2.
h p
x
� 
\
%s
*synth2D
BDSP Report: register inst/y1_reg is absorbed into DSP inst/a1_y1.
h p
x
� 
`
%s
*synth2H
FDSP Report: register inst/a1_reg_reg is absorbed into DSP inst/a1_y1.
h p
x
� 
[
%s
*synth2C
ADSP Report: operator inst/a1_y1 is absorbed into DSP inst/a1_y1.
h p
x
� 
[
%s
*synth2C
ADSP Report: Generating DSP inst/a2_y2, operation Mode is: A2*B2.
h p
x
� 
\
%s
*synth2D
BDSP Report: register inst/y2_reg is absorbed into DSP inst/a2_y2.
h p
x
� 
`
%s
*synth2H
FDSP Report: register inst/a2_reg_reg is absorbed into DSP inst/a2_y2.
h p
x
� 
[
%s
*synth2C
ADSP Report: operator inst/a2_y2 is absorbed into DSP inst/a2_y2.
h p
x
� 
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2M
Kinst/gen_axilite.gen_b2s_conv.axilite_b2s/SI_REG/aw.aw_pipe/m_payload_i_reg2
732
652�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
17268@Z8-3936h px�
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2M
Kinst/gen_axilite.gen_b2s_conv.axilite_b2s/SI_REG/ar.ar_pipe/m_payload_i_reg2
732
652�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
17268@Z8-3936h px�
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2M
Kinst/gen_axilite.gen_b2s_conv.axilite_b2s/SI_REG/aw.aw_pipe/m_payload_i_reg2
732
652�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
17268@Z8-3936h px�
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2M
Kinst/gen_axilite.gen_b2s_conv.axilite_b2s/SI_REG/ar.ar_pipe/m_payload_i_reg2
732
652�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
17268@Z8-3936h px�
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2M
Kinst/gen_axilite.gen_b2s_conv.axilite_b2s/SI_REG/aw.aw_pipe/m_payload_i_reg2
732
652�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
17268@Z8-3936h px�
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2M
Kinst/gen_axilite.gen_b2s_conv.axilite_b2s/SI_REG/ar.ar_pipe/m_payload_i_reg2
732
652�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v2
17268@Z8-3936h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS4/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[4].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[5].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[6].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[7].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[8].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[9].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[10].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[11].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[12].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[13].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[14].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[15].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[16].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[17].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[18].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[19].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[20].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[21].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[22].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[23].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[24].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[25].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[26].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[27].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[28].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[29].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[30].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d5[31].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d52

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[0].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[1].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[2].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2�
�gpio_core_1/Dual.INPUT_DOUBLE_REGS5/GENERATE_LEVEL_P_S_CDC.MULTI_BIT.FOR_CROSS_PLEVEL_IN2SCNDRY_bus_d6[3].CROSS2_PLEVEL_IN2SCNDRY_s_level_out_bus_d62

axi_gpioZ8-3332h px�
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-33322
100Z17-14h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:32 ; elapsed = 00:00:49 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
Y
%s
*synth2A
? Sort Area is  inst/b0_x00_0 : 0 0 : 3266 6550 : Used 1 time 0
h p
x
� 
Y
%s
*synth2A
? Sort Area is  inst/b0_x00_0 : 0 1 : 3284 6550 : Used 1 time 0
h p
x
� 
Y
%s
*synth2A
? Sort Area is  inst/b1_x10_5 : 0 0 : 3284 3284 : Used 1 time 0
h p
x
� 
X
%s
*synth2@
> Sort Area is  inst/a1_y1_4 : 0 0 : 3266 3266 : Used 1 time 0
h p
x
� 
X
%s
*synth2@
> Sort Area is  inst/a2_y2_3 : 0 0 : 3266 3266 : Used 1 time 0
h p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
v
%s*synth2^
\
DSP: Preliminary Mapping Report (see note below. The ' indicates corresponding REG is set)
h px� 
�
%s*synth2�
�+---------------------+-------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h px� 
�
%s*synth2�
�|Module Name          | DSP Mapping | A Size | B Size | C Size | D Size | P Size | AREG | BREG | CREG | DREG | ADREG | MREG | PREG | 
h px� 
�
%s*synth2�
�+---------------------+-------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h px� 
�
%s*synth2�
�|iir_filter_2nd_order | A2*B''      | 25     | 18     | -      | -      | 43     | 1    | 2    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|iir_filter_2nd_order | A2*B2       | 25     | 18     | -      | -      | 43     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|iir_filter_2nd_order | A2*BCIN''   | 25     | 18     | -      | -      | 43     | 1    | 2    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|iir_filter_2nd_order | A2*B2       | 25     | 18     | -      | -      | 43     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|iir_filter_2nd_order | A2*B2       | 25     | 18     | -      | -      | 43     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�+---------------------+-------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+

h px� 
�
%s*synth2�
�Note: The table above is a preliminary report that shows the DSPs inferred at the current stage of the synthesis flow. Some DSP may be reimplemented as non DSP primitives later in the synthesis flow. Multiple instantiated DSPs are reported only once.
h px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
$%s for constraint at line %s of %s.
3321*oasys2 
set_false_path : Empty to list2
492�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0.xdc2�
�c:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.gen/sources_1/bd/system/ip/system_rst_0_0/system_rst_0_0.xdc2
498@Z8-3321h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:38 ; elapsed = 00:00:59 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:39 ; elapsed = 00:01:01 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:40 ; elapsed = 00:01:04 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:43 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:43 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:44 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:44 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:44 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:44 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 
Dynamic Shift Register Report:
h p
x
� 
~
%s
*synth2f
d+------------+----------------+--------+------------+--------+---------+--------+--------+--------+
h p
x
� 

%s
*synth2g
e|Module Name | RTL Name       | Length | Data Width | SRL16E | SRLC32E | Mux F7 | Mux F8 | Mux F9 | 
h p
x
� 
~
%s
*synth2f
d+------------+----------------+--------+------------+--------+---------+--------+--------+--------+
h p
x
� 

%s
*synth2g
e|dsrl        | memory_reg[31] | 34     | 34         | 0      | 34      | 0      | 0      | 0      | 
h p
x
� 

%s
*synth2g
e|dsrl__1     | memory_reg[31] | 13     | 13         | 0      | 13      | 0      | 0      | 0      | 
h p
x
� 

%s
*synth2g
e+------------+----------------+--------+------------+--------+---------+--------+--------+--------+

h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
W
%s
*synth2?
=
DSP Final Report (the ' indicates corresponding REG is set)
h p
x
� 
�
%s
*synth2�
�+---------------------+-------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h p
x
� 
�
%s
*synth2�
�|Module Name          | DSP Mapping | A Size | B Size | C Size | D Size | P Size | AREG | BREG | CREG | DREG | ADREG | MREG | PREG | 
h p
x
� 
�
%s
*synth2�
�+---------------------+-------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h p
x
� 
�
%s
*synth2�
�|iir_filter_2nd_order | A'*B''      | 30     | 18     | -      | -      | 43     | 1    | 2    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
�|iir_filter_2nd_order | A'*B'       | 30     | 18     | -      | -      | 43     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
�|iir_filter_2nd_order | A'*B''      | 30     | 0      | -      | -      | 43     | 1    | 2    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
�|iir_filter_2nd_order | A'*B'       | 30     | 18     | -      | -      | 43     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
�|iir_filter_2nd_order | A'*B''      | 30     | 18     | -      | -      | 43     | 1    | 2    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
�+---------------------+-------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+

h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
5
%s*synth2
+------+----------+------+
h px� 
5
%s*synth2
|      |Cell      |Count |
h px� 
5
%s*synth2
+------+----------+------+
h px� 
5
%s*synth2
|1     |BIBUF     |   130|
h px� 
5
%s*synth2
|2     |BUFG      |     6|
h px� 
5
%s*synth2
|3     |CARRY4    |   118|
h px� 
5
%s*synth2
|4     |DSP48E1   |     5|
h px� 
5
%s*synth2
|7     |LUT1      |   128|
h px� 
5
%s*synth2
|8     |LUT2      |   167|
h px� 
5
%s*synth2
|9     |LUT3      |   776|
h px� 
5
%s*synth2
|10    |LUT4      |   242|
h px� 
5
%s*synth2
|11    |LUT5      |   625|
h px� 
5
%s*synth2
|12    |LUT6      |  1176|
h px� 
5
%s*synth2
|13    |MUXF7     |    62|
h px� 
5
%s*synth2
|14    |MUXF8     |    62|
h px� 
5
%s*synth2
|15    |ODDR      |    18|
h px� 
5
%s*synth2
|16    |PLLE2_ADV |     1|
h px� 
5
%s*synth2
|17    |PS7       |     1|
h px� 
5
%s*synth2
|18    |SRL16     |     1|
h px� 
5
%s*synth2
|19    |SRLC32E   |   139|
h px� 
5
%s*synth2
|20    |FDR       |   768|
h px� 
5
%s*synth2
|21    |FDRE      |  3686|
h px� 
5
%s*synth2
|22    |FDSE      |   146|
h px� 
5
%s*synth2
|23    |IBUF      |    44|
h px� 
5
%s*synth2
|24    |IBUFDS    |     1|
h px� 
5
%s*synth2
|25    |OBUF      |    19|
h px� 
5
%s*synth2
|26    |OBUFT     |    14|
h px� 
5
%s*synth2
+------+----------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:44 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
b
%s
*synth2J
HSynthesis finished with 0 errors, 0 critical warnings and 400 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:30 ; elapsed = 00:01:02 . Memory (MB): peak = 1819.273 ; gain = 772.410
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:44 ; elapsed = 00:01:09 . Memory (MB): peak = 1819.273 ; gain = 874.531
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.2402

1819.2732
0.000Z17-268h px� 
V
-Analyzing %s Unisim elements for replacement
17*netlist2
1036Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0032

1826.7852
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2k
i  A total of 769 instances were transformed.
  FDR => FDRE: 768 instances
  SRL16 => SRL16E: 1 instance 
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

89fc5297Z4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
4962
3292
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:492

00:01:172

1826.7852

1305.324Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0112

1826.7852
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2r
pC:/Users/magrini/Documents/programming/redpitaya/filter_template/filter_template.runs/synth_1/system_wrapper.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2g
ereport_utilization -file system_wrapper_utilization_synth.rpt -pb system_wrapper_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Wed Feb 26 11:50:03 2025Z17-206h px� 


End Record