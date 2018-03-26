## Filter vcf file according to the MG020 genotype
## cmd : perl <perl script> <input vcf file>
## this script generates three file ref.vcf, het,vcf and alt.vcf with MG020 homozygous reference genotype, MG020 heterozygous genotype,
## and MG020 homozygous alternative genotype.
## the index position is 145 as MG020 is at that index. Index position starts with 0.
 
open myfile,$ARGV[0];

open(re,">ref.vcf");
open(het,">het.vcf");
open(alt,">alt.vcf");

while (<myfile>) {
        chomp $_;
        if ($_ =~ /^#/) {
                @shead = split(/\t/,$_);
                print re "$_\n";
                print het "$_\n";
                print alt "$_\n";
        }
        else {
                @ssnp = split(/\t/,$_);
                if ($ssnp[145] =~ /0\/0/) {
                        print re "$_\n";
                }
                elsif($ssnp[145] =~ /0\/1/) {
                        print  het  "$_\n";
                }
                elsif ($ssnp[145] =~ /1\/1/) {
                        print alt  "$_\n";
                } 
        }
}
