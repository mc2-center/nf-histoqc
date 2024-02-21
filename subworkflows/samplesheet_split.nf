workflow SPLIT {
    take:
    samplesheet

    main:
    Channel
        .fromPath(samplesheet)
        .splitCsv(header: true, sep: ',')
        .buffer(size: 1)
        .map { row -> 
            def meta = [:]
            

            // Ensure correct file handling and size calculation
            def imageFile = file(row.image[0])

            meta.id = row.id[0] ?: imageFile.simpleName
            def fileSizeBytes = imageFile.size() // Get file size in bytes

            // Calculate memory allocation based on file size in Bytes
            meta.memory = calculateMemoryAllocation(fileSizeBytes)

            return [meta,imageFile]
        }
        .set { images }

        images.view()

    emit: 
    images
}

// Adjusted function to directly take fileSizeBytes
def calculateMemoryAllocation(double fileSizeBytes) {
    // Placeholder for your memory calculation logic
    // This example directly uses fileSizeGB
    def memoryGB = Math.ceil(Math.exp((0.497 * Math.log(fileSizeBytes) - 8.74)) + (2 * 0.39))
    return memoryGB < 2 ? 2 : memoryGB  // Ensuring a minimum of 6 GB
}
