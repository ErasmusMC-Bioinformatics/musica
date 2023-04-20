FROM mambaorg/micromamba:1.4.2

ARG MAMBA_DOCKERFILE_ACTIVATE=1

COPY --chown=$MAMBA_USER:$MAMBA_USER musica_env.yml /tmp/env.yaml

RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

RUN echo 'devtools::install_github("AnalytixWare/ShinySky")' | Rscript - && \
    echo 'webshot::install_phantomjs(force=TRUE)' | Rscript -  && \
    echo 'BiocManager::install("MutationalPatterns")' | Rscript - && \
    echo 'BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")' | Rscript - && \
    echo 'BiocManager::install("BSgenome.Hsapiens.1000genomes.hs37d5")' | Rscript -

RUN micromamba install -n base -c conda-forge r-v8 -y && \ 
    micromamba clean --all --yes

COPY --chown=$MAMBA_USER:$MAMBA_USER ./ /app
RUN chmod 777 /app/start.sh
WORKDIR /app
RUN Rscript --version
RUN Rscript --version

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "/app/start.sh"]