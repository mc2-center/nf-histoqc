include { HISTOQC } from "../modules/histoqc.nf"

workflow RUN {
    
    take:
    images

    main:
    HISTOQC ( images ) 

    emit:
    output = HISTOQC.out.masks
    results = HISTOQC.out.results
    errors = HISTOQC.out.errors
}