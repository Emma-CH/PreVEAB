# PreVEAB
A computational package targets to measure the strength of passage adaptation and predict efficacy of a candidate vaccine strain based on its nucleotide sequence.


## Background
Vaccine efficacy for the H3N2 Influenza virus has been alarmingly decreasing in recent years, but underlying causes for this observation are still elusive. Passage adaptation refers to substitutions accumulated during vaccine production might contribute to the vaccine efficacy. Using a statistical method called mutational mapping and 32,278 H3N2 hemagglutinin sequences, we identified 14 important codons driving passage adaptation in the embryonated egg. Based on enrichment scores (ES) derived from these codons, we defined an adaptive distance (AD) calibrating the strength of positive selection on each influenza strain. A very strong negative relationship between adaptive distance and vaccine efficacy (R-square=0.776) indicate the essential impact of passage adaptation on vaccine efficacy. For the first time, we provide a direct and comprehensive evidence that passage adaptation in the embryonated egg is a major determinant of the recent reduction in vaccine efficacy.


## Installing

PreVEAB is written in perl and R.

PreVEAB can be downloaded from github: https://github.com/Emma-CH/PreVEAB


## Running PreVEAB

To run the program, two reference files and one alleles file are necessary. In the reference file called "ES_EggStrains", the enrichemnt scores of each allele from each codon over egg strains are listed, while in the file called "gisaid_32278_H3N2_HA1_ES_byJul2016", enrichment scores of the alleles across 14 key codons are summarized for all 32,278 virus isolates. 

Apart from these two reference files, another "14 alleles file" is also needed to describe the information of candicate vaccine strain. In this file, The allelic states of 14 codons are listed. Users can choose to either directly provide this file (Input files - Option I) or generate this file using our script called "extract_alleles.pl" (Input files - Option II).


### Input files

#### Option I : 14 alleles file

14 allels over 14 codon positions including 138, 145, 156, 158, 159, 160, 183, 186, 190, 193, 194, 219, 226 and 246 should be listed in two columns as following:

    Codon   AminoAcid
     138        S
     145        N 
     156        H

Note: 1) Please make sure that the codons recorded in this alleles file must be exactly consistent with our list.
2) Please be aware that if any allele state is missing or not recorded in our reference file "ES_EggStrains", the analysis will be terminated immediately.

#### Option II : H3N2 HA1 nucleotide sequence file

 Sequence file including the detailed H3N2 HA1 nucleotide sequence should be listed in the following format:
    
    *format 1*
    
    CAAAAACTTCCTGGAAATGACAACAGCACGGCAACGCTGTGCCTTGGGCA...
    
    *format 2*
    
    >Seq_ID
    
    CAAAAACTTCCTGGAAATGACAACAGCACGGCAACGCTGTGCCTTGGGCA...

Note: 1) Please be very careful about the the starting codons, and make sure that the sequence is from "QNL...".
2) Please be aware that if any allele state is missing or not recorded in our reference file "ES_EggStrains", the analysis will be terminated immediately.
3) An corresponding alleles file including allele states over 14 codons will be generated after precessing using "extract_allele.pl".

### Output files

#### Adaptive distance & predicted vaccine efficacy (outfile.txt)

Adaptive distance and predicated vaccine efficacy of the candidate vaccine virus isolate are listed out.

#### PCA analysis & Scatterplot (Correlation_AdaptiveDistance_VE.pdf)

PCA figure describes the distribution of 32,278 virus strains in terms of the first and second PCA dimentions. The dot hightlighed in black color represents the candidate vaccine virus isolate in the current analysis.

This scatterplot figure describes the correlation between adaptive distance and vaccine efficacy. R square labeled at the topright of the figure is provided as referece. The adaptived distance and predicted vaccine efficacy of the candidate vaccine virus isolate are also listed in the figure.

### Examples

* Extract the 14 allelic states in terms of the nucleotide sequence, use the option

    `perl extract_alleles.pl DEMO_seq`

Note: 1) Output file called "DEMO" includes the allelic states across 14 codons.

* Calculated the predicted vaccine efficacy of candidate virus isolate

    `source("PreVEAB.R")`

Note: 1) Please make sure that three files including "DEMO", "ES_EggStrains" and "gisaid_32278_H3N2_HA1_ES_byJul2016" are listed.
2) Two output files including "outfile.txt" and "Correlation_AdaptiveDistance_VE.pdf" will be finally generated.


## Author

* Hui Chen : chenh1@gis.a-star.edu.sg


## Corresponding author

*   Weiwei Zhai : zhaiww1@gis.a-star.edu.sg


## License

This project is licensed under the GNU GPLv3 License - see the
[LICENSE](LICENSE) file for details.
