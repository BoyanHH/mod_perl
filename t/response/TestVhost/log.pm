package TestVhost::log;

# testing that the warn and other logging functions are writing into
# the vhost error_log and not the main one.

use strict;
use warnings FATAL => 'all';

use Apache::RequestUtil ();
use Apache::Log ();
use Apache::ServerRec qw(warn); # override warn locally

use File::Spec::Functions qw(catfile);

use Apache::Test;
use Apache::TestUtil;
use TestCommon::LogDiff;

use Apache::Const -compile => 'OK';

my @methods1 = (
    '$r->log->warn',
    '$r->log_error',
    '$r->warn',
    '$s->log->warn',
    '$s->log_error',
    '$s->warn',
);

my @methods2 = (
    'Apache::ServerRec::warn',
    'warn',
);

my $path = catfile Apache::Test::vars('documentroot'),
    qw(vhost error_log);

sub handler {
    my $r = shift;

    plan $r, tests => 1 + @methods1 + @methods2;

    my $s = $r->server;
    my $logdiff = TestCommon::LogDiff->new($path);

    ### $r|$s logging
    for my $m (@methods1) {
        eval "$m(q[$m])";
        ok t_cmp $logdiff->diff, qr/\Q$m/, $m;
    }

    ### object-less logging
    # set Apache->request($r) instead of using
    #   PerlOptions +GlobalRequest
    # in order to make sure that the above tests work fine,
    # w/o having the global request set
    Apache->request($r);
    for my $m (@methods2) {
        eval "$m(q[$m])";
        ok t_cmp $logdiff->diff, qr/\Q$m/, $m;
    }

    # internal warnings (also needs +GlobalRequest)
    {
        no warnings; # avoid FATAL warnings
        use warnings;
        local $SIG{__WARN__} = \&Apache::ServerRec::warn;
        eval q[my $x = "aaa" + 1;];
        ok t_cmp
            $logdiff->diff,
            qr/Argument "aaa" isn't numeric in addition/,
            "internal warning";
    }

    # die logs into the vhost log just fine
    #die "horrible death!";

    Apache::OK;
}

1;
__END__
<NoAutoConfig>
<VirtualHost TestVhost::log>
    DocumentRoot @documentroot@/vhost
    ErrorLog @documentroot@/vhost/error_log

    <Location /TestVhost__log>
        SetHandler modperl
        PerlResponseHandler TestVhost::log
    </Location>

</VirtualHost>
</NoAutoConfig>