include { HISTOQC } from "../modules/histoqc.nf"

workflow RUN {
    
    take:
    images

    main:
    def configInput = params.custom_config && file(params.custom_config).exists() ? file(params.custom_config) : params.config
    HISTOQC ( images, configInput ) 

    emit:
    output = HISTOQC.out.masks
    results = HISTOQC.out.results
    errors = HISTOQC.out.errors
}