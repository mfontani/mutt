#!/usr/bin/env perl
# Public Domain - fontani@gmail.com 20131121
use strict;
use warnings;

my $current_time   = '';
my $signature_made = '';
my $signature_id   = '';
my $signature_from = '';
my $untrusted      = '';
my $skip_next      = 0;

while (my $line = <STDIN>) {
    #print "XX: $line";
    chomp $line;

    if ($skip_next == 1 && $line =~ /^\s*$/) {
        $skip_next = 0;
        next;
    }

    if ($line =~ m!^(\e\]\d+;(?:\d+)?\D)\[-- PGP output follows \(current time: ([A-Z][a-z]{2} \s?\d\d? [A-Z][a-z]{2} \d{2}:\d{2}:\d{2} \d{4})\) --\]!) {
        my $ansi = $1;
        $current_time = $2;
        next;
    }
    if ($line =~ m!^(\e\]\d+;(?:\d+)?\D)\[-- End of PGP output --\]$!) {
        $skip_next = 1;
        next;
    }
    if ($current_time && $line =~ m!^gpg: Signature made ([A-Z][a-z]{2} \s?\d\d? [A-Z][a-z]{2} \d{2}:\d{2}:\d{2} \d{4} \w{3}) using [DR]SA key ID ([A-F0-9]+)$!) {
        $signature_made = $1;
        $signature_id   = $2;
        next;
    }
    if ($current_time && $line =~ m!^gpg: WARNING: This key is not certified with a trusted signature!) {
        $untrusted = 1;
        next;
    }
    if ($current_time && $line =~ m!^Primary key fingerprint:!) {
        next;
    }
    if ($current_time && $line =~ m!^\s*Subkey fingerprint:!) {
        next;
    }
    if ($current_time && $line =~ m!^gpg: Good signature from "(.*)"!) {
        $signature_from = $1;
        next;
    }
    if ($current_time && $line =~ m!^gpg:!) {
        next;
    }
    if ($line =~ m!^(\e\]\d+;(?:\d+)?\D)\[-- The following data is signed --\]!) {
        # not using $current_time but could
        $untrusted = $untrusted ? '(NOT TRUSTED)' : '';
        $line = "$1\[-- OK PGP $signature_made by $untrusted$signature_id ($signature_from) --]";
    }
    print "$line\n";
}
