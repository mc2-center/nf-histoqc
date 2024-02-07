process HISTOQC {
    
    tag {"$meta.id"}

    container 'ghcr.io/mc2-center/nf-histoqc:latest'
    
    publishDir "${params.outDir}/$images", mode: 'copy', pattern: "*.png"

    input:
    tuple val(meta), path(images)
    val ini

    output:
    path "out/results.tsv", emit: results
    path "out/error.log", emit: errors
    path "*.png", emit: masks
    
    script:
    """
    echo "Using config: $ini"
    python -m histoqc -c $ini $images -o out
    mv out/$images/*.png .
    """
}