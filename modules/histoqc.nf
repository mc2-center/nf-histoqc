process HISTOQC {
    
    tag {"$meta.id"}

    container 'ghcr.io/mc2-center/nf-histoqc:latest'
    
    publishDir "${params.outDir}/$images", mode: 'copy', pattern: "*.png"

    input:
    tuple val(meta), path(images)
    val configInput

    output:
    path "out/results.tsv", emit: results
    path "out/error.log", emit: errors
    path "*.png", emit: masks
    
    script:
    // Check if configInput is a file or a string
    def configFile = file(configInput).getName().endsWith('.ini')? file(configInput) : params.config

    """
    echo "Using config: $configFile"
    python -m histoqc -c $configFile $images -o out
    mv out/$images/*.png .
    """
}