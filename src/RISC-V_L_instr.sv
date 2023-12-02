// `timescale 1ns / 1ps
`timescale 1ns / 1ns
//Module for Store instructions - data to be written to reg file is generated by this module


module L_type(Instr_IO_cpu_sig.L_type_io_ports bus_l);

    logic [31:0] instr;
    logic [31:0] daddr;
    logic [31:0] drdata;
    logic [31:0] out;
    
	
	
	logic [31:0] offset;
	assign instr=bus_l.idata;
	assign daddr=bus_l.daddr;
	assign drdata=bus_l.drdata;
	assign bus_l.regdata_L=out;
	 
    always_comb begin
        offset = (daddr[1:0] << 3);

        unique if (instr[14:12] == 3'b000) begin
            out = {{24{drdata[offset+7]}}, drdata[offset +: 8]};  // LB // multiple of 8
        end 
		else if (instr[14:12] == 3'b001) begin
            out = {{16{drdata[offset+15]}}, drdata[offset +: 16]}; // LH //multiple of 16
        end 
		else if (instr[14:12] == 3'b010) begin
            out = drdata;                                           // LW 
        end 
		else if (instr[14:12] == 3'b100) begin
            out = {24'b0, drdata[offset +: 8]};                     // LBU //multiple of 8 unsigned
        end 
		else if (instr[14:12] == 3'b101) begin
            out = {16'b0, drdata[offset +: 16]};                    // LHU //multiple of 16 unsigned
        end
		else begin
			out = 0;
		end    
    end
endmodule
