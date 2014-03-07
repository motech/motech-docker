FROM orchardup/mysql

ADD create_db_schema_quartz_v2.1.sql /tmp/create_db_schema_quartz_v2.1.sql
ADD run.sh /usr/local/bin/run.sh

RUN chmod a+x /usr/local/bin/run.sh

CMD ["/usr/local/bin/run.sh"]