proc check_sva { } {

  vlog -sv ../src_tb/datastream_analyzer_assertions.sv ../src_tb/datastream_analyzer_wrapper.sv
  vcom -2008 ../src_vhd/datastream_analyzer.vhdp

  formal compile -d datastream_analyzer_wrapper -G DATASIZE=2 -G WINDOWSIZE=2 -work work

  formal verify
}


check_sva