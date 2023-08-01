FROM eclipse-temurin:17-jdk

LABEL org.opencontainers.image.vendor="Zax71"
LABEL org.opencontainers.image.title="Velocity"
LABEL org.opencontainers.image.description="Automatically built Docker image for Velocity with arm support"
LABEL org.opencontainers.image.documentation="https://github.com/Ender-Cube/velocity/blob/main/README.md"
LABEL org.opencontainers.image.authors="Chao Tzu-Hsien <danny900714@gmail.com> Zax71"
LABEL org.opencontainers.image.licenses="MIT"

ENV JAVA_MEMORY="512M"
ENV JAVA_FLAGS="-XX:+UseStringDeduplication -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch"

WORKDIR /data

RUN apk add --upgrade --no-cache openssl && \
    addgroup -S velocity && \
    adduser -S velocity -G velocity && \
    chown velocity:velocity /data

USER velocity

VOLUME /data

EXPOSE 25577

COPY --chown=velocity velocity/velocity-*.jar /opt/velocity/velocity.jar

ENTRYPOINT java -Xms$JAVA_MEMORY -Xmx$JAVA_MEMORY $JAVA_FLAGS -jar /opt/velocity/velocity.jar
