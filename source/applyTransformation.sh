#!/bin/bash

# ANTS Registration
#-----------------------
m_in="$1"
f_in="$2"


imgs="$f_in, $m_in"
dim=3
out_this="$3"
transFile="$4"


antsApplyTransforms -d $dim -i $m_in -r $f_in -t ${transFile} -o ${out_this} --float 1 
echo "Applied transformation:" ${transFile} 
echo "between images:"
echo "fixed" $f_in
echo "moving" $m_in
echo "Results is saved to:"
echo ${out_this}
