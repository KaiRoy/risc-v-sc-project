`timescale 1ns / 1ps
//Module for Store instructions - we signal is generated by this module
//This module is used for the Store type instructions. 
//It accepts idata, daddr and we_S from the CPU and uses the value of funct3 as select lines to a multiplexer to choose the specific S_type instruction. 
//Based on this, the 4 bit value of the write enable signal (we_S) is assigned depending on whether a word, half word or a byte is to be written to DMEM. 
//we_S is sent to the CPU.
module S_type(
input logic [31:0]instr,
input logic [31:0]daddr,
output logic [3:0]we_S);

always_comb begin   
        case(instr[14:12])
        3'b000: we_S = (4'b0001)<<daddr[1:0];     //SB
        3'b001: we_S = (4'b0011)<<daddr[1:0];     //SH
        3'b010: we_S = 4'b1111;                   //SW
        endcase
	    end
endmodule