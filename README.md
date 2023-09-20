# 🍏🔬✅ `nf-histoqc`

A [NextFlow](https://nextflow.io) wrapper for [HistoQC](https://github.com/choosehappy/HistoQC)

### Local usage

```
nextflow run mc2-center/nf-histoqc \
  --input <path-to-samplesheet> \
  --outdir <path-to-output-directory> \
  --profile local
```

### Test usage

To test on `CMU-1-Small-Region.svs` (included in repo) and output to `./outputs`

```
nextflow run mc2-center/nf-histoqc -profile test
```