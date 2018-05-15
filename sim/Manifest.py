action = "simulation"
sim_tool = "ghdl"
sim_top = "bank_reg_tb"

sim_post_cmd = "ghdl -r bank_reg_tb --stop-time=10us --vcd=bank_reg_tb.vcd; gtkwave bank_reg_tb.vcd"

modules = {
  "local" : [ "../test_src" ],
}
