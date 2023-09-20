process COLLECT {

    container 'alpine:latest'

    publishDir "./outputs", mode: 'copy', overwrite: true

    input:
    path results, stageAs: "?/*"

    output:
    path 'merged_results.tsv'

    script:

    """
    cp ${results[0]} merged_results.tsv
    for tsv in ${results}; do
         if [[ \$tsv != ${results[0]} ]]; then
              awk NF \$tsv | tail -n +7 >> merged_results.tsv
         fi
    done
    """
}