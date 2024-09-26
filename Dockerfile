FROM mambaorg/micromamba:1.4.2

ARG MAMBA_DOCKERFILE_ACTIVATE=1

COPY --chown=$MAMBA_USER:$MAMBA_USER musica_new.yml /tmp/env.yaml

RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

COPY --chown=$MAMBA_USER:$MAMBA_USER renv.lock /app/renv.lock

COPY --chown=$MAMBA_USER:$MAMBA_USER ./ /app
WORKDIR /app

RUN R -e 'renv::init(bare = TRUE)' && \
    R -e 'renv::restore()'


RUN chmod 777 /app/start.sh
RUN Rscript --version

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "/app/start.sh"]
