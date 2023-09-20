#!/usr/bin/env nextflow

nextflow.enable.dsl=2

if (params.input) { params.input = file(params.input) } else { exit 1, 'Input samplesheet not specified!' }

// Set parameters and defaults
params.outDir = './outputs'
params.config = 'default'

include { NF_HISTOQC } from './workflows/nf_histoqc.nf'
// include { COMBINE_RESULTS } from './modules/combine_results.nf'

workflow {
    NF_HISTOQC ()
}
