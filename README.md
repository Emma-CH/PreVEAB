# PreVEAB
PreVEAB takes account of nucleotide seuqence or amino acid states of the designated 14 codon positions and aims to measure the strength of passage adaptation and predict the vaccine efficacy of the candidate vaccine virus isolate.


## Background
Vaccine efficacy of influenza A H3N2 virus has sharply dropped recently, which might be majorly contributed by virus antigenic drift or mutations occurring during vaccine production. These mutations accumulated during virus propagation in hosts or cells such as embryonated eggs and mammalian cell mediums are defined as passage adaption. Hereby, we targets to measure the effects of passage adaption on vaccine efficacy.

32,278 H3N2 hemagglutinin (HA1) sequences as well as passage annotation information have been collected from Global Initiative on Sharing All Influenza Data (GISAID) EpiFlu database. Furthermore, 14 codon positions have been identified with strong signature of passage adaptation in embyonated egg using two statistical tests.

According to the knowledge that the seed precursor influenza virus used for vaccine production must be generated in eggs, to find out the impact of egg passage adaptation on vaccine efficacy is urgent and meaningful. In order to quantitative measure the strength of passage adaptation, enrichment scores (ES) of allels from 14 pre-defined codon positions are calculated for 32,278 background virus sequences and 99 vaccine virus sequences. Principle component analysis (PCA) uncovers the different distribution of 32,278 background virus and vaccine strains and vaccine strains (distantly located from the major clustering of background strains) clearly bear significant evidence of passage adaptation. Subsequently, "adaptive distance" has been defined to measure the strength of passage adaptation.

Trends of adaptive distances and vaccine efficacies ranged from 2010 to 2014 year indicate the essential contribution of egg passage adaptation to the reduced vaccine efficacy. Therefor, we developed this computational strategy which provides a way to measure the adaptive distance of candidate vaccine virus strain and in further predict the vaccine efficacy for public consideration. 


## Installing

PreVEAB is written in perl and R.

PreVEAB can be downloaded from github: https://github.com/Emma-CH/PreVEAB


## Running

To run the program, two background enrichment scores files and one alleles file are necessary. 
Regarding to the preparation of the alleles file, users are able to either directly provide it (Input files - Option I) or generate it using perl script "extract_alleles.pl" (Input files - Option II).
"PreVEAB.R" targets to generate two outfiles carrying the information of adaptive distance and predicted vaccine efficacy of candidate vaccine virus isolate.


### Background ES files

#### File I : ES_EggStrains

All alleles and their enrichment scores acorss 329 codon positions are recorded as following:

    Codon   AminoAcid EnrichmentScore
      1         H          1.384
      1         S          0.000
      1         Q          0.995

#### File II : GISAID_32278_H3N2_HA1_ES_byJul2016

Enrichment scores of 14 alleles across 14 codon positions are extracted for each virus sequence, and information of 32,278 background virus strains and 99 vaccine virus strains are all listed as following: 

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

Note: 1) Please make sure that the 14 codons described in alleles file is exactly consistent with our designated codon list.
2) Please be aware that if any allele state is missing or its enrichment score is not recorded in file "ES_EggStrains", the analysis will be terminated immediately.

#### Option II : H3N2 HA1 nucleotide sequence file

 Sequence file including information of H3N2 HA1 nucleotide sequence should follow the standard formats:
    
    *format 1*
    
    CAAAAACTTCCTGGAAATGACAACAGCACGGCAACGCTGTGCCTTGGGCA...
    
    *format 2*
    
    >Seq_ID
    
    CAAAAACTTCCTGGAAATGACAACAGCACGGCAACGCTGTGCCTTGGGCA...

Note: 1) Please be very careful about the starting codons, and guarantee that the sequence states from "QNL...".
2) Please be aware that if any allele state is missing or its enrichment ecore is not recorded in file "ES_EggStrains", the analysis will be terminated immediately.
3) The corresponding alleles file will be generated from "extract_allele.pl".


### Output files

#### Adaptive distance & predicted vaccine efficacy (e.g. outfile.txt)

Adaptive distance and predicted vaccine efficacy of the candidate vaccine virus isolate are listed out:

    Vaccine efficacy = 0.17
    Adaptive distance = 21.64

#### PCA & Scatterplot (e.g. Correlation_AdaptiveDistance_VE.pdf)

PCA figure describes the distribution of 32,278 background virus strains (32,278 dots)　in terms of the first and second PCA dimensions. The dot highlighted in black color represents the candidate vaccine virus isolate under current analysis.

Scatterplot figure describes the strongly negative correlation between adaptive distance and vaccine efficacy. R square value labeled at the topright is provided as well. The adaptive distance and predicted vaccine efficacy of the candidate vaccine virus isolate are also described in the figure.


### Commands

* Extract the 14 allelic states from the nucleotide sequence, using the option:

    `perl extract_alleles.pl [input_sequence_file] [output_allelic_file]`

* Calculated the predicted vaccine efficacy of candidate vaccine virus isolate, using the option:

    Unix command:
    
    `Rscript PreVEAB.R [input_allelic_file] [output_pdf_file] [output_txt_file]`

    Windows CMD command:
   
    `Rscript.exe [input_allelic_file] [output_pdf_file] [output_txt_file]`

    Windows R environment:
    
    `Args[1]<-[input_allelic_file]  Args[2]<-[output_pdf_file]  Args[3]<-[output_txt_file]  source("PreVEAB.R")`


### Examples

* Extract the 14 allelic states from the nucleotide sequence, using the option:

    `perl extract_alleles.pl DEMO_seq DEMO`
    
    Note: Please make sure that the input file "DEMO_seq" is accessible under current directory.

* Calculated the predicted vaccine efficacy of candidate vaccine virus isolate, using the option:

    Unix command:
    
    `Rscript PreVEAB.R DEMO Correlation_AdaptiveDistance_VE.pdf outfile.txt`
    
    Windows CMD command:
    
    `"C:\Program Files\R\R-3.4.1\bin\Rscript.exe" DEMO Correlation_AdaptiveDistance_VE.pdf outfile.txt`
    
    Windows R environment:
    
    `Args[1]<-"DEMO"    Args[2]<-"Correlation_AdaptiveDistance_VE.pdf"    Args[3]<-"outfile.txt"    source("PreVEAB.R")`
    
    Note: Please make sure the alleles file "DEMO" and two background enrichment scores files "ES_EggStrains" and  
    "GISAID_32278_H3N2_HA1_ES_byJul2016" are all accessible under current directory.


## Author

* Hui Chen : chenh1@gis.a-star.edu.sg


## Corresponding author

*   Weiwei Zhai : zhaiww1@gis.a-star.edu.sg


## License

This project is licensed under the GNU GPLv3 License - see the
[LICENSE](LICENSE) file for details.
