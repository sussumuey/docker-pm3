import os

header = """\
[buildout]
extends = base.cfg
"""
configuration = ""
extra_buildout_configuration = ""

list_type = ["eggs", "extra-paths", "relative-paths"]
conf_type = ['zeo-log-custom', 'zeo-conf-additional']

for variable in os.environ:
    if "BUILDOUT_" not in variable:
        continue
    tag = variable[9:].lower().replace('_', '-')
    if tag in list_type:
        configuration += "%s =\n" % tag
        for value in os.environ[variable].strip('"\'').split():
            configuration += "\t%s\n" % value
    elif tag in conf_type:
        configuration += "%s =\n" % tag
        for value in os.environ[variable].strip('"\'').split('\\n'):
            configuration += "\t%s\n" % value
    else:
        configuration += "%s = %s\n" % (tag, os.environ[variable].strip('"\''))

if "INDEX" in os.environ:
    extra_buildout_configuration += "index =\n"
    for value in os.environ["INDEX"].strip('"\'').split():
        extra_buildout_configuration += "\t%s\n" % value

if "FIND_LINKS" in os.environ:
    extra_buildout_configuration += "find-links =\n"
    for value in os.environ["FIND_LINKS"].strip('"\'').split():
        extra_buildout_configuration += "\t%s\n" % value

if extra_buildout_configuration:
    header += extra_buildout_configuration

if configuration:
    header += """
[zeoserver]
"""

if extra_buildout_configuration or configuration:
    buildout = open("/opt/zeoserver/buildout.cfg", "w")
    print >> buildout, header + configuration,
