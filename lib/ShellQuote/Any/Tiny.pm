package ShellQuote::Any::Tiny;

# DATE
# VERSION

use strict;
#use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(shell_quote);
our $OS;

sub shell_quote {
    my $arg = shift;

    my $os = $OS || $^O;

    if ($os eq 'MSWin32') {
        if ($arg =~ /\A\w+\z/) {
            return $arg;
        }
        $arg =~ s/\\(?=\\*(?:"|$))/\\\\/g;
        $arg =~ s/"/\\"/g;
        return qq("$arg");
    } else {
        if ($arg =~ /\A\w+\z/) {
            return $arg;
        }
        $arg =~ s/'/'"'"'/g;
        return "'$arg'";
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


=head1 FUNCTIONS

=head2 shell_quote($str) => str


=head1 SEE ALSO

L<String::ShellQuote> for Unix shells

L<Win32::ShellQuote> for Windows shells

L<PERLANCAR::ShellQuote::Any>
