## Script to combine geographic distance and genetic distance between two accessions
## cmd : perl formpairsFromTwoFiles.pl <Geographic distance file> <Genetic distance file> > <output file>
## Format of Geographic distance file : Accession1	Latitude	Longitude	population	Accession2	lat	lon	population	geographic distance	 
## output file format : Accession1      Lat     Lon     Subpop  Accession2      Lat     Lon     Subpop  GeoDist(mts)    GeoDist GeneDist

open f1,$ARGV[0]; ## Geographic distance file
open f2,$ARGV[1]; ## Genetic distance file

while (<f1>) {
        chomp $_;
        @sf1 = split("\t",$_);
        $hf1{"$sf1[0]\t$sf1[4]"}=$_;
}

while (<f2>) {
        chomp $_;
        @sf2 = split("\t",$_);
        $hf2{"$sf2[0]\t$sf2[1]"}=$_;
}

foreach $key(sort keys %hf1) {
        chomp $key;
        if(exists $hf2{$key}) {
                print "$hf1{$key}\t$hf2{$key}\n";
        }
}
