# vim:set ft= ts=4 sw=4 et:

use Test::Nginx::Socket::Lua;
use Cwd qw(cwd);

my $fname = "t/testfiles/mobilephone_willcom.t";
open DATA, "< $fname" or die "Cannot open $fname: $!\n";

repeat_each(1);

plan tests => repeat_each() * (3 * blocks());

my $pwd = cwd();

our $HttpConfig = qq{
    lua_package_path "$pwd/lib/?.lua;;";
};

$ENV{TEST_NGINX_RESOLVER} = '8.8.8.8';

no_long_string();
#no_diff();

run_tests();

