FROM ubuntu:latest AS cpack-tools-setup

ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"


ENV ARTIFACTS=/home/artifacts
ENV BASEDIR=/home/artifacts/base-${TARGETPLATFORM}
ENV CMAKE_BUILD_RPATH_USE_ORIGIN=TRUE

# Install via apt (as root).
USER root
RUN apt-get update 
RUN apt-get install -y git build-essential file \
   && apt-get install -y cmake clang liblapack-dev libblas-dev \
   && apt-get install -y git python3 libpython3-dev \
   && apt-get clean 

# Install UG4
# ENV UG4_ROOT=$HOME/opt/ug4
# ENV PATH=$PATH:${HOME}/ughub

FROM cpack-tools-setup AS cpack-tools-build
USER root
WORKDIR $ARTIFACTS
COPY bin/ug4-install-basic-with-pybind.sh $ARTIFACTS
RUN mkdir -p $BASEDIR
RUN bash ug4-install-basic-with-pybind.sh $BASEDIR clang++

FROM cpack-tools-build AS cpack-tools-pack
USER root
WORKDIR $BASEDIR
#RUN cmake -DCMAKE_BUILD_RPATH_USE_ORIGIN=TRUE ..
#RUN make
# RUN cpack -G DEB --verbose
