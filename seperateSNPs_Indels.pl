##run command : perl {perl script} <Input_vcf_file> 
## outputs two files i) snpfile ii) indel file

open myfile,$ARGV[0]; ## Enter the VCF file
open(snp,">snp.vcf”); ## output snp file name
open(indel,">indel.vcf”); ## output indel file name
while (<myfile>) {
    chomp $_;
    if ($_ =~ /^#/) {
        print snp "$_\n";
        print indel "$_\n";
    }
    else {
        @ssnp = split("\t",$_);
        @ref = split ("",$ssnp[3]);
        @alt = split("",$ssnp[4]);
        $lref = scalar(@ref);
        $lalt = scalar (@alt);

        if ($lref == 1 && $lalt == 1) {
            print snp  "$_\n";
        }
        else {
            print indel "$_\n";
        }
    }
}