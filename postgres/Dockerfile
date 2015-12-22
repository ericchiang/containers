FROM scratch

ADD postgres_rootfs.tar /

ENV PG_MAJOR 9.4
ENV PG_VERSION 9.4.5

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PGDATA /var/lib/postgresql/data

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

COPY entrypoint.sh /
COPY run.sh /
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"] 
