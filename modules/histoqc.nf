process HISTOQC {
    
    tag {"$meta.id"}
    
    publishDir "${params.outDir}/$images", mode: 'copy', pattern: "*.png"

    input:
    tuple val(meta), path(images)

    output:
    path "out/results.tsv", emit: results
    path "out/error.log", emit: errors
    path "*.png", emit: masks

    // Need to set permissions for the non-root docker user 
    // See https://github.com/InformaticsMatters/pipelines/issues/22
    beforeScript 'chmod g+w .'
    
    script:
    """
    python -m histoqc -c ${params.config} $images -o out
    mv out/$images/*.png .
    """
}