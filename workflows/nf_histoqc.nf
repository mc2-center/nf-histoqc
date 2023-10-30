include { SPLIT } from '../subworkflows/samplesheet_split.nf'
include { RUN } from '../subworkflows/run_histoqc.nf'
include { COLLECT } from '../subworkflows/collect_results.nf'

workflow NF_HISTOQC {
    SPLIT   ( params.input )
    RUN     ( SPLIT.out.images )
    COLLECT ( RUN.out.results, RUN.out.errors  )
}