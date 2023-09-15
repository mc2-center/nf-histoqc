process HISTOQC {

    container 'ghcr.io/adamjtaylor/nf-histoqc:sha-d7ee80c'

    publishDir "${params.outDir}", mode: 'copy'

    input:
    path images

    output:
    path 'histoqc_output_*'

    // Need to set permissions for the non-root docker user 
    // See https://github.com/InformaticsMatters/pipelines/issues/22
    beforeScript 'chmod g+w .'
    
    script:
    // 'default' is not a named config so we use conditional 
    // scripts to skip the config variable if it should be default
    if (params.config == 'default')
        """
        python -m histoqc $images
        """
    else
        """
        python -m histoqc -c $params.config $images
        """
}