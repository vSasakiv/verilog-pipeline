FROM raetro/quartus:base as install

# Intel CDN URL
ARG INTEL_CDN="https://downloads.intel.com/akdlm/software/acdsinst"

# Add Quartus installation files
ADD ${INTEL_CDN}/20.1std.1/720/ib_installers/cyclonev-20.1.1.720.qdz              .
ADD ${INTEL_CDN}/20.1std.1/720/ib_installers/QuartusLiteSetup-20.1.1.720-linux.run  .

# Fix file permissions
RUN chmod a+x QuartusLiteSetup-20.1.1.720-linux.run                                                        && \
    ./QuartusLiteSetup-20.1.1.720-linux.run --mode unattended --accept_eula 1 --installdir /opt/intelFPGA  && \
    rm -rf /opt/intelFPGA/uninstall/

RUN echo "DOCKER BUILD SUCCESS"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
