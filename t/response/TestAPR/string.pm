package TestAPR::string;

use strict;
use warnings FATAL => 'all';

use Apache::Test;

use Apache::Const -compile => 'OK';

require TestAPRlib::string;

sub handler {
    my $r = shift;

    my $num_of_tests = TestAPRlib::string::num_of_tests();
    plan $r, tests => $num_of_tests;

    TestAPRlib::string::test();

    Apache::OK;
}

1;
__END__