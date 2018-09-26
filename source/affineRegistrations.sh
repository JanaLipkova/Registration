#!/bin/bash

# ANTS Registration
#-----------------------
m_in="$1"
f_in="$2"
out_this="$3"

imgs="$f_in, $m_in"
dim=3

echo "Calculating affine registeration between:"
echo fixed:  ${f_in}
echo moving: ${m_in}

its=10000x1111x5

antsRegistration -d $dim -r [ $imgs ,1] \
                         -m mattes[  $imgs , 1 , 32, regular, 0.05 ] \
                         -t translation[ 0.1 ] \
                         -c [1000,1.e-8,20]  \
                         -s 4vox  \
                         -f 6 -l 1 \
                         -m mattes[  $imgs , 1 , 32, regular, 0.1 ] \
                         -t rigid[ 0.1 ] \
                         -c [1000x1000,1.e-8,20]  \
                         -s 4x2vox  \
                         -f 4x2 -l 1 \
                         -m mattes[  $imgs , 1 , 32, regular, 0.1 ] \
                         -t affine[ 0.1 ] \
                         -c [$its,1.e-8,20]  \
                         -s 4x2x1vox  \
                         -f 3x2x1 -l 1 \
                         -o ${out_this}


antsApplyTransforms -d $dim -i $m_in -r $f_in -t ${out_this}0GenericAffine.mat -o ${out_this} --float 1 
echo "Affine transformation computed and results is saved to:"
echo ${out_this}

