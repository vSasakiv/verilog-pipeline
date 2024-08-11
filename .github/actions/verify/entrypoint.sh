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

while read -r LINE
do
        MODULE_PIN=$(echo $LINE | cut -d'=' -f 1)
        BOARD_PIN=$(echo $LINE | cut -d'=' -f 2)
        echo "set_location_assignment $BOARD_PIN -to $MODULE_PIN" >> project.tcl
done < "$PINFILE"
