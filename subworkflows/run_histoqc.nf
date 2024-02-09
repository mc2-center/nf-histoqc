include { HISTOQC } from "../modules/histoqc.nf"
include { CONVERT } from "../modules/convert_to_openslide.nf"

workflow RUN {
    
    take:
    images

    main:

    def custom_config = params.custom_config ? Channel.fromPath(params.custom_config).first() : Channel.fromPath("assets/empty.txt").first() // need to pass a dummy file in the projectDir or similar

    // Scenario 1: Conversion and custom configuration
    if (params.convert ) {
        CONVERT(images)
        HISTOQC(CONVERT.out, params.config, custom_config)
    } 
    // Scenario 3: No conversion, but with custom configuration
    else {
        HISTOQC(images, params.config, custom_config)
    }

    emit:
    output = HISTOQC.out.masks
    results = HISTOQC.out.results
    errors = HISTOQC.out.errors
}