## This script changes the format of default format of recombination rate. It adds two columns to the input file
## cmd : perl changeFormat.pl chr1_rho_0summary.txt > chr1.rho.txt

$file = $ARGV[0];
@spltfile = split("_",$file);
open myfile,$file;
$count=0;
while(<myfile>) {
	chomp $_;
	$count++;

	if($count == 1) {
		print "chr\tposition\t$_\n";
	}
	else {
		@spltline = split("\t",$_);
		$pos= $spltline[0] * 1000;
		print "$spltfile[0]\t$pos\t$_\n";
	}
}
