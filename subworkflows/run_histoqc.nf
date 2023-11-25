include { HISTOQC } from "../modules/histoqc.nf"
include { CONVERT } from "../modules/convert_to_openslide.nf"

workflow RUN {
    
    take:
    images

    main:

    images | (params.convert ? CONVERT : it) | HISTOQC

    emit:
    output = HISTOQC.out.masks
    results = HISTOQC.out.results
    errors = HISTOQC.out.errors
}