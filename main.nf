#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Set parameters and defaults
params.in = 'test_data/*'
params.outDir = './outputs'
params.config = 'default'

include { HISTOQC } from './modules/histoqc.nf'
// include { COMBINE_RESULTS } from './modules/combine_results.nf'

workflow {
    input_ch = Channel.fromPath(params.in)
    HISTOQC(input_ch)
    HISTOQC
        .out
        .results
        .map { it -> it.readLines().collect { line -> line.trim() }.join('\n') }
        .collectFile(
            name: 'results.tsv', 
            newLine: true, 
            skip: 6,
            keepHeader: false,
            storeDir: params.outDir
        )

    HISTOQC
        .out
        .errors
        .collectFile(
            name: 'errors.log', 
            newLine: false, 
            storeDir: params.outDir
        )
}
