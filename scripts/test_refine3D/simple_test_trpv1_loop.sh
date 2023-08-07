simple_exec prg=new_project dir=./ &
wait
simple_exec prg=import_particles ctf=flip deftab=/mnt/beegfs/elmlund/testbench/trpv1/deftab.txt stk=/mnt/beegfs/elmlund/testbench/trpv1/flipnew.mrc cs=2.00000000 fraca=0.100000001 kv=300.000000 smpd=1.21560001 &
wait
simple_exec prg=cluster2D ncls=150 mskdiam=175 nparts=4 nthr=20 projfile=1_import_particles/trpv1.simple objfun=euclid ml_reg=no sigma_est=global
wait

echo "------------- 10 ---------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=10 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=3_selection/trpv1.simple &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=4_initial_3Dmodel/trpv1.simple &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=5_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=6_automask/automask.mrc combine_eo=yes projfile=5_refine3D/trpv1.simple
wait

echo "------------- 30 ---------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=30 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=8_selection/trpv1.simple &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=9_initial_3Dmodel/trpv1.simple &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=10_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=11_automask/automask.mrc combine_eo=yes projfile=10_refine3D/trpv1.simple
wait

echo "------------- 50 ---------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=50 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=13_selection/trpv1.simple &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=14_initial_3Dmodel/trpv1.simple &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=15_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=16_automask/automask.mrc combine_eo=yes projfile=15_refine3D/trpv1.simple
wait

echo "------------- 70 ---------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=70 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=18_selection/trpv1.simple &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=19_initial_3Dmodel/trpv1.simple &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=20_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=21_automask/automask.mrc combine_eo=yes projfile=20_refine3D/trpv1.simple
wait

echo "------------- 90 ---------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=90 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=23_selection/trpv1.simple &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=24_initial_3Dmodel/trpv1.simple &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=25_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=26_automask/automask.mrc combine_eo=yes projfile=25_refine3D/trpv1.simple
wait

#echo "------------- 50 ---------------------"
#wait
#simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=50 &
#wait
#simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=28_selection/trpv1.simple &
#wait
#simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=29_initial_3Dmodel/trpv1.simple &
#wait
#simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=30_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
#wait
#simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=31_automask/automask.mrc combine_eo=yes projfile=30_refine3D/trpv1.simple
#wait


mkdir trpv1_10 trpv1_30 trpv1_50_test trpv1_70 trpv1_90 #trpv1_base_50
wait
mv 3_selection/ 4_initial_3Dmodel/ 5_refine3D/ 6_automask/ 7_refine3D/ trpv1_10
wait
mv 8_selection/ 9_initial_3Dmodel/ 10_refine3D/ 11_automask/ 12_refine3D/ trpv1_30
wait
mv 13_selection/ 14_initial_3Dmodel/ 15_refine3D/ 16_automask/ 17_refine3D/ trpv1_50_test
wait
mv 18_selection/ 19_initial_3Dmodel/ 20_refine3D/ 21_automask/ 22_refine3D/ trpv1_70
wait
mv 23_selection/ 24_initial_3Dmodel/ 25_refine3D/ 26_automask/ 27_refine3D/ trpv1_90
#wait
#mv 28_selection/ 29_initial_3Dmodel/ 30_refine3D/ 31_automask/ 32_refine3D/ trpv1_base_50
#not tested yet!!!!
# ~/projects/SIMPLE/scripts/test_refine3D/simple_test_trpv1_loop.sh


echo "-------------------- TRPV BASH LOOP 10, 30, .... 90 -----------------------"