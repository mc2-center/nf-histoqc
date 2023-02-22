#!/usr/bin/env nextflow

// Set parameters and defaults
params.in = '/Users/ataylor/Documents/GitHub/amazon-comprehend-medical-image-deidentification/images/CMU-1-Small-Region.svs'
params.outDir = './outputs'
params.config = 'default'

// Set an input channel
input_ch = Channel.fromPath(params.in)


process HISTOQC {

    container 'kaczmarj/histoqc:latest'

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
    HISTOQC(input_ch)
}