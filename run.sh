#!/bin/bash

[ $# -ne 2 ] && echo "usage: $0: modele_carnet nombre_ticket" && exit 1

modele_carnet=${1?Modèle de Carnet}
nombre_ticket=${2?Nombre de ticket}

stamp_file=stamp_file_to_remove

numero=1
tickets_par_modele=50

while [ $numero -lt $nombre_ticket ]
do
  echo -n "Generation Carnets contenant tickets $numero à $(($numero + $tickets_par_modele)) ..."
  ./generateStamp.sh $numero > "$stamp_file"
  pdftk "$modele_carnet" multistamp $stamp_file output carnets_tombolat_$(printf %05d $numero).pdf
  echo " carnets_tombolat_$(printf %05d $numero).pdf"
  numero=$(( $numero + $tickets_par_modele))
done

echo "If needed, you can concat file with pdfunite"
