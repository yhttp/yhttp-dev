import re

from os.path import join, dirname
from setuptools import setup


# reading package version (same way the sqlalchemy does)
with open(join(dirname(__file__), 'yhttp_devutils', '__init__.py')) as v_file:
    package_version = re.compile('.*__version__ = \'(.*?)\'', re.S).\
        match(v_file.read()).group(1)


dependencies = [
    'yhttp',
    'yhttp-dbmanager >= 3',
]


setup(
    name='yhttp_devutils',
    version=package_version,
    packages=['yhttp_devutils'],
    install_requires=dependencies,
    url='https://github.com/yhttp/yhttp-devutils',
    author='pylover',
    author_email='vahid.mardani@gmail.com',
)
