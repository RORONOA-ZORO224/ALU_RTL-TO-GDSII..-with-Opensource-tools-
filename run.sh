#!/bin/bash
iverilog -o alu_sim alu.v tb_alu.v && \
vvp alu_sim && \
gtkwave alu.vcd
