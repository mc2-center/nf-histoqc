process COLLECT_LOGS {

    publishDir "${params.outDir}", mode: 'copy'
    container 'ubuntu:jammy'

    input:
    path errors, stageAs: "?/*"

    output:
    path 'errors.log'

    script:

    """
    for e in ${errors}; do
          awk NF \$e | tail -n +7 >> errors.log
    done
    """
}