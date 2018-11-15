open myfile,$ARGV[0];
while(<myfile>) {
	chomp $_;
	@spltline=split("\t",$_);
	if($_ =~ /^#CHROM/) {
		print "$spltline[0],$spltline[1],";
		for($i=9;$i<=$#spltline;$i++) {
			chomp $spltline[$i];
			if($i < $#spltline) {
				print "$spltline[$i],";
			}
			elsif($i == $#spltline) {
				print "$spltline[$i]\n";
			}
		}
	}
	elsif($_ =~ /^chr/)  {
		$spltline[0] =~ /chr(\d)/;
		print "$1,$spltline[1],";
		for($j=9;$j<=$#spltline;$j++) {
			chomp $spltline[$j];
			@spltdata=split(":",$spltline[$j]);
			if($j < $#spltline) {
				if($spltdata[0] eq '0|0') {
					print "0,";
				}
				elsif($spltdata[0] eq '1|1') {
					print "2,";
				}
				elsif($spltdata[0] eq '0|1') {
					print "1,";
				}
				elsif($spltdata[0] eq '1|0') {
					print "1,";
				}
				
				elsif($spltdata[0] eq '.|.') {
                                        print "NA,";
                                }
				else {
					print " ,";
				}
			}
			elsif($j == $#spltline) {
				if($spltdata[0] eq '0|0') {
                                        print "0\n";
                                }
                                elsif($spltdata[0] eq '1|1') {
                                        print "1\n";
                                }
                                elsif($spltdata[0] eq '.|.') {
					print "NA\n";
				}
				else {
                                        print " \n";
                                }
			}
		}
	}
}
close(myfile);

