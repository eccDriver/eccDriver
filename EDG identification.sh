#!/bin/bash

input_file_a="transcript/enhancer information.bed"
input_file_b="eccDNA information.bed"
output_file="eccDNA_contained_transcript/enhancer.bed"

bedtools intersect -a "$input_file_a" -b "$input_file_b" -f 1.0 | \
sort -u > "$output_file"
