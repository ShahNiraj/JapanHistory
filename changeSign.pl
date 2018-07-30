## This script changes sign of the the distance between the snp and the TSS according to the present of snp.  If snp is present on the 5' end, the sign is negative and vice versa for 3' end.
cmd: perl changeSign.pl r1.txt > r1.mod.txt
open myfile,$ARGV[0];

while (<myfile>) {
        chomp $_;
        if($_ =~ /^chr/) {
                @spltline = split("\t",$_);
                if($spltline[3] eq '-')  {
                        print "$spltline[0]\t$spltline[1]\t$spltline[2]\t-\t$spltline[4]\t-$spltline[5]\n"
                }
                elsif($spltline[3] eq '+') {
                        print "$spltline[0]\t$spltline[1]\t$spltline[2]\t+\t$spltline[4]\t$spltline[5]\n"
                }
        }
        else {
                print "$_\n";
        }
}
