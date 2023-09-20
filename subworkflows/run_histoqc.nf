include { HISTOQC } from "../modules/histoqc.nf"

workflow RUN_HISTOQC {
    
    take:
    images

    main:
    HISTOQC ( images ) 

    emit:
    output = HISTOQC.out.output
    results = HISTOQC.out.results
}