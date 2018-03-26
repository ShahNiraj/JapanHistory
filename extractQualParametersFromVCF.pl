## Script to extract quality parameters from the vcf file in tabular format
## Quality parameter extracted: Quality, Depth, HaplotypeScore, InbreedingCoefficient
## Run command : perl {perl script} {vcf file name} > {output file name}
open myfile,$ARGV[0]; ## Insert the vcf file
print "Chr\tPos\tRef\tAlt\tQual\tDepth\tHaplotypeScore\tInbreedingCoeff\n";
while (<myfile>) {
    chomp $_;
    if ($_ =~ /^#/) {
    
    }
    else {
        @sline = split("\t",$_);
        print "$sline[0]\t$sline[1]\t$sline[3]\t$sline[4]\t$sline[5]\t";  ## extracts quality
        if ($sline[7] =~ /DP=([.\d]*)/) {  ## extract depth
            print "$1\t",
        }
        else {
            print "-\t";
        }

        if ($sline[7] =~ /HaplotypeScore=([.\d-]*)/) {  ## extract haplotypeScore
                        print "$1\t";
        }
        else {
            print "-\t";
        }
        if ($sline[7] =~ /InbreedingCoeff=([.\d-]*)/) { ## extract inbreedingCoefficient
            print "$1\t";
        }
        else {
                        print "-\t";
                }
        print "\n";
    }
}
