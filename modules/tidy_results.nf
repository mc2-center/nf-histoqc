process TIDY {

    publishDir "${params.outDir}", mode: 'copy'
    container 'quay.io/biocontainers/pandas'

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
    import csv

    # Helper function to extract metadata
    def extract_metadata(row):
        line = '\t'.join(row)
        key, sep, value = line.partition(":")
        return key.strip('#'), (value.strip() if sep else '')

    # Updated function to read and correct TSV files
    def read_and_correct_tsv(file_path):
        metadata = {}
        corrected_rows = []
        
        with open(file_path, 'r') as f:
            tsv_reader = csv.reader(f, delimiter='\t')
            for i, row in enumerate(tsv_reader):
                if i < 5:  # Extract metadata
                    key, value = extract_metadata(row)
                    metadata[key] = value
                    continue
                if i == 5:  # Capture column names
                    column_names = row
                    continue
                
                # Correct the alignment by merging extra columns into the last column
                corrected_row = row[:len(column_names) - 1] + ['\t'.join(row[len(column_names) - 1:])]
                corrected_rows.append(corrected_row)

        # Create DataFrame and add metadata columns
        df_corrected = pd.DataFrame(corrected_rows, columns=column_names)
        for key, value in metadata.items():
            if key in ['config_file','pipeline']:
                df_corrected[key] = value
        
        # Rename the '#dataset:filename' column to 'filename'
        df_corrected.rename(columns={'#dataset:filename': 'filename'}, inplace=True)
        
        return df_corrected

    # Read and correct the results file
    df_tidy = read_and_correct_tsv("$results")

    # Display the first row of each corrected DataFrame
    df_tidy.to_csv('results_tidy.csv', index=False)

    """
}