# PreVEAB
A computational package targets to measure the strength of passage adaptation and predict efficacy of a candidate vaccine strain based on its nucleotide sequence.


## Background
Vaccine efficacy for the H3N2 Influenza virus has been alarmingly decreasing in recent years, but underlying causes for this observation are still elusive. Passage adaptation refers to substitutions accumulated during vaccine production might contribute to the vaccine efficacy. Using a statistical method called mutational mapping and 32,278 H3N2 hemagglutinin sequences, we identified 14 important codons driving passage adaptation in the embryonated egg. Based on enrichment scores derived from these codons, we defined an adaptive distance (AD) calibrating the strength of positive selection on each influenza strain. A very strong negative relationship between adaptive distance and vaccine efficacy (R-square=0.776) indicate the essential impact of passage adaptation on vaccine efficacy. For the first time, we provide a direct and comprehensive evidence that passage adaptation in the embryonated egg is a major determinant of the recent reduction in vaccine efficacy.


## Installing

PreVEAB is written in perl and R.

PreVEAB can be downloaded from github: https://github.com/Emma-CH/PreVEAB


## Running PreVEAB

The 

### Input files

#### Option I : 14 alleles file

 14 allels over 14 codon positions including 138, 145, 156, 158, 159, 160, 183, 186, 190, 193, 194, 219, 226 and 246 should be list in two columns as following:

    Codon   AminoAcid
     138        S
     145        N 
     156        H

Note: 1) Please make sure that the codons recorded in alleles file are exactly consistent with our list.
2) Please be aware that if any allele state is missing or not recorded in our reference file "ES_EggStrains", the analysis will be terminated immediately.

#### Option II : HA1 nucleotide sequence file

 Sequence file including the detailed H3 HA1 nucleotide sequence of HA1 should be listed as following or in a fasta format:
    
    [example I]
    CAAAAACTTCCTGGAAATGACAACAGCACGGCAACGCTGTGCCTTGGGCA...
    
    [example II]
    >Seq_ID
    CAAAAACTTCCTGGAAATGACAACAGCACGGCAACGCTGTGCCTTGGGCA...

Note: 1) Please be very careful about the the starting codons, and make sure that the sequence is from "QNL...".
2) Please be aware that if any allele state is missing or not recorded in our reference file "ES_EggStrains", the analysis will be terminated immediately.
3) An corresponding alleles file including allele states over 14 codons will be generated after precessing using "extract_allele.pl".

### Output files

#### Adaptive distance & predicted vaccine efficacy (outfile.txt)

Adaptive distance and predicated vaccine efficacy of the candidate virus isolate are listed out.

#### PCA analysis & Scatterplot (Correlation_AdaptiveDistance_VE.pdf)

PCA figure describes the distribution of 32,278 virus strains in terms of the first and second PCA dimentions. The dot hightlighed in black color represents the virus isolate examined in the current analysis.

This scatterplot figure describes correlation of adaptive distance and vaccine efficacy (VE). And R square is also calculated and list at the topright. The adaptived distance and predicted vaccine efficacy of the examined virus isolate are also listed in the figure.

### Examples

* Simulate the coalescent tree of a sample of 1000 tumor cells, which are

    `perl extract_alleles.pl DEMO_seq`

Note: 1) Please be very careful about the the starting codons, and make sure that the sequence is from "QNL...".
2) Please be aware that if any allele state is missing or not recorded in our reference file "ES_EggStrains", the analysis will be terminated immediately.
3) An corresponding alleles file including allele states over 14 codons will be generated after precessing using "extract_allele.pl".

* Simulate the somatic SNVs of this sample. We assume the sequencing depth is

    `source("PreVEAB.R")`

Note: 1) Please be very careful about the the starting codons, and make sure that the sequence is from "QNL...".
2) Please be aware that if any allele state is missing or not recorded in our reference file "ES_EggStrains", the analysis will be terminated immediately.
3) An corresponding alleles file including allele states over 14 codons will be generated after precessing using "extract_allele.pl".


## Author

* Hui Chen : chenh1@gis.a-star.edu.sg


## Corresponding author

*   Weiwei Zhai : zhaiww11@gis.a-star.edu.sg


## License

This project is licensed under the GNU GPLv3 License - see the
[LICENSE](LICENSE) file for details.
