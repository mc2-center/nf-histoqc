process HISTOQC {
    
    tag {"$meta.id"}

    container 'ghcr.io/mc2-center/nf-histoqc:latest'
    
    publishDir "${params.outDir}/${meta.group && params.group ? "${meta.group}/" : ''}$images", mode: 'copy', pattern: "out/**/*.png", saveAs: { filename ->
        // Extracts the filename with its extension, discarding the path
        return new File(filename).getName()
    }
    input:
    tuple val(meta), path(images)
    val config_string
    path custom_config

    output:
    path "out/results.tsv", emit: results
    path "out/error.log", emit: errors
    path "out/$images/*.png", emit: masks
    
    script:
    """
    # Add the logic for the if config_string or custom_config here
    # Check if custom_config points to "empty.txt"
    if [[ "$custom_config" == *empty.txt ]]; then
        # If yes, use the config_string
        ini="$config_string"
    else
        # If no, use the path to custom_config
        ini=$custom_config
    fi

    echo "Using config: \$ini"
    python -m histoqc $images -o out -c \$ini

    #  Append meta.group to the last non-empty line if used
    if [ ! -z "${params.group}" ] && [ ! -z "${meta.group}" ]; then
        # Find the last non-empty line and append meta.group, considering there's only one empty line at the end
        awk 'NF{last=NR} {lines[NR]=\$0} END{for (i=1; i<=last; i++) if(i==last) print "${meta.group}/" lines[i]; else print lines[i]; if(NR>last) print ""}' out/results.tsv > out/tmp.tsv && mv out/tmp.tsv out/results.tsv
    fi
    """
}