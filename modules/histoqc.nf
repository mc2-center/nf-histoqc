process HISTOQC {

    container 'ghcr.io/mc2-center/nf-histoqc:latest'

    publishDir "${params.outDir}", mode: 'copy'

    input:
    tuple val(meta), path(images)

    output:
    path "${images.simpleName}_out/results.tsv", emit: results
    path "${images.simpleName}_out/error.log", emit: errors
    path "${images.simpleName}_out/**/*", emit: output

    // Need to set permissions for the non-root docker user 
    // See https://github.com/InformaticsMatters/pipelines/issues/22
    beforeScript 'chmod g+w .'
    
    script:
    // 'default' is not a named config so we use conditional 
    // scripts to skip the config variable if it should be default
    if (params.config == 'default')
        """
        python -m histoqc $images -o ${images.simpleName}_out
        """
    else
        """
        python -m histoqc -c $params.config $images -o ${images.simpleName}_out
        """
}