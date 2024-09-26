
FROM	mambaorg/micromamba:1.5.9
ARG	MAMBA_DOCKERFILE_ACTIVATE=1
COPY	musica_env.yml	/tmp/env.yaml
RUN	micromamba install -y -n base -f /tmp/env.yaml \
	&& micromamba clean --all --yes
COPY	renv.lock	/app/renv.lock
COPY	./	/app
WORKDIR	/app
RUN	R -e 'renv::init(bare = TRUE)' \
	&& R -e 'renv::restore()'
RUN	chmod 777 /app/start.sh
RUN	Rscript --version
ENTRYPOINT	["/usr/local/bin/_entrypoint.sh","/app/start.sh"]
