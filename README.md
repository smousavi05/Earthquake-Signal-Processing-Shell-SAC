# SAC_data_processing
These are a collection of Shell scripts that I wrote to process seismic data in SAC format. They works by automatically generating and running some sac macros, hence they can process big datasets much faster than equivalents in Python or Matlab. 

These codes do:
1) renaming seed files, 
2) adding catalog info into the sac headers, 
3) renaming sac files into a convention format, 
4) removing the instrument responses, 
5) quality check, 
6) SNR calculation, 
7) rotating components, 
8) amplitude calculations, 
9) plotting stations-event pairs, 
10) plotting travel time, 
11) renaming the original sac files and rotating the horizontal components, 
12) picking P and S arrivals and making quality check, 
13) fft and noise estimation
