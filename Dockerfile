From ubuntu:18.04
RUN apt-get update && apt-get -y install git wget autoconf automake libtool curl make g++ unzip cmake python3 python3-dev python3-sip-dev

RUN wget https://github.com/google/protobuf/releases/download/v3.10.0/protobuf-all-3.10.0.zip

RUN git clone https://github.com/Ultimaker/libArcus.git
RUN git clone https://github.com/Ultimaker/CuraEngine.git

# install protobuf
RUN unzip protobuf-all-3.10.0.zip
WORKDIR "/protobuf-3.10.0"
RUN ./autogen.sh && ./configure && make && make install && ldconfig

# install libArcus
WORKDIR "/libArcus"
RUN git checkout 4.5.0
RUN mkdir build && cd build && cmake .. && make && make install

# install curaengine
WORKDIR "/CuraEngine"
RUN git checkout 4.5.0
RUN mkdir build && cd build && cmake .. && make
