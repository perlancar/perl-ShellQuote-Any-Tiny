package ShellQuote::Any::Tiny;

# DATE
# VERSION

use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(shell_quote);

sub shell_quote {
    my $arg = shift;

    if ($^O eq 'MSWin32') {
    } else {
        if ($arg =~ /\A\w+\z/) {
            return $arg;
        }
        $arg =~ s/\\/\\\\/g;
        $arg =~ s/'/'"'"'/g;
        "'$arg'";
    }
}

1;
# ABSTRACT: Escape string for the Unix/Windows shell

=head1 SYNOPSIS

 use ShellQuote::Any::Tiny qw(shell_quote);

 my $cmd = 'echo ' . shell_quote("hello world");

 # On Windows, $cmd becomes 'echo "hello world"'.
 # On Unix, $cmd becomes q(echo 'hello world').


=head1 DESCRIPTION

This module tries to quote command-line argument when passed to shell (either
Unix shells or Windows) using as little code as possible. For more proper
quoting, see See Also section.


=head1 SEE ALSO

L<String::ShellQuote> for Unix shells

L<Win32::ShellQuote> for Windows shells

L<PERLANCAR::ShellQuote::Any>
