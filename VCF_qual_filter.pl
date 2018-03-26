## Filter the VCF file using quality, depth, hap score, inbreeding coefficient
## Cmd to run script :  perl <perlscript> <Input VCF file> > <output VCF File>
## filteration threshold mentioned in the script

use POSIX qw(log10);
open myfile,$ARGV[0];
while (<myfile>) {
        chomp $_;
        if ($_ =~ /^#/) {
                print "$_\n";
        }
        else {
            	($flag_d,$flag_q,$flag_hs,$flag_ibs) = 0;
                @sline = split("\t",$_);
                $quality = $sline[5];
                if ($sline[7] =~ /DP=([.\d]*)/) {
                        $depth = $1;
                }
                if ($sline[7] =~ /HaplotypeScore=([.\d-]*)/) {
                        $haploScore = $1;
                }
                if ($sline[7] =~ /InbreedingCoeff=([.\d-]*)/) {
                        $inbreedScore = $1;
                }
                if ($quality > 30 && $depth > 150 && $haploScore < 0.3 && $inbreedScore > 0.1) {
                        print "$_\n";
                }
        }
}
