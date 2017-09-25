FROM microsoft/mssql-server-linux

ENV ACCEPT_EULA Y
ENV SA_PASSWORD Password1

# Install command line tools
RUN apt-get update && apt-get install -y python-pip && apt-get autoclean && pip install mssql-scripter

RUN mkdir /docker-entrypoint-initdb.d
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/opt/mssql/bin/sqlservr"]
