include { COLLECT } from "../modules/collect_results.nf"
include { TIDY } from "../modules/tidy_results.nf"

workflow COLLECT_RESULTS {
    take:
    results
    main:
    
    COLLECT ( results.collect() )
    TIDY ( COLLECT.out) 

}