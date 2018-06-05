open myfile,$ARGV[0];
print "Chr\tStart\tEnd\tTotalPositionsInWindow\tCallablePositions\n";
$start=1;
$window=100000;
while (<myfile>) {
	chomp $_;
	if($_ =~ /^chr/) {
		@sline = split("\t",$_);
		if($sline[1] <= $window) {
			push(@snplines,$_);
		}
		else {
			$snpCount=0;
			$asize = scalar (@snplines);
			for ($i=0;$i<=$#snplines;$i++) {
				chomp $snplines[$i];
				@s_snplines = split("\t",$snplines[$i]);
				if ($s_snplines[7] =~ /DP=(\d*)/) {
                        		$dep = $1;
                		}
				if($s_snplines[$#s_snplines] =~/0\/0/) {
					$mg=1;
				}
                		else {
					$mg=0;
				}
				for($j=9;$j<=$#s_snplines;$j++) {
					if($s_snplines[$j] =~/(\d\/\d)/) {
						$count++;
					}
				}
				if ($s_snplines[5] > 30  && $dep > 150 && $mg==1 && $count>=2) {
					$snpCount++;
				}	
			}
			print "$sline[0]\t$start\t$window\t$asize\t$snpCount\n";
			$start += 100000;
			$window += 100000;
			$count=0;$snpCount=0;@snplines=();
		}
	}
}
