#include <stdlib.h>
#include <iostream>
#include <verilated.h>	// common verilator  routiness
#include <verilated_vcd_c.h>	// write waveforms to a VCD(value change dump) file
#include "Vcordic_vec.h"							// contains the  top class of your ALU module
#include "Vcordic_vec___024root.h"		// 


#define MAX_SIM_TIME 1000000
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env){
	Vcordic_vec *dut = new Vcordic_vec;

	Verilated:: traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;
	dut->trace(m_trace,5);	// param 5 limits the depth of the trace to 5 levels down the dut
	m_trace -> open("waveform.vcd");
	while(sim_time < MAX_SIM_TIME){
		dut->x = 0x11120000;
		dut->y = 0x11120000;
		dut -> clk ^= 1;
		dut -> eval();			//evaluates all the signals in our ALU module
		m_trace -> dump(sim_time);	// writes all the traced signal values into waveform dump file
		sim_time++;

	}
	
	m_trace -> close();
	delete dut;
	exit(EXIT_SUCCESS);



}
