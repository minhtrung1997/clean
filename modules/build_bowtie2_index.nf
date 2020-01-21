/*Comment section: */

process build_bowtie2_index {
  label 'bowtie2'
  if (params.cloudProcess) { 
    if (params.phix) {
      publishDir "${params.cloudDatabase}/hosts/${params.species}_phix", mode: 'copy', pattern: "*.bt2" 
    } else {
      publishDir "${params.cloudDatabase}/hosts/${params.species}", mode: 'copy', pattern: "*.bt2" 
    }
  }
  else { 
    if (params.phix) {
      storeDir "nextflow-autodownload-databases/hosts/${params.species}_phix" 
    } else {
      storeDir "nextflow-autodownload-databases/hosts/${params.species}" 
    }
  }  

  input:
    file(genome)

  output:
    file("*.bt2")

  script:
    """
    bowtie2-build ${genome} ${genome.simpleName}
    """
}
