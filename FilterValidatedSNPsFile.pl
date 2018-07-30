## This script removes the genotypes which are i) not homozygous ii) non-polymorphic iii) missing genotypes
## Format of input file: <snpid><MG20Genotype><GifuGenotype> 
## cmd to run this script : perl FilterValidatedSNPsFile.pl <inputfilename> > <outputfilename>

open myfile,$ARGV[0];
while(<myfile>) {
	chomp $_;
	@sl = split("\t",$_);
	if($sl[1] ne $sl[2]) {
	#	print "$_\n";
	}
	@s2 = split("",$sl[1]);
	@s3 = split("",$sl[2]);
	if($sl[1] ne $sl[2] && ($s2[0] eq $s2[1] && $s3[0] eq $s3[1]) && ($sl[1] ne '--' && $sl[2] ne '--')) {
		print "$sl[0]\t$sl[1]\t$sl[2]\n"
	}
	else {
		#print "$sl[0]\t$sl[1]\t$sl[2]\n"
	}
}
