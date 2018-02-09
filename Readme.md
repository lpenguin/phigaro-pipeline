# Phigaro pipeline
Snakemake pipeline for [phigaro](https://github.com/lpenguin/phigaro) tool for predicting phages.

## Dependicies
* Python >= 3
* Snakemake
* [phigaro](https://github.com/lpenguin/phigaro) and its dependices

## Workflow
* create directory for for new run: `mkdir my-phigaro-project`
* `cd` to it: `cd my-phigaro-project`
* copy pipeline files to project directory: `cp <phigaro-pipeline-dir>/* .`
* edit `config.yml` parameters
* edit `phigaro.config.yml` parameters: 
  * set `genemark.bin` and `genemark.mod_path` paths
  * set `hmmer.bin` and `hmmer.pvog_path` paths
* create data directory: `mkdir data/contigs`
* put fasta files to it, use symbolic links to save space
* Run snakemake
  * if running locally:
  ```bash
  snakemake  -k -p -j 4 phigaro # where <-j 30> is number of cores
  ```
  * if running on cluster:
  ```bash
  snakemake --drmaa-log-dir drmaa_logs --drmaa ' -pe make {threads}'  -k -p --latency-wait 120 -j 30 phigaro# where <-j 30> is number of cores
  ```
