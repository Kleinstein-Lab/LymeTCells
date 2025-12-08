data_dir=/home/ed/research/edel/lyme_dataset4

datasets=('2029390B_HHT_fqs' '2029390EM_HHT_fqs' \
          '2029400B_HHT_fqs' '2029400EM_HHT_fqs' '2029400SC_HHT_fqs' \
          '2029410B_HHT_fqs' '2029410EM_HHT_fqs' '2029410SC_HHT_fqs' \
          '2029430B_HHT_fqs' '2029430EM_HHT_fqs' '2029430SC_HHT_fqs')

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
