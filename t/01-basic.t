#!perl

use strict;
use warnings;
use Test::More 0.98;

use ShellQuote::Any::Tiny qw(shell_quote);

test_echo(arg => '', result => '');
test_echo(arg => ' ', result => ' ');
test_echo(arg => 'hello', result => 'hello');
test_echo(arg => 'hello world', result => 'hello world');
test_echo(arg => 'a\\', result => 'a\\');
test_echo(arg => 'a\\\\', result => 'a\\\\');
test_echo(arg => "'", result => "'");
test_echo(arg => '"', result => '"');

done_testing;

sub test_echo {
    my %args = @_;

    subtest +($args{name} // $args{arg}) => sub {
        my $cmd = 'echo '.shell_quote($args{arg});
        my $result = `$cmd`;
        chomp($result);
        is($result, $args{result}, "result");
    };
}
