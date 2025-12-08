data_dir=/home/ed/research/edel/lyme_dataset2

datasets=('192561SKL_GEX_HHT_fqs' '192561SKN_GEX_HHT_fqs' '192563SKL_GEX_HHT_fqs' \
          '192564SKL_GEX_HHT_fqs' '192564SKN_GEX_HHT_fqs' '192565SKL_GEX_HHT_fqs' '192565SKN_GEX_HHT_fqs' \
          '192566_GEX_HHT_fqs' '192566SKL_GEX_HHT_fqs' '192566SKN_GEX_HHT_fqs' \
          '192567SKL_GEX_HHT_fqs' '192567SKN_GEX_HHT_fqs')

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
