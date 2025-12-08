data_dir=/home/ed/research/edel/lyme_dataset3

datasets=('202936_0B_5P_HHT_fqs' '202937_0B_5P_HHT_fqs' 'U19L202398_0B_5P_HHT_fqs' \
          '202936_0EM_5P_HHT_fqs' '202937_0EM_5P_HHT_fqs' 'U19L202398_0EM_5P_HHT_fqs' \
          '202936_0SC_5P_HHT_fqs' '202937_0SC_5P_HHT_fqs' 'U19L202398_0SC_5P_HHT_fqs')

patterns=('HHT')

for ((i = 0 ; i < ${#datasets[@]} ; i++)); do
   in_dir="${data_dir}/${datasets[i]}/"
   echo "Input directory: $in_dir"
   out_dir="${data_dir}/trust4/${datasets[i]}/"
   echo "Output directory: $out_dir"

   sample1=$in_dir*HHT*R1*
   sample2=$in_dir*HHT*R2*

   run-trust4 -t 31 \
       -f /home/ed/opt/TRUST4/hg38_bcrtcr.fa \
       --ref /home/ed/opt/TRUST4/human_IMGT+C.fa \
       -1 $sample1 -2 $sample2 \
       --barcode $sample1 \
       --barcodeRange 0 15 + \
       --read1Range 16 -1 \
       --od $out_dir
done
