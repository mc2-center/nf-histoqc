#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Set parameters and defaults
params.in = '/Users/ataylor/Documents/GitHub/amazon-comprehend-medical-image-deidentification/images/CMU-1-Small-Region.svs'
params.outDir = './outputs'
params.config = 'default'

process HISTOQC {

    container 'adamjtaylor/histoqc:latest'

    publishDir "${params.outDir}", mode: 'copy'

    input:
    path images

    output:
    path 'histoqc_output_*'

    // Need to set permissions for the non-root docker user 
    // See https://github.com/InformaticsMatters/pipelines/issues/22
    beforeScript 'chmod g+w .'
    
    script:
    // 'default' is not a named config so we use conditional 
    // scripts to skip the config variable if it should be default
    if (params.config == 'default')
        """
        python -m histoqc $images
        """
    else
        """
        python -m histoqc -c $params.config $images
        """
}

workflow {
    input_ch = Channel.fromPath(params.in)
    HISTOQC(input_ch)
}
