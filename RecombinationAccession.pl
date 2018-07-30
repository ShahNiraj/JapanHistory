## This script find average recombination rate in 100kb window.
## cmd : perl RecombinationAccession.pl chr2.rho.txt > chr2.rho.100kb.forbp.txt
## Use different chromosome size for each chromosome.  The chromosome size is mentioned at the bottom of this script
open myfile,$ARGV[0];
@file=<myfile>;
$size = 100000;
$incre=$size;
print "CHROM\tPos\tArrSize\tAvgRho\n";
$sizeArr=0;
$rho=0;$avgRho=0;
for($i=0;$i<=62275000;$i+=$incre) {
	$sizeArr=0;@tmpArr=();
	for($j=1;$j<=$#file;$j++) {
		chomp $file[$j];
		@spltfile=split("\t",$file[$j]);
		if($spltfile[1] >= $i+1 && $spltfile[1] <=$i+$incre) {
			push(@tmpArr,$file[$j]);
		}
	}
	$sizeArr=scalar(@tmpArr);
	if($sizeArr >= 1) {
		for($k=0;$k<=$#tmpArr;$k++) {
			chomp $tmpArr[$k];
			@splttmpArr=split("\t",$tmpArr[$k]);
			$rho += $splttmpArr[4];
		}
		$avgRho =$rho/$sizeArr;
		print "$spltfile[0]\t",$i+$incre,"\t$sizeArr\t$avgRho\n";
		$breakpoint=0;$tmpArr=();$sizeArr=0;$rho=0;$avgRho=0;
	}
	elsif($sizeArr == 0) {
		print "$spltfile[0]\t",$i+$incre,"\t$sizeArr\t$avgRho\n";
		$breakpoint=0;@tmpArr=();$sizeArr=0;
	}
	$sizeArr=0;$tmpArr=();
}

##chr1	62275000
##chr2	43210000
##chr3	45611000
##chr4	42334000
##chr5	34189000
##chr6	26882000
