

SRC_C := tb

SRC_V := cordic_vec


# check for sanity to avoid later confusion

ifneq ($(words $(CURDIR)),1)
 $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
 endif
 
.PHONY:	default
default:
	@echo "-----Invalid command-----"
	@echo "v: converts .v/.v to c++"
	@echo "run: after -v, run this--"
	@echo "wave: open GTKwave------ "
	@echo "-------------------------"


.PHONY:	v
v:	$(SRC_V).v
	@echo "-- generate obj_dir --"
	verilator --cc $(SRC_V).v

run:
	@echo "-- Verilate & Build --"
	verilator -Wall --trace -cc $(SRC_V).v --exe $(SRC_C).cpp 
	make -C obj_dir -f V$(SRC_V).mk V$(SRC_V)
	./obj_dir/V$(SRC_V)
	@echo "-- Complete! --"

wave:
	@echo "-- open GTKwaveform ------"
	gtkwave waveform.vcd


.PHONY: clear
clear:
	-rm -rf obj_dir *.log *.dmp *.vpd core
