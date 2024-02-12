#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Set parameters and defaults

// Check if the input samplesheet is provided
if (params.input) { params.input = file(params.input) } else { exit 1, 'Input samplesheet not specified!' }

// Check requirements for the convert param to be used
params.convert = false
if (params.convert) {
    if (!params.mag || !params.mpp) {
        error "Both nominal magnification ('mag') and microns per pixel ('mpp' parameters must be provided when 'params.convert' is set to true."
    }
}

// Check requirements for the custom_config param to be used
params.custom_config = null
if ( params.custom_config ) {
    if (! file(params.custom_config).exists() ) { error "Custom config file does not exist" }
    if (! file(params.custom_config).getName().endsWith(".ini") ) { error "Custom config file is not a .ini file" }
}

// Set default outdir and config
params.outDir = './outputs'
params.config = 'default'

// Import workflow
include { NF_HISTOQC } from './workflows/nf_histoqc.nf'


// Run workflow
workflow {
    NF_HISTOQC ()
}
