# PreVEAB
PreVEAB takes account of the nucleotide seuqence or the amino acid states of designated 14 codon positions and targets to measure the strength of passage adaptation and predict the potential vaccine efficacy of the candidate vaccine strain.


## Background
Vaccine efficacy of the H3N2 influenza virus has been sharply dropped recently, which might be contributed by two major reasons including antigenic drift and mutations occurring during vaccine production. And the mutations accumulated during the virus propagations in hosts or cells such as embryonated eggs and mammalian cell medium are called passage adaption. Hereby, we put efforts to measure the impact of passage adaption on vaccine efficacy.

32,278 H3N2 HA1 hemagglutinin (HA) sequences have been collected from Global Initiative on Sharing All Influenza Data (GISAID) and detailed passage annotation information have been also extracted at the meanwhile. After applying two statistical methods, 14 codon positions are detected with strong signature of passage adaptation in embyonated egg.

Since it is necessary that the seed precursor virus used for vaccine production must be generated in eggs, to find out the internal relationship between the egg passage adaptation and the reduced vaccine efficacy is urgent and meaningful. A parameter called enrichment score (ES) is defined and applied to measure the strength of passage adaptation. According to the enrichment scores across 14 key codon positions, principle component analysis has been performed to uncover the distribution of 32,278 background virus sequences as well as a batch of vaccine strains. The pattern displays that WHO vaccine strains (distantly located from the major clustering of background sequences) bear significant evidence of passage adaptation, and subsequently "adaptive distance" has been defined.

Two curves representing the trends of adaptive distances and vaccine efficacies ranged from 2010 to 2014 year indicate the essential impact of passage adaptation on vaccine efficacy. Hence, we have developed this computational strategy which privides a way to measure the adaptive distance of candidate vaccine strains and in further predict the vaccine efficacy for public evaluation. 


## Installing

PreVEAB is written in perl and R.
PreVEAB can be downloaded from github: https://github.com/Emma-CH/PreVEAB


## Running PreVEAB

To run the program, two background enrichment scores files and one alleles file are necessary. 
Regarding to the preparation of the alleles file, users are able to choose to either directly provide it (Input files - Option I) or generate it using the script called "extract_alleles.pl" (Input files - Option II).
After calculation using the script called "PreVEAB.R", two outfiles including the information of adaptive distance and predicated vaccine efficacy are generated finally.


### Background enrichement scores files

#### File I : ES_EggStrains

Allels and the corresponding enrichment scores acorss 329 codon positions are recorded as following:

    Codon   AminoAcid EnrichmentScore
      1         H          1.384
      1         S          0.000
      1         Q          0.995

#### File II : GISAID_32278_H3N2_HA1_ES_byJul2016

Enrichment scores of 14 allels across 14 codon positions are listed for each virus sequence, and 32,278 virus strains collected from GISAID and 99 vaccine virus strains are recorded together in this file: 

     ID              Year       Passage     138    145    156    158    159    160    183    186    190    193    194    219    226    246
     EPI_ISL_167277  2003     EGG_VACCINE  0.936  1.436  1.475  0.832  1.039  1.235  10.236  3.513  0.828  1.297  0.707  0.857 0.597  0.936
     EPI_ISL_174195  2003     EGG_VACCINE  0.936  1.436  1.475  0.664  1.039  1.235  10.236  3.513  0.828  1.297  0.707  0.857 0.597  0.936
     EPI_ISL_2674    2003     EGG_VACCINE  0.936  1.436  1.475  0.664  1.039  1.235   0.945  3.513  0.828  1.297  11.77  0.857 0.597  0.936    


### Input files

#### Option I : 14 alleles file

14 allels over 14 codon positions including 138, 145, 156, 158, 159, 160, 183, 186, 190, 193, 194, 219, 226 and 246 should be listed in two columns as following:

    Codon   AminoAcid
     138        S
     145        N 
     156        H

Note: 1) Please make sure that the codons recorded in this alleles file must be exactly consistent with our list.
2) Please be aware that if any allele state is missing or not recorded in our reference file "ES_EggStrains", the analysis will be terminated immediately.

#### Option II : H3N2 HA1 nucleotide sequences file

 Sequence file including the detailed H3N2 HA1 nucleotide sequences should be listed in the following format:
    
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

    Vaccine efficacy = 0.17
    Adaptive distance = 21.64

#### PCA analysis & Scatterplot (Correlation_AdaptiveDistance_VE.pdf)

PCA figure describes the distribution of 32,278 virus strains in terms of the first and second PCA dimentions. The dot hightlighed in black color represents the candidate vaccine virus isolate in the current analysis.

This scatterplot figure describes the correlation between adaptive distance and vaccine efficacy. R square labeled at the topright of the figure is provided as referece. The adaptived distance and predicted vaccine efficacy of the candidate vaccine virus isolate are also listed in the figure.


### Commands

* Extract the 14 allelic states in terms of the nucleotide sequence, use the option

    `perl extract_alleles.pl [input_sequence_file] [output_allelic_file]`

* Calculated the predicted vaccine efficacy of candidate virus isolate

    Unix environment:
    
    `Rscript PreVEAB.R [input_allelic_file] [output_pdf_file] [output_txt_file]`

    Windows CMD environment:
   
    `Rscript.exe [input_allelic_file] [output_pdf_file] [output_txt_file]`

    Windows R environment:
    
    `Args[1]<-[input_allelic_file]  Args[2]<-[output_pdf_file]  Args[3]<-[output_txt_file]  source("PreVEAB.R")`


### Examples

* Extract the 14 allelic states in terms of the nucleotide sequence, use the option

    `perl extract_alleles.pl DEMO_seq DEMO`
    
    Note: Please make sure that the input files called "DEMO_seq" must be located under current directory.

* Calculated the predicted vaccine efficacy of candidate virus isolate

    Unix environment:
    
    `Rscript PreVEAB.R DEMO Correlation_AdaptiveDistance_VE.pdf outfile.txt`
    
    Windows CMD environment:
    
    `"C:\Program Files\R\R-3.4.1\bin\Rscript.exe" DEMO Correlation_AdaptiveDistance_VE.pdf outfile.txt`
    
    Windows R environment:
    
    `Args[1]<-"DEMO"    Args[2]<-"Correlation_AdaptiveDistance_VE.pdf"    Args[3]<-"outfile.txt"    source("PreVEAB.R")`
    
    Note: Please make sure all input files such as "DEMO_seq", "DEMO", "ES_EggStrains" and "GISAID_32278_H3N2_HA1_ES_byJul2016" and two     background enrichment score files "ES_EggStrains" and "GISAID_32278_H3N2_HA1_ES_byJul2016" must be located under current directory.


## Author

* Hui Chen : chenh1@gis.a-star.edu.sg


## Corresponding author

*   Weiwei Zhai : zhaiww1@gis.a-star.edu.sg


## License

This project is licensed under the GNU GPLv3 License - see the
[LICENSE](LICENSE) file for details.
