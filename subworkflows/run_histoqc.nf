include { HISTOQC } from "../modules/histoqc.nf"
include { CONVERT } from "../modules/convert_to_openslide.nf"

workflow RUN {
    
    take:
    images

    main:
    def configInput = params.custom_config && file(params.custom_config).exists() ? file(params.custom_config) : params.config
    params.convert ? CONVERT(images) | HISTOQC : HISTOQC(images)

    emit:
    output = HISTOQC.out.masks
    results = HISTOQC.out.results
    errors = HISTOQC.out.errors
}