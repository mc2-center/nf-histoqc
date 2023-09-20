include { COLLECT } from "../modules/collect_results.nf"


workflow COLLECT_RESULTS {
    take:
    results
    main:
    
    COLLECT ( results.collect() )

}