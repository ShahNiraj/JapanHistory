open File, $ARGV[0]; # fasta format sequence
open Ids, $ARGV[1];# blast output
#open (outreq,">req");
#open (outnreq,">nreq");
	@sequences=<File>;
	@seqid=<Ids>;
	$onefile=join("",@sequences);
	@splitfile=split(">",$onefile);
	shift(@splitfile);
	#print "$splitfile[0]\n";
for($j=0;$j<=$#seqid;$j++) {
		chomp $seqid[$j];
		@blastId=split("\t",$seqid[$j]);
		for($i=0;$i<=$#splitfile;$i++)
		{
			chomp $splitfile[$i];
			@oneseqsplit=split("\n",$splitfile[$i]);
			$idseq=shift(@oneseqsplit);
			chomp $idseq;
			$singleSeq=join("\n",@oneseqsplit);
			$singleSeq=~ s/\n//g;
			if($idseq =~ /(^[a-zA-Z0-9_]*)/)
        	        {
	                        $readseqid=$1;
 	                }
			if($blastId[1] eq $readseqid) {
				if($blastId[2] < $blastId[3])
				{
					$lensubstr=$blastId[3] - $blastId[2];
					$extractedSeq=substr($singleSeq,$blastId[2]-1,$lensubstr+1);
					$len=length($extractedSeq);
					print ">$seqid[$j]\t$lensubstr\n$extractedSeq\n";
				}
				elsif($blastId[2] > $blastId[3])
				{
					$lensubstr=$blastId[2] - $blastId[3];
					$revSingleSeq=reverse($singleSeq);
					$revSingleSeq =~ tr/ATGCatgc/TACGTACG/;
					$extractedSeq=substr($revSingleSeq,$blastId[3]-1,$lensubstr+1);
					print ">$seqid[$j]\t$lensubstr\n$extractedSeq\n";
				}
			}
		}
}
