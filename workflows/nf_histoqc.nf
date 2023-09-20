include { SAMPLESHEET_SPLIT } from '../subworkflows/samplesheet_split.nf'
include { RUN_HISTOQC } from '../subworkflows/run_histoqc.nf'
include { COLLECT_RESULTS } from '../subworkflows/collect_results.nf'

workflow NF_HISTOQC {
    SAMPLESHEET_SPLIT   ( params.input )
    RUN_HISTOQC         ( SAMPLESHEET_SPLIT.out.images )
    COLLECT_RESULTS     ( RUN_HISTOQC.out.results )
}