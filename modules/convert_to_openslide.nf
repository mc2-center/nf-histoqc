process CONVERT {

    container 'ghcr.io/mc2-center/histoqc-openslide-converter:latest'

    input:
    tuple val(meta), path(images)

    output:
    tuple val(meta), path("${images.simpleName}_openslide.tiff")

    script:

    """
    vips im_vips2tiff $images ${images.simpleName}_openslide.tiff:jpeg:75,tile:512x512,pyramid
    tifftools set -y -s ImageDescription  "Aperio nf-histoqc |AppMag = $params.mag|MPP = $params.mpp" ${images.simpleName}_openslide.tiff
    """
}