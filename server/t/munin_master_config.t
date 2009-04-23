use warnings;
use strict;

use Test::More tests => 2;

use_ok('Munin::Master::Config');


my $config = Munin::Master::Config->instance();


$config->parse_config(\*DATA);

is_deeply($config, {
    'config_file' => '../common/lib/Munin/Common/../../../t/config//munin.conf',
    'dbdir' => '/opt/munin/sandbox/var/opt/munin',
    'debug' => 0,
    'fork'  => 1,
    'graph_data_size' => 'normal',
    'groups_and_hosts' => {
        'marvin' => {
            'use_node_name' => 1,
            'address' => '127.0.0.1',
            'port' => '4948',
        },
    },
    'htmldir' => '/opt/munin/sandbox/www',
    'logdir' => '/opt/munin/sandbox/var/log/munin',
    'max_processes' => 2 ** 53,
    'rundir' => '/opt/munin/sandbox/var/run/munin',
    'tls' => 'disabled',
    'tls_ca_certificate' => '/opt/munin/common/t/tls/CA/ca_cert.pem',
    'tls_certificate' => '/opt/munin/common/t/tls/master_cert.pem',
    'tls_private_key' => '/opt/munin/common/t/tls/master_key.pem',
    'tls_verify_certificate' => 1,
    'tls_verify_depth' => '5',
    'tmpldir' => '/opt/munin/sandbox/etc/opt/munin/templates',
});

__DATA__

# Example configuration file for Munin, generated by 'make build'

# The next three variables specifies where the location of the RRD
# databases, the HTML output, and the logs, severally.  They all
# must be writable by the user running munin-cron.
dbdir	/opt/munin/sandbox/var/opt/munin
htmldir	/opt/munin/sandbox/www
logdir	/opt/munin/sandbox/var/log/munin
rundir  /opt/munin/sandbox/var/run/munin

# Where to look for the HTML templates
tmpldir	/opt/munin/sandbox/etc/opt/munin/templates

# Make graphs show values per minute instead of per second
#graph_period minute

# Graphics files are normaly generated by munin-graph, no matter if
# the graphs are used or not.  You can change this to
# on-demand-graphing by following the instructions in
# http://munin.projects.linpro.no/wiki/CgiHowto
#
#graph_strategy cgi

# Drop somejuser@fnord.comm and anotheruser@blibb.comm an email everytime
# something changes (OK -> WARNING, CRITICAL -> OK, etc)
#contact.someuser.command mail -s "Munin notification" somejuser@fnord.comm
#contact.anotheruser.command mail -s "Munin notification" anotheruser@blibb.comm
#
# For those with Nagios, the following might come in handy. In addition,
# the services must be defined in the Nagios server as well.
#contact.nagios.command /usr/bin/send_nsca nagios.host.comm -c /etc/nsca.conf

tls disabled
tls_private_key /opt/munin/common/t/tls/master_key.pem
tls_certificate /opt/munin/common/t/tls/master_cert.pem
tls_ca_certificate /opt/munin/common/t/tls/CA/ca_cert.pem
tls_verify_certificate yes
tls_verify_depth 5

# a simple host tree
[marvin]
    address 127.0.0.1
    port 4948
    use_node_name yes

# 
# A more complex example of a host tree
#
## First our "normal" host.
# [fii.foo.com]
#       address foo
#
## Then our other host...
# [fay.foo.com]
#       address fay
#
## Then we want totals...
# [foo.com;Totals] #Force it into the "foo.com"-domain...
#       update no   # Turn off data-fetching for this "host".
#
#   # The graph "load1". We want to see the loads of both machines... 
#   # "fii=fii.foo.com:load.load" means "label=machine:graph.field"
#       load1.graph_title Loads side by side
#       load1.graph_order fii=fii.foo.com:load.load fay=fay.foo.com:load.load
#
#   # The graph "load2". Now we want them stacked on top of each other.
#       load2.graph_title Loads on top of each other
#       load2.dummy_field.stack fii=fii.foo.com:load.load fay=fay.foo.com:load.load
#       load2.dummy_field.draw AREA # We want area instead the default LINE2.
#       load2.dummy_field.label dummy # This is needed. Silly, really.
#
#   # The graph "load3". Now we want them summarised into one field
#       load3.graph_title Loads summarised
#       load3.combined_loads.sum fii.foo.com:load.load fay.foo.com:load.load
#       load3.combined_loads.label Combined loads # Must be set, as this is
#                                                 # not a dummy field!
#
## ...and on a side note, I want them listen in another order (default is
## alphabetically)
#
# # Since [foo.com] would be interpreted as a host in the domain "com", we
# # specify that this is a domain by adding a semicolon.
# [foo.com;]
#       node_order Totals fii.foo.com fay.foo.com
#

