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

 14 allels collected from 14 codon positions including 138, 145, 156, 158, 159, 160, 183, 186, 190, 193, 194, 219, 226, 246 should be list in two columns as following:

    Codon   AminoAcid
     138        S
     145        N 
     156        H

Note: 1) Please make sure that the codons recorded in alleles file is exactly consistent with our list.
2) Please be aware that if the allele state is missing or it is not recorded in our background the calculation will be terminated immediately.

#### Option II : HA1 nucleotide sequence file

 Sequence file includes the detailed nucleotide sequence of HA1 nucletide seuqence as following:
    
    CAAAAACTTCCTGGAAATGACAACAGCACGGCAACGCTGTGCCTTGGGCA...

Note: 1) Please be very careful about the the starting position, and make sure the starting codon is from "QNL...".
2) Please be aware that if the allele state is missing or it is not recorded in our background, the calculation will be terminated immediately.

### Output files

#### Adaptive distance & predicted vaccine efficacy (2 numeric numbers)

#### Scatterplot (.pdf file)

This scatterplot figure describes distribution of adaptive distance and vaccine efficacy. And R square is calculated and list at the topright. Please refer the file called "scatterplot.pdf" as listed.

#### PCA analysis (.pdf file)

This PCA figure describes distribution of virus strains based on the first and second PCA dimentions. The dot hightligh in black color is the isolated examined in our current analysis.


### Examples

* Simulate the coalescent tree of a sample of 1000 tumor cells, which are
sampled from a exponetially growing tumor. 
(consult the manual of ms for more information)

    `ms 1000 1 -T -G 1 |tail -n1 > ms_tree.txt`

* Simulate the somatic SNVs of this sample. We assume the sequencing depth is
60, and the purity of the sample is 0.8, which means there are 250 normal
cells other than these 1000 tumor cells. Other settings are: 
a) the mutation rate of SNVs and CNVs are 10 and 0.1 respectively; 
b) the sequence length is 135534747 (chr10 of hg19); 
c) the cells of the sample are diploid. We save the
frequncy of the simulated SNVs to file 'snvs\_freq.txt'.

    `csite.py -t ms_tree.txt -P 0.8 --length 135534747 -r 10 -R 0.1 -D 60 -S
    snvs_freq.txt`


## Author

* Hui Chen : chenh1@gis.a-star.edu.sg

## Corresponding author

*   Weiwei Zhai : zhaiww11@gis.a-star.edu.sg

## License

This project is licensed under the GNU GPLv3 License - see the
[LICENSE](LICENSE) file for details.
