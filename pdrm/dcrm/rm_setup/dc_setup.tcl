source -echo -verbose ./rm_setup/common_setup.tcl
source -echo -verbose ./rm_setup/dc_setup_filenames.tcl

puts "RM-Info: Running script [info script]\n"

#################################################################################
# Design Compiler Reference Methodology Setup for Top-Down MCMM Flow
# Script: dc_setup.tcl
# Version: P-2019.03-SP2 
# Copyright (C) 2007-2019 Synopsys, Inc. All rights reserved.
#################################################################################



#################################################################################
# Setup Variables
#
# Modify settings in this section to customize your Design Compiler Reference 
# Methodology run.
# Portions of dc_setup.tcl may be used by other tools so program name checks
# are performed where necessary.
#################################################################################

  # The following setting removes new variable info messages from the end of the log file
  set_app_var sh_new_variable_message false

if {$synopsys_program_name == "dc_shell" || $synopsys_program_name == "dcnxt_shell"}  {

  #################################################################################
  # Design Compiler Setup Variables
  #################################################################################

  # Use the set_host_options command to enable multicore optimization to improve runtime.
  # This feature has special usage and license requirements.  Refer to the 
  # "Support for Multicore Technology" section in the Design Compiler User Guide
  # for multicore usage guidelines.
  # Note: This is a DC Ultra feature and is not supported in DC Expert.

   set_host_options -max_cores 4

  if {[shell_is_dcnxt_shell]} {
  set_host_options -max_cores 8
  }


  # Change alib_library_analysis_path to point to a central cache of analyzed libraries
  # to save runtime and disk space.  The following setting only reflects the
  # default value and should be changed to a central location for best results.

  set_app_var alib_library_analysis_path .

  # Add any additional Design Compiler variables needed here

}

set RTL_SOURCE_FILES  "or1200.v"      ;# Enter the list of source RTL files if reading from RTL

# The following variables are used by scripts in the rm_dc_scripts folder to direct 
# the location of the output files.

set REPORTS_DIR "reports"
set RESULTS_DIR "results"

file mkdir ${REPORTS_DIR}
file mkdir ${RESULTS_DIR}

#set variable OPTIMIZATION_FLOW from following RM+ flows
#High Performance Low Power (hplp)
#High Connectivity (hc)
#Runtime Exploration (rtm_exp)

set OPTIMIZATION_FLOW  "" ;# Specify one flow out of hplp | hc | rtm_exp
#################################################################################
# Search Path Setup
#
# Set up the search path to find the libraries and design files.
#################################################################################

  set_app_var search_path ". ${ADDITIONAL_SEARCH_PATH} $search_path"

#################################################################################
# Library Setup
#
# This section is designed to work with the settings from common_setup.tcl
# without any additional modification.
#################################################################################

  # Milkyway variable settings

  # Make sure to define the Milkyway library variable
  # mw_design_library, it is needed by write_milkyway command

  set mw_reference_library ${MW_REFERENCE_LIB_DIRS}
  set mw_design_library ${DCRM_MW_LIBRARY_NAME}

  set mw_site_name_mapping { {CORE unit} {Core unit} {core unit} }

# The remainder of the setup below should only be performed in Design Compiler
if {$synopsys_program_name == "dc_shell" || $synopsys_program_name == "dcnxt_shell"}  {

  set_app_var target_library ${TARGET_LIBRARY_FILES}
  set_app_var synthetic_library dw_foundation.sldb

   if { $OPTIMIZATION_FLOW == "hplp" } {
  # Enabling the usage of DesignWare minPower Components requires additional DesignWare-LP license
  # set_app_var synthetic_library "dw_minpower.sldb  dw_foundation.sldb"
   }

  set_app_var link_library "* $target_library $ADDITIONAL_LINK_LIB_FILES $synthetic_library"

  # To apply the same min library to all scenarios for Multicorner-Multimode (MCMM), 
  # uncomment the following to use set_min_library here.  Otherwise specify the min library
  # with set_operating_conditions for each scenario in the ${DCRM_MCMM_SCENARIOS_SETUP_FILE}.

  # foreach {max_library min_library} $MIN_LIBRARY_FILES {
  #   set_min_library $max_library -min_version $min_library
  # }

  # Set the variable to use Verilog libraries for Test Design Rule Checking
  # (See dc.tcl for details)

  # set_app_var test_simulation_library <list of Verilog library files>

  if {[shell_is_in_topographical_mode]} {

    # To activate the extended layer mode to support 4095 layers uncomment the extend_mw_layers command 
    # before creating the Milkyway library. The extended layer mode is permanent and cannot be reverted 
    # back to the 255 layer mode once activated.

    # extend_mw_layers

    # Only create new Milkyway design library if it doesn't already exist
    if {![file isdirectory $mw_design_library ]} {
      create_mw_lib   -technology $TECH_FILE \
                      -mw_reference_library $mw_reference_library \
                      $mw_design_library
    } else {
      # If Milkyway design library already exists, ensure that it is consistent with specified Milkyway reference libraries
      set_mw_lib_reference $mw_design_library -mw_reference_library $mw_reference_library
    }

    open_mw_lib     $mw_design_library

    set_check_library_options -mcmm
    check_library > ${REPORTS_DIR}/${DCRM_CHECK_LIBRARY_REPORT}

    # For MCMM flow, do not set_tlu_plus_files here.  TLUPlus files should be
    # set up for each scenario in the ${DCRM_MCMM_SCENARIOS_SETUP_FILE}
  }

  #################################################################################
  # Library Modifications
  #
  # Apply library modifications after the libraries are loaded.
  #################################################################################

  if {[file exists [which ${LIBRARY_DONT_USE_FILE}]]} {
    puts "RM-Info: Sourcing script file [which ${LIBRARY_DONT_USE_FILE}]\n"
    source -echo -verbose ${LIBRARY_DONT_USE_FILE}
  }
    #set LIBRARY_DONT_USE_PRE_COMPILE_LIST  "./rm_dc_scripts/snpsll_hpdu_synth.tcl";# Tcl file for Synopsys Logic Library don't use list before first compile          
    set LIBRARY_DONT_USE_PRE_COMPILE_LIST  "";
}

puts "RM-Info: Completed script [info script]\n"

