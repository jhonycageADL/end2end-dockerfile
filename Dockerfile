FROM adoptopenjdk/openjdk8:alpine
ENV GRADLE_HOME=/opt/src/gradle \
   GRADLE_SHA256=7bdbad1e4f54f13c8a78abc00c26d44dd8709d4aedb704d913fb1bb78ac025dc \
   CHROME_BIN=/usr/bin/chromium-browser \
   CHROME_PATH=/usr/lib/chromium/
RUN apk update \
   && apk add --no-cache --update-cache git openssh chromium-chromedriver chromium \
   && mkdir -p /root/.ssh \
   && ssh-keyscan -H github.com >> /root/.ssh/known_hosts \
   && ssh-keyscan -H github.avaldigitallabs.com >> /root/.ssh/known_hosts \
   && wget -O gradle.zip “https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip” \
   && echo “${GRADLE_SHA256} *gradle.zip” | sha256sum -c - \
   && unzip gradle.zip \
   && rm -f gradle.zip \
   && mkdir -p /opt/src \
   && mv “gradle-${GRADLE_VERSION}” “${GRADLE_HOME}” \
   && ln -s “${GRADLE_HOME}/bin/gradle” /usr/bin/gradle \
   && gradle --version \
   && rm -rf /tmp/ /var/cache/apk/
