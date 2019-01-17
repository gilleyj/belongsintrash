FROM alpine:3.8 as builder
WORKDIR /code
RUN apk --no-cache add git build-base automake autoconf curl-dev libressl-dev jansson-dev gmp-dev
RUN git clone --depth 1 https://github.com/JayDDee/cpuminer-opt .
RUN ./autogen.sh
RUN CFLAGS="-O3 -march=native -Wall" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl
RUN sed '/#include <stdlib.h>/a #include <endian.h>' /code/algo/hodl/sha512_avx2.c > /code/algo/hodl/sha512_avx2.c
RUN make

FROM alpine:3.8
ENV TIMEZONE=UTC \
    ENV=/etc/profile \
    APP_ENV=prod
RUN apk --no-cache add dumb-init tzdata ca-certificates libcurl jansson libgmpxx && \
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    update-ca-certificates && \
    mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh && \
    echo alias dir=\'ls -alh --color\' >> /etc/profile && \
    echo 'source ~/.profile' >> /etc/profile && \
    echo 'cat /etc/os-release' >> /etc/motd && \
    echo 'cat /etc/os-release' >> ~/.profile && \
    echo 'date' >> ~/.profile && \
    apk --no-cache del tzdata
WORKDIR /app
COPY --from=builder /code/cpuminer /app/cpuminer 
