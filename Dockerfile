FROM microsoft/mssql-server-linux

ENV ACCEPT_EULA Y
ENV SA_PASSWORD Password1
RUN mkdir /docker-entrypoint-initdb.d
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/opt/mssql/bin/sqlservr"]
