workflow COLLECT_RESULTS {
    take:
    results
    main:
    results
        .map { it -> it.readLines().collect { line -> line.trim() }.join('\n') }
        .collectFile(
            name: 'results.tsv', 
            newLine: true, 
            skip: 6,
            keepHeader: false,
            storeDir: params.outDir
        )
}