memory_controller_with_ECC IP Verification
Project Directory Structure
+-- MEM_ctrl_AXI
¦   +-- rggen_files
+-- tb_verification
¦   +-- uvme
¦   ¦   +-- apb_agent
¦   ¦   +-- test_class
¦   ¦   +-- env
¦   ¦   +-- sequences
¦   ¦   +-- wr_agent
¦   ¦   +-- top
¦   ¦   +-- package
¦   +-- SIM
+-- rtl_design

Setup Instructions for New Users
Step-by-step with Comments
1. Source the project environment
# First, source the environment setup file
source cshrc_rbcadence2
2. Navigate to the project and simulation directories
# Then go to the main project directory
cd memory_controller_with_ECC

# Then go to the simulation directory
cd verification/uvme/
3. Run a reset build (no simulation)
# Clean all previous builds and reset simulation environment
4. Compile and simulate manually using irun
# Manual irun command for full compile and simulation
xrun -clean -access +rwc -f compile.f -uvmhome CDNS-1.1d  +UVM_TESTNAME=single_bit_error_injection_test
5. Open waveform using SimVision
# Launch waveform viewer
simvision wave.shm
Coverage and Regression Commands
6. Run full regression
# Run regression using test list
perl memory_controller_with_ECC_regression.pl test_list.f 1
7. Merge coverage data using IMC
# Merge coverage files post regression
imc -exec ./cov_files/cov_merge.cmd
8. Open IMC for viewing coverage
# Launch coverage GUI in background
imc &
? Verification Summary

UVM Infrastructure: Includes monitor, scoreboard, and functional checker.
Coverage Results
Type	Result
Functional	100%
Code        88.27%
Bugs Found	3
