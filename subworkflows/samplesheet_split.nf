workflow SPLIT {
    take:
    samplesheet
    main:
    Channel
        .fromPath(samplesheet)
        .splitCsv (header:true, sep:',' )
        // Make meta map from the samplesheet
        .map { 
            row -> 
            def meta = [:]
            if (row.id ) {
                meta.id = row.id
            } else {
                meta.id = file(row.image).simpleName
            }
            if (row.group && params.group) {
                meta.group = row.group
            }
            image = file(row.image)
            [meta, image]
        }
        .set {images }
        
    emit: 
    images
}