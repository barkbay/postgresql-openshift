FROM centos/s2i-core-centos7

# PostgreSQL image for OpenShift.
# Volumes:
#  * /var/lib/psql/data   - Database cluster for PostgreSQL
# Environment:
#  * $POSTGRESQL_USER     - Database user name
#  * $POSTGRESQL_PASSWORD - User's password
#  * $POSTGRESQL_DATABASE - Name of the database to create
#  * $POSTGRESQL_ADMIN_PASSWORD (Optional) - Password for the 'postgres'
#                           PostgreSQL administrative account

ENV POSTGRESQL_VERSION=10 \
    POSTGRESQL_PREV_VERSION=9.6 \
    HOME=/var/lib/pgsql \
    PGUSER=postgres \
    APP_DATA=/opt/app-root

ENV SUMMARY="PostgreSQL is an advanced Object-Relational database management system" \
    DESCRIPTION="PostgreSQL is an advanced Object-Relational database management system (DBMS). \
The image contains the client and server programs that you'll need to \
create, run, maintain and access a PostgreSQL DBMS server."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="PostgreSQL 10" \
      io.openshift.expose-services="5432:postgresql" \
      io.openshift.tags="database,postgresql,postgresql10" \
      name="d1g1tal/postgresql-10-centos7" \
      version="1" \
      usage="docker run -d --name postgresql_database -e POSTGRESQL_USER=user -e POSTGRESQL_PASSWORD=pass -e POSTGRESQL_DATABASE=db -p 5432:5432 d1g1tal/postgresql-10-centos7" \
      maintainer="The Digital Oops team <digital_ops@xnamtx.fr>"

EXPOSE 5432

COPY root/usr/libexec/fix-permissions /usr/libexec/fix-permissions

RUN curl -o /tmp/pgdg.rpm https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-2.noarch.rpm && \
    rpm -Uvh /tmp/pgdg.rpm && rm /tmp/pgdg.rpm && \
    yum -y install epel-release && \
    yum -y --setopt=tsflags=nodocs install rsync tar gettext bind-utils nss_wrapper postgresql10.x86_64 postgresql10-server.x86_64 postgresql10-contrib.x86_64 && \
    mkdir -p /var/lib/pgsql/data && \
    /usr/libexec/fix-permissions /var/lib/pgsql && \
    /usr/libexec/fix-permissions /var/run/postgresql && \
    yum clean all

ENV CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/postgresql
COPY root /

VOLUME ["/var/lib/pgsql/data"]

# {APP_DATA} needs to be accessed by postgres user while s2i assembling
# postgres user changes permissions of files in APP_DATA during assembling
RUN /usr/libexec/fix-permissions ${APP_DATA} && \
    usermod -a -G root postgres

USER 26

ENTRYPOINT ["container-entrypoint"]
CMD ["run-postgresql"]
