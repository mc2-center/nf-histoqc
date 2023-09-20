process HISTOQC {
    
    publishDir "${params.outDir}/$images", mode: 'copy', pattern: "*.png"

    input:
    tuple val(meta), path(images)

    output:
    path "${images.simpleName}_out/results.tsv", emit: results
    path "${images.simpleName}_out/error.log", emit: errors
    path "*.png", emit: masks

    // Need to set permissions for the non-root docker user 
    // See https://github.com/InformaticsMatters/pipelines/issues/22
    beforeScript 'chmod g+w .'
    
    script:
    // 'default' is not a named config so we use conditional 
    // scripts to skip the config variable if it should be default
    if (params.config == 'default')
        """
        python -m histoqc $images -o ${images.simpleName}_out
        mv ${images.simpleName}_out/$images/*.png .
        """
    else
        """
        python -m histoqc -c $params.config $images -o ${images.simpleName}_out
        mv ${images.simpleName}_out/$images/*.png .
        """
}