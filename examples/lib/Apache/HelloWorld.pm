package Apache::HelloWorld;

#LoadModule perl_module modules/mod_perl.so
#PerlSwitches -Mlib=modperl-2.0/examples/lib

##optional
#PerlModule Apache2
#PerlModule Apache::compat

#<Location /hello-world>
#    SetHandler modperl
#    PerlResponseHandler Apache::HelloWorld
#</Location>

use strict;
use Apache::RequestRec (); #for $r->content_type
use Apache::RequestIO ();  #for $r->puts
use Apache::Const -compile => 'OK';

sub handler {
    my $r = shift;

    $r->content_type('text/plain');

    #send_http_header API function does not exist in 2.0

    $r->puts(__PACKAGE__); #print not yet implemented

    return Apache::OK;
}

1;