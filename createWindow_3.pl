## This script calculates the average rho and average distance from TSS in a window of 1000 markers.
## To Run this script: perl <perl Program> <input file>
## Format of the input file : Chrom\tPos\tGene\tOrient\tRho\tDistFromGene

use Math::Round;
use List::Util qw( min max );

open myfile,$ARGV[0]; ## enter the file. The file has the format 'Chrom\tPos\tGene\tOrient\tRho\tDistFromGene'
@rhoFile=<myfile>;  ## Stores entire file in an array.

$windowSize = 1000;
for($i=0;$i<=$#rhoFile;$i++) {
	chomp $rhoFile[$i];
	@spltline=split("\t",$rhoFile[$i]);
	$hashDist{$spltline[1]}=$spltline[5];  
	$hashRho{$spltline[1]}=$spltline[4];
}
print "Distance\tRho\n";
foreach $val(sort {$hashDist{$a} <=> $hashDist{$b}} keys %hashDist) {  ## sorts the distanace in ascending order and stores it in an array
	#print "$val\t$hashRho{$val}\t$hashDist{$val}\n";
	push(@arr,"$val\t$hashRho{$val}\t$hashDist{$val}")
}


$counter=0;
for($l=0;$l<=$#arr;$l++) {  ## this part does analysis in the window
	chomp $arr[$l];
	@spltarr=split("\t",$arr[$l]);
	$counter++;
	if($counter <= $windowSize) {
		$RhoCount += $spltarr[1];  ##cumulative rho value in a window
		$distCount += $spltarr[2]; ## cumulative distance in a window
	}
	else{
		$avgRho=$RhoCount /$windowSize;  ## averages and prints values of each window and then empties the current window and start filling a new window
		$avgdist=$distCount/$windowSize;
		$r_avgdist= round($avgdist);
		print "$r_avgdist\t$avgRho\n";
		$counter=0;$RhoCount=0;$distCount=0;$avgRho=0;$avgdist=0;$r_avgdist=0;
		$RhoCount += $spltarr[1];
		$distCount += $spltarr[2];
		$counter++;
	}
}
