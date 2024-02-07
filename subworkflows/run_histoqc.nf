include { HISTOQC } from "../modules/histoqc.nf"
include { CONVERT } from "../modules/convert_to_openslide.nf"

workflow RUN {
    
    take:
    images

    main:

    def config_ch = params.custom_config ? file(params.custom_config) : params.config

    if (params.convert) {
        CONVERT( images ) 
        HISTOQC( CONVERT.out, config_ch )
    }
    else {
        HISTOQC ( images, config_ch )
    }

    emit:
    output = HISTOQC.out.masks
    results = HISTOQC.out.results
    errors = HISTOQC.out.errors
}