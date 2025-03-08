#!/bin/bash

input_file_a="eccDNA information.bed"
input_file_b="transcript/enhancer information.bed"
output_file="eccDNA_contained_transcript/enhancer.bed"

bedtools intersect -a "$input_file_a" -b "$input_file_b" -nonamecheck -wb | \
awk '$1==$4 && $2<=$5 && $3>=$6' | \
cut -f 4-6 | \
sort -u > "$output_file"
