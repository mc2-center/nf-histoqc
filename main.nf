#!/usr/bin/env nextflow

// Set parameters and defaults
params.in = '/Users/ataylor/Documents/projects/htan/histoqc-test/14000001.svs'
params.outDir = './outputs'
params.config = 'default'

// Set an input channel
input_ch = Channel.of(params.in)


process HISTOQC {

    container 'kaczmarj/histoqc:latest'

    publishDir "${params.outDir}", mode: 'copy'

    input:
    path x
    val config

    output:
    path 'histoqc_output_*'


    // Need to set permissions for the non-root docker user 
    // See https://github.com/InformaticsMatters/pipelines/issues/22
    beforeScript 'chmod g+w .'

    """
    python -m histoqc $x -c $config
    """
}

workflow {
    HISTOQC(input_ch)
}