FROM adoptopenjdk/openjdk8:alpine
ENV GRADLE_HOME=/opt/src/gradle \
   GRADLE_SHA256=7bdbad1e4f54f13c8a78abc00c26d44dd8709d4aedb704d913fb1bb78ac025dc \
   CHROME_BIN=/usr/bin/chromium-browser \
   CHROME_PATH=/usr/lib/chromium/
RUN apk update \
&& apk add --no-cache --update-cache git openssh chromium-chromedriver chromium \
&& wget -O gradle.zip https://services.gradle.org/distributions/gradle-5.4.1-bin.zip \
&& unzip gradle.zip \
&& rm -f gradle.zip \
&& mkdir -p /opt/src/gradle \
&& mv gradle-5.4.1/* /opt/src/gradle/ \
&& ln -s /opt/src/gradle/bin/gradle /usr/bin/gradle \
&& gradle --version \
&& rm -rf /tmp/ /var/cache/apk/ 

CMD ["gradle", "--version"]