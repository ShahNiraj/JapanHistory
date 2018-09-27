## Prints just the genotype called for each snp position in each accession.
## input the vcf file
## Cmd : briefInfoVCF.pl <input VCF file> > <output file name>

open myfile,$ARGV[0];

while (<myfile>) {
	chomp $_;
	if($_ =~ /^[MG]/) {
		@spltline = split("\t",$_);
		print "$spltline[0]\t";
		for ($i=1;$i<=$#spltline;$i++) {
			@spltGeno = split(":",$spltline[$i]);
			if($i == $#spltline) {
				print "$spltGeno[0]\n";
			}
			else {
				print "$spltGeno[0]\t";
			}
		}
	}
}

