### This script will do the PCA analysis using software xx on SNPs in the vcf format
## 
open myfile,$ARGV[0];  ## Enter the vcf file

## Three output files with the following names are generated that will be used
## to run pca
open (geno,">3_Lj.eigenstrat.geno.txt");
open (snp,">3_Lj.eigenstrat.snp.txt");
open (ind,">3_Lj.eigenstrat.ind.txt");


while(<myfile>) {
	chomp $_;
    if($_ =~/^#CHROM/) {
    	@splthead=split("\t",$_);
        for($i=9;$i<=$#splthead;$i++) {
        	chomp $splthead[$i];
            print ind "$splthead[$i]\tU\tLjJap\n";
        }
    }
    elsif($_ !~ /^chr0/){
    	@spltline=split("\t",$_);
    	$snpName="$spltline[0]$spltline[1]";
        print snp "$snpName\t";
        if($spltline[0] eq 'chr1') {
        	print snp "1\t";
        }
        elsif($spltline[0] eq 'chr2') {
        	print snp "2\t";
        }
        elsif($spltline[0] eq 'chr3') {
        	print snp "3\t";
        }
    	elsif($spltline[0] eq 'chr4') {
        	print snp "4\t";
        }
        elsif($spltline[0] eq 'chr5') {
    		print snp "5\t";
        }
        elsif($spltline[0] eq 'chr6') {
        	print snp "6\t";
        }
        print snp "0.0\t$spltline[1]\t$spltline[3]\t$spltline[4]\n";
        for($i=9;$i<=$#spltline;$i++) {
        	chomp $spltline[$i];
        	if($i==$#spltline) {
            	if($spltline[$i] =~ /(0\/0).*/) {
                	print geno "2\n";
                }
                elsif($spltline[$i] =~ /(0\/1).*/) {
                	print geno "1\n";
                }
                elsif($spltline[$i] =~ /(1\/1).*/) {
                	print geno "0\n";
                }
                elsif($spltline[$i] =~ /(\.\/\.).*/) {
                	print geno "9\n";
                }
            }
            else {
            	if($spltline[$i] =~ /(0\/0).*/) {
                	print geno "2";
                }
                elsif($spltline[$i] =~ /(0\/1).*/) {
                	print geno "1";
                }
                elsif($spltline[$i] =~ /(1\/1).*/) {
                	print geno "0";
                }
                elsif($spltline[$i] =~ /(\.\/\.).*/) {
                	print geno "9";
                }
            }
    	}
    }
}



