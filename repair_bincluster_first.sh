#!/bin/bash
# repair_genecluster_pipeline.sh
#Code adapted from code on Taylor lab github site

a="repairbins_"
export VAL=$1
export TWO=$2
export ZERO=$3
export REPAIR=$a${TWO}
mkdir ${REPAIR}
cd ${REPAIR}

#copy wig files to directory
cp ../${TWO}/${TWO}_dipy_bk_plus.wig ${TWO}_dipy_bk_plus.wig
cp ../${TWO}/${TWO}_dipy_bk_minus.wig ${TWO}_dipy_bk_minus.wig
cp ../${ZERO}/${ZERO}_dipy_bk_plus.wig ${ZERO}_dipy_bk_plus.wig
cp ../${ZERO}/${ZERO}_dipy_bk_minus.wig ${ZERO}_dipy_bk_minus.wig

# process data to get fraction remaining
printf "${TWO}_dipy_bk_plus.wig\n${TWO}_dipy_bk_minus.wig\n${ZERO}_dipy_bk_plus.wig\n${ZERO}_dipy_bk_minus.wig\n" | perl ../cpdrepair_plotorf_bins.pl >${REPAIR}_dipy_bk_tcr_6bins.txt
