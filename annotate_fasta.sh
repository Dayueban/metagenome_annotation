#  $1 = file to annotate
#  $2 = IPER NO_IPER PFAM
#  $3 = id
#
#   /ORG-Data/scripts/annotate_fasta.sh
#
# dependencies are as follows
# 	prodigal
#	KEGG
#	interproscan
# 	ublast
# 	uniref
#	pullcontigs.pl
#	ANNOTATION_PIPELINE_IPER_OPTION.sh
#	make_fasta_seq_single_line.py
#	interproscan_parallel.sh
#	parallel_PfamScan.py
#	convert_pfam_to_iperscan.py
#	reverse_best_hits.sh
#	perl1.pl
#	perl2.pl
#	perl4_NEW.pl
#	pull_all_contig_annotations.py
#	perl6.pl
#	write_annotation_to_fasta.py
#	
#	dependent scripts must me in the same directory, or executable from a root directory
#
#   makes a folder annotate_<id>_<PFAMM> with all the results
#   only runs on 6 processors
if [ -d annotate_$3_$2 ] #if the directory exists then exit
then
   echo "Directory already exists .. Exiting"
   exit
else
   mkdir annotate_$3_$2
fi

cd annotate_$3_$2


echo "running prodigal"
time prodigal -i ../"$1" -o contigs_ALL.genes -a contigs_ALL.genes.faa -d contigs_ALL.genes.fna -p meta -m

#echo "Making list"
#/ORG-Data/scripts/bin/Assembly/pullcontigs.pl ../"$1" ORIG All_ContigstoPULL.txt

echo "Running annotation pipeline"
bash ANNOTATION_PIPELINE_IPER_OPTION.sh contigs_ALL.genes.faa  contigs_ALL.genes.fna NA "$3" "$2" 6

echo "Script finished"


