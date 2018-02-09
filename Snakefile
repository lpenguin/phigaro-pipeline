from os.path import exists

configfile: 'config.yml'

SAMPLES, EXT = glob_wildcards('data/contigs/{sample}.{ext}')
SAMPLES = list(set(SAMPLES))



def multiple_exts(template, *extensions):
    def wrapped_input(wildcards):
        for ext in extensions:
            p = template.format(**wildcards) + ext
            if exists(p):
                return p
        return p
    return wrapped_input


rule _phigaro:
    input: multiple_exts("data/contigs/{sample}", '.fasta', '.fna', '.fa')
    output: "data/phigaro/{sample}.phigaro_out"
    threads: min(20, config['phigaro.threads'])
    log: "log/phigaro/{sample}.log"
    shell:
        "{config[phigaro.bin]} \
        --no-cleanup \
        --verbose \
        -t {threads} \
        -c phigaro.config.yml \
        -f {input} \
        -o {output} \
        >{log} 2>&1 \
        "

rule phigaro:
    input: expand("data/phigaro/{sample}.phigaro_out", sample=SAMPLES)
