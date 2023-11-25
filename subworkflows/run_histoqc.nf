include { HISTOQC } from "../modules/histoqc.nf"
include { CONVERT } from "../modules/convert_to_openslide.nf"

workflow RUN {
    
    take:
    images

    main:

    ifparams.convert ? CONVERT(images) | HISTOQC : HISTOQC(images)

    emit:
    output = HISTOQC.out.masks
    results = HISTOQC.out.results
    errors = HISTOQC.out.errors
}