#!/usr/bin/perl -w

$flag = 0;
$lab = $ARGV[0];

open (F, qq(wget -q -O- "www.cse.unsw.edu.au/~cs2041/14s2/exam/seating.html"|)) or die;
while ($line = <F>) {
    if ($line =~ /\-\-\>/) {
        $flag = 1;
    } elsif ($line =~ /\<\/pre\>/) {
        last;
    } elsif ($flag == 1) {
        chomp $line;
        push(@students, $line);
    }
}
close F;

foreach $arg (@students) {
    if ($arg =~ /$lab\d{2}/) {
        $arg =~ s/([a-zA-Z0-9]+)\s.*/$1/;
        #print "$arg\n";
        $student = `finger $arg`;
        @names = split(/\n/, $student);
        print "$names[2]\n";
    }
}
