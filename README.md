# `nf-histoqc`

A nextflow wrapper for HistoQC

### Local usage

```
nextflow run mc2-center/nf-histoqc --input <path-to-samplesheet> --outdir <path-to-output-directory> --profile local
```

### Test usage

To test on `CMU-1-Small-Region.svs` (included in repo) and output to `./outputs`

```
nextflow run mc2-center/nf-histoqc -profile test
```