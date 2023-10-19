process TIDY {

    publishDir "${params.outDir}", mode: 'copy'
    container 'pandas/pandas:alpine'

    input:
    path results

    output:
    path 'results_tidy.csv'

    stub:
    """
    touch results_tidy.csv
    """

    script:

    """
    #!/usr/bin/env python3

    import pandas as pd
    import sys

    df = pd.read_csv($results,delimiter="\t", skiprows=5, header=0)

    # Get existing column names
    df = df.copy()
    existing_columns = df.columns.tolist()

    # Shift column names by one position to the left
    new_columns = existing_columns[1:] + [None]

    # Assign the new column names to the DataFrame
    df.columns = new_columns
    df.drop('warnings',axis=1, inplace=True)
    df.rename(columns={None:"warnings"}, inplace=True)
    df.rename_axis('filename', inplace=True)
    df.reset_index(inplace=True)
    df.to_csv('results_clean.csv',index=False)
    """
}