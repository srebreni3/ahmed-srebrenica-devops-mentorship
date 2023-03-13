#!/bin/bash

#redirecting all output to a file
exec 1>testout

echo "this is a test of redirecting all output"
echo "from a script to another file."
echo "without havin to redirect every individual line"