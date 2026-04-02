import os
import datetime

import pytest


@pytest.fixture
def freshdb(cicd):
    """ Creates a fresh database for each test.

    Default configuration is using peer authentication method on
    Postgresql's Unix Domain Socket.
    """
    from yhttp.ext.dbmanager import PostgresqlManager

    host = os.environ.get('YHTTP_DB_DEFAULT_HOST', 'localhost' if cicd else '')
    user = os.environ.get('YHTTP_DB_DEFAULT_USER', 'postgres' if cicd else '')
    pass_ = os.environ.get('YHTTP_DB_DEFAULT_PASS', 'postgres' if cicd else '')

    dbname = f'freshdb_{datetime.datetime.now():%Y%m%d%H%M%S}'
    dbmanager = PostgresqlManager(host, 'postgres', user, pass_)
    dbmanager.create(dbname, dropifexists=True)
    freshurl = f'postgresql://{user}:{pass_}@{host}/{dbname}'
    yield freshurl
    dbmanager.dropifexists(dbname)
