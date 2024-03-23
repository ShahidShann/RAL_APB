clean_compile:
	rm -rf work/

compile:
	make clean_compile;
	vlog -sv -f package.f

# Setting a default test as  apb_base_test
ifndef test
override test = apb_base_test
endif


# Setting the default test folder to test name
#time = "_$$(date --iso=seconds)"
ifndef test_folder
override test_folder = $(test)$(time)
endif

simulate:
	rm -rf $(test_folder)
	mkdir $(test_folder)
	vsim \
	work.top \
	-voptargs=+acc=npr \
	+UVM_TESTNAME=$(test) \
	-l $(test_folder)/$(test).log \
	-c -do "add wave -r /*; run -all; exit;" \
	-wlf $(test_folder)/waveform.wlf

#time:
#	printf 'Now time is %s\n' "$$(date --iso=seconds)"
