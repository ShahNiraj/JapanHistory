################################## Reads  ################################   
Location: /home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/AccessionReads


################################## Fastqc ##################################
cmd: 


################################## Mapping ##################################
cmd:bwa mem -t 15 ~/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa MG-147_S8_L001_R1_001.fastq MG-147_S8_L001_R2_001.fastq > MG-147_L001.sam


################################## Sam To Bam ##################################
samtools view -bS MG-147_L001.sam | samtools sort - MG-147_L001_sorted


################################## Add readgroup ##################################
java -jar /com/extra/picard/1.96/jar-bin/AddOrReplaceReadGroups.jar I=MG-147.bam O=MG-147.rg.bam SO=coordinate ID=MG-147 LB=MG-147 PL=MiSeq PU=one SM=MG-147


################################## Find coverage from bam file ##################################
samtools depth $bamfile | awk '{sum+=\$3; } END { print \"Average = \",sum/NR; }'


################################## Picard and GATK steps ##################################
#1 Mark duplicates
qx --no-scratch -n=1 -c=1 -m =26g -t=50:00:00 'java -Xmx26g -jar /com/extra/picard/2.7.1/jar-lib/picard.jar MarkDuplicates INPUT=Gifu.bam OUTPUT=Gifu.dedup.bam METRICS_FILE=Gifu.metrics.txt'

#2 index dedup file
qx --no-scratch -n=1 -c=1 -t=50:00:00 '/com/extra/samtools/0.1.19/bin/samtools index Gifu.dedup.bam Gifu.dedup.bai'

#3 ReAlign
qx --no-scratch -n=1 -c=1 -m=20g -t=24:00:00 'gatk -U -T RealignerTargetCreator -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -I Gifu.dedup.bam -o Gifu.intervals'

#4 IndelRealign
qx --no-scratch -n=1 -c=1 -m=25g -t=24:00:00 'gatk -U -T IndelRealigner -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -targetIntervals Gifu.intervals -I Gifu.dedup.bam -o Gifu.realigned.bam'

#5 UnifiedGenotyper  (This can be run right in the beginning)
qx --no-scratch -n=1 -c=1 -m=20g -t=100:00:00 'gatk -T UnifiedGenotyper -nt 1 -glm BOTH -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -I Gifu.bam -I MG001.bam -I MG002.bam -I MG003.bam -I MG004.bam -I MG005.bam -I MG007.bam -I MG008.bam -I MG009.bam -I MG010.bam  -I MG011.bam -I MG012.bam -I MG013.bam -I MG014.bam -I MG016.bam -I MG017.bam -I MG018.bam  -I MG019.bam  -I MG020.bam -I MG021.bam  -I MG022.bam  -I MG023.bam -I MG024.bam  -I MG025.bam -I MG026.bam  -I MG027.bam -I MG028.bam  -I MG030.bam  -I MG032.bam  -I MG033.bam  -I MG034.bam -I MG035.bam  -I MG036.bam  -I MG038.bam  -I MG039.bam  -I MG040.bam -I MG041.bam -I MG042.bam -I MG044.bam -I MG045.bam -I MG046.bam -I MG049.bam -I MG050.bam -I MG051.bam -I MG052.bam -I MG053.bam -I MG056.bam -I MG057.bam -I MG058.bam -I MG059.bam -I MG060.bam -I MG061.bam -I MG062.bam -I MG063.bam -I MG065.bam -I MG066.bam -I MG067.bam -I MG068.bam -I MG069.bam -I MG070.bam -I MG071.bam -I MG072.bam -I MG073.bam -I MG074.bam -I MG075.bam -I MG076.bam -I MG077.bam -I MG078.bam -I MG080.bam -I MG081.bam -I MG082.bam -I MG083.bam -I MG084.bam -I MG085.bam -I MG086.bam -I MG088.bam -I MG089.bam -I MG090.bam -I MG091.bam -I MG092.bam -I MG093.bam -I MG094.bam -I MG095.bam -I MG096.bam -I MG097.bam -I MG098.bam -I MG099.bam -I MG100.bam -I MG101.bam -I MG102.bam -I MG103.bam -I MG104.bam -I MG105.bam -I MG106.bam -I MG107.bam -I MG109.bam -I MG110.bam -I MG111.bam -I MG112.bam  -I MG113.bam -I MG115.bam -I MG116.bam -I MG117.bam -I MG118.bam -I MG119.bam -I MG120.bam -I MG121.bam -I MG123.bam -I MG124.bam -I MG125.bam -I MG126.bam -I MG127.bam -I MG128.bam -I MG129.bam  -I MG130.bam -I MG131.bam -I MG132.bam -I MG133.bam -I MG134.bam -I MG135.bam -I MG136.bam -I MG138.bam -I MG139.bam -I MG140.bam -I MG141.bam -I MG142.bam -I MG143.bam -I MG144.bam -I MG145.bam -I MG146.bam -I MG149.bam -I MG150.bam -I MG151.bam -I MG152.bam -I MG154.bam -I MG155.bam -I MG156.bam -o 137Lj.vcf -stand_call_conf 90 -dcov 200' 

#6 BaseRecalibrator
qx --no-scratch -n=1 -c=1 -m=15g -t=50:00:00 'gatk -T BaseRecalibrator -rf BadCigar -knownSites 137LjAccessions.vcf -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -I Gifu.realigned.bam -o Gifu.recal.table’

#7 Print Reads
qx --no-scratch -n=1 -c=1 -m=20g -t=24:00:00 'java -Djava.awt.headless=true -Xmx8g -jar /com/extra/GATK/2.7-2/jar-bin/GenomeAnalysisTK.jar -et NO_ET -K /com/extra/GATK/2.7-2/runef_birc.au.dk.key -T PrintReads -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -I Gifu.realigned.bam -BQSR Gifu.recal.table -o Gifu.recalreads.bam'

#8 ReduceReads
qx --no-scratch -n=1 -c=1 -m=20g -t=24:00:00 'java -Djava.awt.headless=true -Djava.io.tmpdir=/home/niraj/LotusGenome/Niraj/ -Xmx6g -jar /com/extra/GATK/2.7-2/jar-bin/GenomeAnalysisTK.jar -et NO_ET -K /com/extra/GATK/2.7-2/runef_birc.au.dk.key -T ReduceReads -rf BadCigar -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -I Gifu.recalreads.bam -o Gifu.reduced.bam'

#9 Re unifiedgenotyper
qx --no-scratch -n=1 -c=5 -m=20g -t=100:00:00 'java -Djava.awt.headless=true -Djava.io.tmpdir=/home/niraj/LotusGenome/Niraj/ -Xmx12g -jar /com/extra/GATK/2.7-2/jar-bin/GenomeAnalysisTK.jar -et NO_ET -K /com/extra/GATK/2.7-2/runef_birc.au.dk.key -T UnifiedGenotyper -nt 5 -L chr1 -glm BOTH -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -I Gifu.reduced.bam -I MG001.reduced.bam -I MG002.reduced.bam -I MG003.reduced.bam -I MG004.reduced.bam -I MG005.reduced.bam -I MG007.reduced.bam -I MG008.reduced.bam -I MG009.reduced.bam -I MG010.reduced.bam  -I MG011.reduced.bam -I MG012.reduced.bam -I MG013.reduced.bam -I MG014.reduced.bam -I MG016.reduced.bam -I MG017.reduced.bam -I MG018.reduced.bam  -I MG019.reduced.bam  -I MG020.reduced.bam -I MG021.reduced.bam  -I MG022.reduced.bam  -I MG023.reduced.bam -I MG024.reduced.bam  -I MG025.reduced.bam -I MG026.reduced.bam  -I MG027.reduced.bam -I MG028.reduced.bam  -I MG030.reduced.bam  -I MG032.reduced.bam  -I MG033.reduced.bam  -I MG034.reduced.bam -I MG035.reduced.bam  -I MG036.reduced.bam  -I MG038.reduced.bam  -I MG039.reduced.bam  -I MG040.reduced.bam -I MG041.reduced.bam -I MG042.reduced.bam -I MG044.reduced.bam -I MG045.reduced.bam -I MG046.reduced.bam -I MG049.reduced.bam -I MG050.reduced.bam -I MG051.reduced.bam -I MG052.reduced.bam -I MG053.reduced.bam -I MG056.reduced.bam -I MG057.reduced.bam -I MG058.reduced.bam -I MG059.reduced.bam -I MG060.reduced.bam -I MG061.reduced.bam -I MG062.reduced.bam -I MG063.reduced.bam -I MG065.reduced.bam -I MG066.reduced.bam -I MG067.reduced.bam -I MG068.reduced.bam -I MG069.reduced.bam -I MG070.reduced.bam -I MG071.reduced.bam -I MG072.reduced.bam -I MG073.reduced.bam -I MG074.reduced.bam -I MG075.reduced.bam -I MG076.reduced.bam -I MG077.reduced.bam -I MG078.reduced.bam -I MG080.reduced.bam -I MG081.reduced.bam -I MG082.reduced.bam -I MG083.reduced.bam -I MG084.reduced.bam -I MG085.reduced.bam -I MG086.reduced.bam -I MG088.reduced.bam -I MG089.reduced.bam -I MG090.reduced.bam -I MG091.reduced.bam -I MG092.reduced.bam -I MG093.reduced.bam -I MG094.reduced.bam -I MG095.reduced.bam -I MG096.reduced.bam -I MG097.reduced.bam -I MG098.reduced.bam -I MG099.reduced.bam -I MG100.reduced.bam -I MG101.reduced.bam -I MG102.reduced.bam -I MG103.reduced.bam -I MG104.reduced.bam -I MG105.reduced.bam -I MG106.reduced.bam -I MG107.reduced.bam -I MG109.reduced.bam -I MG110.reduced.bam -I MG111.reduced.bam -I MG112.reduced.bam  -I MG113.reduced.bam -I MG115.reduced.bam -I MG116.reduced.bam -I MG117.reduced.bam -I MG118.reduced.bam -I MG119.reduced.bam -I MG120.reduced.bam -I MG121.reduced.bam -I MG123.reduced.bam -I MG124.reduced.bam -I MG125.reduced.bam -I MG126.reduced.bam -I MG127.reduced.bam -I MG128.reduced.bam -I MG129.reduced.bam  -I MG130.reduced.bam -I MG131.reduced.bam -I MG132.reduced.bam -I MG133.reduced.bam -I MG134.reduced.bam -I MG135.reduced.bam -I MG136.reduced.bam -I MG138.reduced.bam -I MG139.reduced.bam -I MG140.reduced.bam -I MG141.reduced.bam -I MG142.reduced.bam -I MG143.reduced.bam -I MG144.reduced.bam -I MG145.reduced.bam -I MG146.reduced.bam -I MG149.reduced.bam -I MG150.reduced.bam -I MG151.reduced.bam -I MG152.reduced.bam -I MG154.reduced.bam -I MG155.reduced.bam -I MG156.reduced.bam -o FinalGeno_137Lj_chr1.vcf'

## command to obtain genotypes at all the sites to calculate callable fraction
qx --no-scratch -n=1 -c=5 -m=20g -t=200:00:00 'java -Djava.awt.headless=true -Djava.io.tmpdir=/home/niraj/LotusGenome/Niraj/ -Xmx12g -jar /com/extra/GATK/2.7-2/jar-bin/GenomeAnalysisTK.jar -et NO_ET -K /com/extra/GATK/2.7-2/runef_birc.au.dk.key -T UnifiedGenotyper -nt 5 -glm BOTH -R /home/niraj/LotusGenome/100_data/124Accessions/BAMs/ljFiles/lj_r30.fa -I Gifu.reduced.bam -I MG001.reduced.bam -I MG002.reduced.bam -I MG003.reduced.bam -I MG004.reduced.bam -I MG005.reduced.bam -I MG007.reduced.bam -I MG008.reduced.bam -I MG009.reduced.bam -I MG010.reduced.bam  -I MG011.reduced.bam -I MG012.reduced.bam -I MG013.reduced.bam -I MG014.reduced.bam -I MG016.reduced.bam -I MG017.reduced.bam -I MG018.reduced.bam  -I MG019.reduced.bam  -I MG020.reduced.bam -I MG021.reduced.bam  -I MG022.reduced.bam  -I MG023.reduced.bam -I MG024.reduced.bam  -I MG025.reduced.bam -I MG026.reduced.bam  -I MG027.reduced.bam -I MG028.reduced.bam  -I MG030.reduced.bam  -I MG032.reduced.bam  -I MG033.reduced.bam  -I MG034.reduced.bam -I MG035.reduced.bam  -I MG036.reduced.bam  -I MG038.reduced.bam  -I MG039.reduced.bam  -I MG040.reduced.bam -I MG041.reduced.bam -I MG042.reduced.bam -I MG044.reduced.bam -I MG045.reduced.bam -I MG046.reduced.bam -I MG049.reduced.bam -I MG050.reduced.bam -I MG051.reduced.bam -I MG052.reduced.bam -I MG053.reduced.bam -I MG056.reduced.bam -I MG057.reduced.bam -I MG058.reduced.bam -I MG059.reduced.bam -I MG060.reduced.bam -I MG061.reduced.bam -I MG062.reduced.bam -I MG063.reduced.bam -I MG065.reduced.bam -I MG066.reduced.bam -I MG067.reduced.bam -I MG068.reduced.bam -I MG069.reduced.bam -I MG070.reduced.bam -I MG071.reduced.bam -I MG072.reduced.bam -I MG073.reduced.bam -I MG074.reduced.bam -I MG075.reduced.bam -I MG076.reduced.bam -I MG077.reduced.bam -I MG078.reduced.bam -I MG080.reduced.bam -I MG081.reduced.bam -I MG082.reduced.bam -I MG083.reduced.bam -I MG084.reduced.bam -I MG085.reduced.bam -I MG086.reduced.bam -I MG088.reduced.bam -I MG089.reduced.bam -I MG090.reduced.bam -I MG091.reduced.bam -I MG092.reduced.bam -I MG093.reduced.bam -I MG094.reduced.bam -I MG095.reduced.bam -I MG096.reduced.bam -I MG097.reduced.bam -I MG098.reduced.bam -I MG099.reduced.bam -I MG100.reduced.bam -I MG101.reduced.bam -I MG102.reduced.bam -I MG103.reduced.bam -I MG104.reduced.bam -I MG105.reduced.bam -I MG106.reduced.bam -I MG107.reduced.bam -I MG109.reduced.bam -I MG110.reduced.bam -I MG111.reduced.bam -I MG112.reduced.bam  -I MG113.reduced.bam -I MG115.reduced.bam -I MG116.reduced.bam -I MG117.reduced.bam -I MG118.reduced.bam -I MG119.reduced.bam -I MG120.reduced.bam -I MG121.reduced.bam -I MG123.reduced.bam -I MG124.reduced.bam -I MG125.reduced.bam -I MG126.reduced.bam -I MG127.reduced.bam -I MG128.reduced.bam -I MG129.reduced.bam  -I MG130.reduced.bam -I MG131.reduced.bam -I MG132.reduced.bam -I MG133.reduced.bam -I MG134.reduced.bam -I MG135.reduced.bam -I MG136.reduced.bam -I MG138.reduced.bam -I MG139.reduced.bam -I MG140.reduced.bam -I MG141.reduced.bam -I MG142.reduced.bam -I MG143.reduced.bam -I MG144.reduced.bam -I MG145.reduced.bam -I MG146.reduced.bam -I MG149.reduced.bam -I MG150.reduced.bam -I MG151.reduced.bam -I MG152.reduced.bam -I MG154.reduced.bam -I MG155.reduced.bam -I MG156.reduced.bam --output_mode EMIT_ALL_SITES -o FinalGeno_137Lj_EAS.vcf'

################################## Final File names and their location ##################################
#Emit all Sites VCF files 
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_EAS.chr0.vcf   162,642,629  
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_EAS.chr1.vcf    57,082,619
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_EAS_chr2.vcf    38,771,737
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_EAS_chr3.vcf    40,102,749
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_EAS_chr4.vcf    39,395,540
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_EAS_chr5.vcf    32,521,204
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_EAS_chr6.vcf    24,139,410
                                                                                     Total   394,655,888

#Raw VCF files (all type of variants)                                                    Count
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_chr0.vcf   4,313,582
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_chr1.vcf   1,087,269
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_chr2.vcf     765,693
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_chr3.vcf     734,968
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_chr4.vcf     736,159
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_chr5.vcf     670,812
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/FinalGeno_137Lj_chr6.vcf     408,069                                                                                                                                                                     
                                                                                 Total   8,716,552

################################## Filtering ##################################
    Filt 1: MG020 accession should have reference genotype
    Filt 2: Inbreeding score
    Filt 3: Haplotype score
    Filt 4: total depth
    Filt 5: Quality
    Filt 6: 50% genotype present
    Filt 7 (For GWAS):5% minor allele frequency

# Raw VCF file with only biallelic SNPs
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snp.vcf                             7,836,221

# Raw VCF file with only Indels
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.indel.vcf                             880,331

# Raw VCF file wth only SNPs and homozygous reference genotype in MG020 
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snp.ref.vcf                          5,971,428

# Raw VCF file with only snps and alternative genotype in MG020
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snp.alt.vcf                            225,701

# Raw VCF file with only snps and heterozygous genotype in MG020
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snp.het.vcf                          1,078,966

# VCF file with SNPs and filters namely, MG20 reference, inbreeding coefficient, haplotype score, depth, and quality (filt1)
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snp.ref.filt1.vcf                      962,598

# filt1 + 50% genotype present
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/only0.5.recode.vcf                                         915,008

# filt1 +50% genotype present+non repetitive region
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/bed.test.nr.0.5.out                                        525,800

# filt1 + g50 + 5% maf
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snps.ref.filt1.g5mac0.5.recode.vcf     360,258

# filt1 + g50 + 5% maf + nr
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snps.ref.filt1.g5mac0.5.nr.recode.vcf  201,694

################################## scripts and commands to generate all the above files ##################################

## SNPs Validation
# Validated SNPs
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/SNPValidation/validatedSNPs.txt  456

## Final VCF files
For the analysis: 
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/bed.test.nr.0.5.out 

For Stig:
/home/niraj/LotusGenome/Niraj/2_LotusAccessions/runGATKv2.7-2/VCF_QualityControl/chr0/FinalGeno_137Lj_raw.snps.ref.filt1.g5mac0.5.nr.recode.vcf

## SNPs annotation


## PCA and Structure

## …
