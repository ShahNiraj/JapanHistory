## Calculate Genetic distance from a reduced VCF file, see the githup pipeline
## Input a vcf file
## Cmd  : perl GeneticDistanceCalcFromVCF.pl <input file name> > <output file name>

open myfile,$ARGV[0]; ## input reduced vcf file

@file = <myfile>;
for($i=0;$i<=$#file-1;$i++) {
	chomp $file[$i];
	@spltline= split("\t",$file[$i]);
	for($k=$i+1;$k<=$#file;$k++) {
		chomp $file[$k];
		@spltlineOne= split("\t",$file[$k]);
		$count=0;$comp=0;
		for($j=1;$j<=$#spltline;$j++) {  ## for each SNP position, calculates the number of reference and alt allele
			if($spltine[$j] eq './.' || $spltlineOne[$j] eq './.') {
				$count = $count + 0;
			}
			elsif($spltline[$j] eq $spltlineOne[$j]) { 
				$count = $count + 0;
				$comp++;
			}
			elsif ($spltline[$j] eq '0/0' && $spltlineOne[$j] eq '1/1' || $spltline[$j] eq '1/1' && $spltlineOne[$j] eq '0/0') {
                        	$count = $count+2;
                		$comp++;
			}
                	else {
                        	$count++;
                		$comp++;
			}
		}
		$score = $count/$comp;
		print "$spltline[0]\t$spltlineOne[0]\t$score\n"; ## prints number of alternate alleles between two accessions
	}
}




