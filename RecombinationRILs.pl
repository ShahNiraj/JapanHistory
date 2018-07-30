## script to obtain no of break points in 100kb window from a genetic map.  This script works for chr1. For different chromosomes use different chromosome sizes.
## cmd : perl RecombinationRILs.pl Mg20-Gifu-gm.txt > chr1.bp.100kb.txt

open myfile,$ARGV[0];
@file=<myfile>;
$size = 100000;
$incre=$size;
print "CHROM\tPos\tArrSize\tBreakPoints\n";
$sizeArr=0;
$breakpoint=0;
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
			$breakpoint += $splttmpArr[2];
		}
		print "$spltfile[0]\t",$i+$incre,"\t$sizeArr\t$breakpoint\n";
		$breakpoint=0;$tmpArr=();$sizeArr=0;
	}
	elsif($sizeArr == 0) {
		print "$spltfile[0]\t",$i+$incre,"\t$sizeArr\t$breakpoint\n";
		$breakpoint=0;@tmpArr=();$sizeArr=0;
	}
	$sizeArr=0;$tmpArr=();
}
##chr1  62275000
##chr2  43210000
##chr3  45611000
##chr4  42334000
##chr5  34189000
##chr6  26882000

##chr1	61818000
##chr2	42256000
##chr3	45385000
##chr4	41808000
##chr5	34002200
##chr6	26483500
