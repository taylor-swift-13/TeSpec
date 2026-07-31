ARG QCP_BASE_IMAGE=qcp:offline-20260729-amd64
FROM ${QCP_BASE_IMAGE}

ARG TESPEC_VERSION=0.3.0
ARG BUILD_DATE=unknown
ARG MAKE_JOBS=4

LABEL org.opencontainers.image.title="TeSpec"
LABEL org.opencontainers.image.description="Offline concrete specification testing for QCP-annotated C"
LABEL org.opencontainers.image.version="${TESPEC_VERSION}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"

USER root

ENV TESPEC_ROOT=/opt/tespec
ENV PYTHONPATH=/opt/tespec
ENV PATH=/home/coq/.opam/4.14.2+flambda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /opt/tespec

COPY --chown=coq:coq pyproject.toml README.md ./
COPY --chown=coq:coq spectest ./spectest
COPY --chown=coq:coq bin ./bin
COPY --chown=coq:coq runtime ./runtime
COPY --chown=coq:coq cases ./cases
COPY --chown=coq:coq skills ./skills
COPY --chown=coq:coq docs ./docs
COPY --chown=coq:coq scripts ./scripts
COPY --chown=coq:coq tests ./tests
COPY --chown=coq:coq docker ./docker

RUN set -eux; \
    printf 'COQBIN=/home/coq/.opam/4.14.2+flambda/bin/\nSUF=\n' > /opt/tespec/runtime/qcip/SeparationLogic/CONFIGURE; \
    printf 'COQBIN=/home/coq/.opam/4.14.2+flambda/bin/\nSUF=\n' > /opt/tespec/runtime/qcip/SeparationLogic/unifysl/CONFIGURE; \
    cd /opt/tespec/runtime/qcip/SeparationLogic/unifysl; \
    make clean; \
    make depend; \
    make -j"${MAKE_JOBS}"; \
    cd /opt/tespec/runtime/qcip/SeparationLogic; \
    make clean-core; \
    make depend-core; \
    cp .depend.core .depend; \
    make -j"${MAKE_JOBS}" core; \
    make _CoqProject; \
    chmod 0755 \
      /opt/tespec/bin/qcp-symexec \
      /opt/tespec/scripts/check-runtime.sh \
      /opt/tespec/docker/entrypoint.sh \
      /opt/tespec/docker/offline-selftest.sh \
      /opt/tespec/skills/tespec-e2e/scripts/run_mutation_matrix.py \
      /opt/tespec/skills/tespec-artifacts/scripts/manage_artifacts.py \
    ; \
    install -m 0755 /opt/tespec/docker/entrypoint.sh /usr/local/bin/tespec; \
    ln -s /usr/local/bin/tespec /usr/local/bin/qcp-spectest; \
    mkdir -p /work; \
    chown coq:coq /work

USER coq
WORKDIR /work

ENTRYPOINT ["/usr/local/bin/tespec"]
CMD ["--help"]
