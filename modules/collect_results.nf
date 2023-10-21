process COLLECT {

    publishDir "${params.outDir}", mode: 'copy'
    container 'debian:trixie'

    input:
    path results, stageAs: "?/*"

    output:
    path 'results.tsv'

    script:

    """
    cp ${results[0]} results.tsv
    for tsv in ${results}; do
         if [[ \$tsv != ${results[0]} ]]; then
              awk NF \$tsv | tail -n +7 >> results.tsv
         fi
    done
    """
}