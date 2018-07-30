## Script to convert shapeit output to ldhat input
## cmd : perl vcfToLdHat_chr2.pl Accnames.txt chr2.Lj.recomb.t.vcf.haps chr2.sites.txt

open head,$ARGV[0]; ## input the head of a vcf file
open vcf,$ARGV[1]; ## input the ouput of shapeit

while(<head>) {
	chomp $_;
        @splthead=split("\t",$_);
	@newHead="$splthead[0]\t$splthead[1]\t$splthead[2]\t$splthead[3]\t$splthead[4]";
	for($i=9;$i<=$#splthead;$i++) {
		if($i < $#splthead) {
			push(@newHead,"\t$splthead[$i]\t$splthead[$i]_h2");
		}
		else {
			push(@newHead,"\t$splthead[$i]\t$splthead[$i]_h2");
		}
	}
}
$joinHead=join("",@newHead);
chomp $joinHead;
open (lo,">chr1.locs.txt");
print "192\t82683\t1\n";
print lo "82683\t62285.374\tL\n";
while(<vcf>) {
	chomp $_;
		@spltVCF=split(" ",$_);
		$locs=$spltVCF[2]/1000;
		print lo "$locs\n";
		for($i=5;$i<=$#spltVCF;$i++) {
                     	if($spltVCF[$i] == 0) {
        	                $ldhatSeq[$i] .= $spltVCF[3];
                        }
                        elsif($spltVCF[$i] == 1) {
                                $ldhatSeq[$i] .= $spltVCF[4];
                        }
		}
}
@spltnewHead=split("\t",$joinHead);
for($j=5;$j<=$#spltVCF;$j++) {
	#@spltnewHead=split("\t",@newHead);
	print ">$spltnewHead[$j]\n$ldhatSeq[$j]\n";
	#print ">$spltnewHead[$j]\n";
}
