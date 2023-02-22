#!/usr/bin/env nextflow

params.in = '/Users/ataylor/Documents/projects/htan/histoqc-test/14000001.svs'
input_ch = Channel.of(params.in)
params.outDir = './outputs'

process HISTOQC {

    container 'kaczmarj/histoqc:latest'

    publishDir "${params.outDir}", mode: 'copy'

    input:
    path x

    output:
    path 'histoqc_output_*'

    """
    python -m histoqc $x
    """
}

workflow {
    HISTOQC(input_ch)
}