include { RESULTS } from "../modules/collect_results.nf"
include { TIDY } from "../modules/tidy_results.nf"
include { LOGS } from "../modules/collect_logs.nf"


workflow COLLECT {
    take:
    results
    errors
    main:
    
    // RESULTS ( results.collect() )
    // TIDY ( RESULTS.out) 
    //LOGS ( errors.collect() )

    results
        | collectFile(keepHeader: true, skip: 6, name: 'results.tsv', storeDir: params.outDir)
        | TIDY

     errors
        | collectFile(name: 'errors.log', storeDir: params.outDir)
        
}