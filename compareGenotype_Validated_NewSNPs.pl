## This script compares the genotype of the validated snps and the discovered snps
## Format of input file: <snpid><chr><%identity><start><end><MG20><Gifu><position><chr><position><ref><alt><qual><info><Gifu><MG20>


#LjNSNP3008      chr5    100     9269878 9269678 AA      GG      9269778 chr5    9269778 T       C       22381.94        AC=256;AF=0.992;AN=258;BaseQRankSum=-0.133;DP=784;Dels=0.00;FS=6.285;HaplotypeScore=0.1327;InbreedingCoeff=0.0542;MLEAC=256;MLEAF=0.992;MQ=59.79;MQ0=0;MQRankSum=-0.903;QD=29.57;ReadPosRankSum=1.347   1/1:0,54:54:99:1646,162,0       0/0:27,0:27:81:0,81,916

@at=('A','T'); @gc=('G','C');
open myfile,$ARGV[0];
while(<myfile>) {
	chomp $_;
	@sline = split("\t",$_);
	$flag_rf_gc =0;$flag_ge_gc=0;$flag_al_at=0;$flag_geal_at=0;$flag_rf_at =0;$flag_ge_at=0;$flag_al_gc=0;$flag_geal_gc=0;$f1=0;$f2=0;$f3=0;$f4=0;
	@gifu_1=split("",$sline[6]); ## splits the genotype of validated snps
        @mg_1=split("",$sline[5]);
              
	@sgifu = split(/\:/,$sline[14]); ## splits the discovered snps
	@smg = split(/\:/,$sline[15]);

	if($sgifu[0] eq '0/0') { ## assigs the ref or alt allele
		$gifu = $sline[10];
	}
	elsif($sgifu[0] eq '1/1') {
		$gifu = $sline[11];
	}

	if($smg[0] eq '0/0') {
                $mg = $sline[10];
        }
        elsif($smg[0] eq '1/1') {
                $mg = $sline[11];
        }
	#if($gifu_1[0] eq $gifu_1[1] && $mg_1[0] eq $mg_1[1] && $gifu_1[0] ne $mg_1[0]) {
	if($gifu_1[0] eq $gifu_1[1] && $mg_1[0] eq $mg_1[1] && $sgifu[0] ne './.' && $smg[0] ne './.' ) { ## this section compares the genotype and its complementary genotype
		#if($mg_1[0] ne $gifu_1[0]) {
			#print "$_\n";
			foreach $v(@at) {
				if($mg eq $v) {	
					$flag_rf_at=1;
				}
				if($mg_1[0] eq $v) {
					$flag_ge_at=1;
				}
				if($gifu eq $v) {
                                        $flag_al_at=1;
                                }
                                if($gifu_1[0] eq $v) {
                                        $flag_geal_at=1;
                                }
			}
			foreach $vt(@gc) {
                                if($mg eq $vt) {
                                        $flag_rf_gc=1;
                                }
                                if($mg_1[0] eq $vt) {
                                        $flag_ge_gc=1;
                                }
                        	if($gifu eq $vt) {
                                        $flag_al_gc=1;
                                }
                                if($gifu_1[0] eq $vt) {
                                        $flag_geal_gc=1;
                                }
			}
		#}
	}
	if($flag_rf_gc == 1 && $flag_ge_gc==1) {
		$f1=1;
	}
	if($flag_rf_at == 1 && $flag_ge_at == 1) {
		$f2=1;
	}
	if($flag_al_at == 1 && $flag_geal_at == 1) {
		$f3=1;
	}
	if($flag_al_gc == 1 && $flag_geal_gc == 1) {
		$f4=1;
	}
	if(($f1==1 && $f3==1) ||  ($f1==1 && $f4==1) || ($f2==1 && $f3==1) || ($f2==1 && $f4==1)) {
		print "$_\n";
	}
	else {
		print "--$_\n";
	}
}

