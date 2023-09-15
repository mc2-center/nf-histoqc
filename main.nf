#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Set parameters and defaults
params.in = '/Users/ataylor/Documents/GitHub/amazon-comprehend-medical-image-deidentification/images/CMU-1-Small-Region.svs'
params.outDir = './outputs'
params.config = 'default'

include { HISTOQC } from './modules/histoqc.nf'

workflow {
    input_ch = Channel.fromPath(params.in)
    HISTOQC(input_ch)
}
