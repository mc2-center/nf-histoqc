include { COLLECT } from "../modules/collect_results.nf"
include { TIDY } from "../modules/tidy_results.nf"
include { COLLECT_LOGS } from "../modules/collect_logs.nf"


workflow COLLECT_RESULTS {
    take:
    results
    errors
    main:
    
    COLLECT ( results.collect() )
    TIDY ( COLLECT.out) 
    COLLECT_LOGS ( errors.collect() )

}