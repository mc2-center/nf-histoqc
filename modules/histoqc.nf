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
    // 'default' is not a named config so we use conditional 
    // scripts to skip the config variable if it should be default  
    def config_var = (params.config == 'default') ? "" : "-c $params.config" // Define config_var here
    """
    python -m histoqc ${config_var} $images -o out
    mv out/$images/*.png .
    """
}