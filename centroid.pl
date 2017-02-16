open myfile,$ARGV[0];

while(<myfile>) {
	chomp $_;
	if($_ !~ /^#Region/) {
		@spltline= split("\t",$_);
		$hash{$spltline[0]}=1;
		push(@data,$_);
	}
}

foreach $key(keys %hash) {
	push(@region,$key);
}
$pc1=0;$pc2=0;
for($i=0;$i<=$#region;$i++) {
	chomp $region[$i];
	for($j=0;$j<=$#data;$j++) {
		chomp $data[$j];
		@spltdata=split("\t",$data[$j]);
		if($region[$i] eq $spltdata[0]) {
			push(@tmp,$data[$j])
		}
	}
	for($k=0;$k<=$#tmp;$k++) {
		chomp $tmp[$k];
		#print "\n";
		@splttmp=split("\t",$tmp[$k]);
		$pc1 += $splttmp[4];
		$pc2 += $splttmp[5];
		$tmpRegion =  $splttmp[0];
	}
	$avg_pc1 = $pc1 / scalar (@tmp);
	$avg_pc2 = $pc2 / scalar (@tmp);
	$r_avg_pc1 = sprintf("%.4f",$avg_pc1);
	$r_avg_pc2 = sprintf("%.4f",$avg_pc2);
	for($l=0;$l<=$#tmp;$l++) {
                chomp $tmp[$l];
                if($l == $#tmp) {
			print "$r_avg_pc1\t$r_avg_pc2\t$tmp[$l]\n";
		}
		else {
			print "na\tna\t$tmp[$l]\n";
		}
        }
	@tmp=();$pc1=0;$pc2=0;
}
