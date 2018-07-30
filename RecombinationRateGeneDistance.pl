## This script finds the closest TSS for every SNP.
cmd : perl RecombinationRateGeneDistance.pl chr1.rho.txt 20131001_Lj30_longestProt.gff3 > r1.txt
open file1,$ARGV[0]; ## recombination rate file
open file2,$ARGV[1]; ## GFF file

while(<file2>) {
	chomp $_;
	@spltline=split("\t",$_);
	if($spltline[0] eq 'chr1' && $spltline[2] eq 'exon') {
		push(@gffArr,$_);
	}
}

@recombFile=<file1>;
print "Chrom\tPos\tGene\tOrient\tRho\tDistFromGene\n";
for($i=1;$i<=$#recombFile;$i++) {
	chomp $recombFile[$i];
	@spltline=split("\t",$recombFile[$i]);
	if($spltline[0] eq 'chr1') {
		for($j=0;$j<=$#gffArr;$j++) {
			chomp $gffArr[$j];
			@spltgff=split("\t",$gffArr[$j]);
			@spltInf=split(";",$spltgff[8]);
			@spltID=split("=",$spltInf[0]);
			$dist=$spltgff[3] - $spltline[1];
			if($dist >= 0) {
				$id="$spltline[0]\t$spltline[1]\t$spltID[1]\t-\t$spltline[4]";
				$hashDist{$id}=$dist;
			}
			else {
				$absDist=abs($dist);
				$id="$spltline[0]\t$spltline[1]\t$spltID[1]\t+\t$spltline[4]";
				$hashDist{$id}=$absDist;
			}
		}
	}
	$counter=0;
	foreach $name(sort {$hashDist{$a} <=> $hashDist{$b}} keys %hashDist) {
		$counter++;
		if($counter==1) {
			print "$name\t$hashDist{$name}\n";
			#push(@arr,"$name\t$hashDist{$name}");
		}	
	}
	%hashDist=();
}

