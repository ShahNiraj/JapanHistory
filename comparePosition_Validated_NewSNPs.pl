## This script compares the position of the experimentally validates snps and the discovered snps.
## File1 needed: the vcf file
## File2 needed: the experimentally validated snps. Format of File2(tab seperated columns): <snpid><chr><%identity><startposition><endposition><MG20><Gifu><SNP position>
## command to run this script: perl comparePosition_Validated_NewSNPs.pl <VCFfile> <validatedSNPs> > <outputfilename>

open vcffile,$ARGV[0]; ## VCF file 
open vsnp,$ARGV[1]; ## the validated snp file

## this statement creates a hash of chromosomeid  and its its position 
while(<vcffile>)  {
	chomp $_;
	if($_ =~ /^#CHROM/) {
		@shead = split("\t",$_);
#		print "$shead[0]\t$shead[1]\t$shead[3]\t$shead[4]\t$shead[9]\t$shead[145]\n";
	}
	elsif($_ =~/^chr/) {
		@sline = split("\t",$_);
	#	print "$sline[0]\t$sline[1]\t$sline[3]\t$sline[4]\t$sline[9]\t$sline[145]\n";
		$hvcf{"$sline[0]\t$sline[1]"}="$sline[0]\t$sline[1]\t$sline[3]\t$sline[4]\t$sline[5]\t$sline[7]\t$sline[9]\t$sline[145]";
	}
}

## this statement creates a hash of chromosome id and its position
while(<vsnp>) {
	chomp$_;
	if($_ =~ /^Lj/) {
		@ssnp = split("\t",$_);
		$hsnp{"$ssnp[1]\t$ssnp[7]"}=$_;
	}
}

## this statement prints the common id from both the files.
foreach $key(keys %hsnp) {
	chomp $key;
	if(exists $hvcf{$key}) {
		print "$hsnp{$key}\t$hvcf{$key}\n";
	}
	
}
