#!/usr/bin/perl
  use strict;
    use warnings;
my @tmpArr=();

      my $range = 29349833;
	my $minimum = 0;
	my $i=0;
	for($i=0;$i<=200000;$i++) {
		my $random_number = int(rand($range)) + $minimum;
		push(@tmpArr,$random_number);
	}
open myfile,$ARGV[0];

my @file = <myfile>;

for(my $j=0;$j<=$#tmpArr;$j++) {
	my $num = $tmpArr[$j];
	chomp $file[$num];
	print "$file[$num]\n";
	
}
#my $size = scalar(@tmpArr);
#print "$size\n";
