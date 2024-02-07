#!/usr/bin/env nextflow

nextflow.enable.dsl=2

if (params.input) { params.input = file(params.input) } else { exit 1, 'Input samplesheet not specified!' }

params.convert = false

if (params.convert) {
    if (!params.mag || !params.mpp) {
        error "Both nominal magnification ('mag') and microns per pixel ('mpp' parameters must be provided when 'params.convert' is set to true."
    }
}

if ( params.custom_config ) {
    if (! file(params.custom_config).exists() ) { error "Custom config file does not exist" }
    if (! file(params.custom_config).getName().endsWith(".ini") ) { error "Custom config file is not a .ini file" }
}

// Set parameters and defaults
params.outDir = './outputs'
params.config = 'default'
params.custom_config = false


include { NF_HISTOQC } from './workflows/nf_histoqc.nf'
// include { COMBINE_RESULTS } from './modules/combine_results.nf'

workflow {
    NF_HISTOQC ()
}
