FROM ubuntu/latest AS anaegel/cpack-tools

ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

# Install via apt (as root).
USER root
RUN apt-get update \
    && apt-get install -y cmake clang mingw-w64 \
    && apt-get clean 

# Install UG4
USER bob
ENV UG4_ROOT=$HOME/opt/ug4
ENV PATH=$PATH:${HOME}/ughub
COPY ../../bin/ug4-install-basic-with-pybind.sh build.sh
RUN bash build.sh
