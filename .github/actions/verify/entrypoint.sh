#!/bin/bash

touch project.tcl
echo "load_package flow" >> project.tcl
echo "project_new project -overwrite" >> project.tcl

INFILE=/github/workspace/project.config
PINFILE=/github/workspace/project.pin

while read -r LINE
do
        echo "set_global_assignment -name $LINE" >> project.tcl
done < "$INFILE"

VERILOG_LIST="$(find /github/workspace/hdl -name '*.v')"
for VERILOG_FILE in $VERILOG_LIST;
do echo "set_global_assignment -name VERILOG_FILE $VERILOG_FILE" >> project.tcl
done

TEXT_LIST="$(find /github/workspace/hdl -name '*.txt')"
for TEXT_FILE in $TEXT_LIST;
do echo "set_global_assignment -name TEXT_FILE $TEST_FILE" >> project.tcl
done

while read -r LINE
do
        MODULE_PIN=$(echo $LINE | cut -d'=' -f 1)
        BOARD_PIN=$(echo $LINE | cut -d'=' -f 2)
        echo "set_location_assignment $BOARD_PIN -to $MODULE_PIN" >> project.tcl
done < "$PINFILE"

echo "project_close" >> project.tcl

mkdir quartus_project
cd quartus_project

quartus_sh -t ../project.tcl
quartus_sh --flow compile project
quartus_sh --archive project
