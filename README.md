
### Description

- filter_template:
    is just an adc+dac, if want to make a new filter, copy folder, rename it, modify its xpr file, adding whateve module!

- filter_v1 (working, compiled): 
    is a 2nd order iir filter Direct form II, uses the verilog module 'iir_filter2nd_order_1_1.v' there is a descrpition of the filter workings

- filter_v2 (not working yet, needs debug): 
    is a 2nd order iir filter coupled form, uses the verilog module 'iir_filter2nd_order_2_0.v' there is a descrpition of the filter workings 



### Resources

code largely based on the adc dac by pavel denim's red pitaya notes at

https://github.com/pavel-demin/red-pitaya-notes/

https://pavel-demin.github.io/red-pitaya-notes/

particularly the "template" describes interaction with adc and dac.

block diagram and description: https://pavel-demin.github.io/red-pitaya-notes/axi-hub/

a prebuilt vivado template can be found at https://github.com/pavel-demin/red-pitaya-notes/releases/download/20240204/red-pitaya-notes-20240204.zip

interesting discussin: https://github.com/pavel-demin/red-pitaya-notes/issues/687
