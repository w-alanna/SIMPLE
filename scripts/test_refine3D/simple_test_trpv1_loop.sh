simple_exec prg=new_project projname=trpv1 &
cd trpv1
wait
simple_exec prg=import_particles ctf=flip deftab=/mnt/beegfs/elmlund/testbench/trpv1/deftab.txt stk=/mnt/beegfs/elmlund/testbench/trpv1/flipnew.mrc cs=2.00000000 fraca=0.100000001 kv=300.000000 smpd=1.21560001 &
wait
simple_exec prg=cluster2D ncls=150 mskdiam=175 nparts=4 nthr=20 projfile=1_import_particles/trpv1_auto.simple objfun=euclid ml_reg=no sigma_est=global >& CLUST2D_2 &
wait

simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=20 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=3_selection/trpv1_auto.simple > INI3D_4 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=4_initial_3Dmodel/trpv1_auto.simple > REFINE3D_5 &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=5_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=6_automask/automask.mrc combine_eo=yes projfile=5_refine3D/trpv1_auto.simple > REFINE3D_7 &
wait

simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=40 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=8_selection/trpv1_auto.simple > INI3D_9 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=9_initial_3Dmodel/trpv1_auto.simple > REFINE3D_10 &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=10_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=11_automask/automask.mrc combine_eo=yes projfile=10_refine3D/trpv1_auto.simple > REFINE3D_12 &
wait

simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=60 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=13_selection/trpv1_auto.simple > INI3D_14 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=14_initial_3Dmodel/trpv1_auto.simple > REFINE3D_15 &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=15_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=16_automask/automask.mrc combine_eo=yes projfile=15_refine3D/trpv1_auto.simple > REFINE3D_17 &
wait

simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=80 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=18_selection/trpv1_auto.simple > INI3D_19 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=19_initial_3Dmodel/trpv1_auto.simple > REFINE3D_20 &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=20_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=21_automask/automask.mrc combine_eo=yes projfile=20_refine3D/trpv1_auto.simple > REFINE3D_22 &
wait

simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=100 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=23_selection/trpv1_auto.simple > INI3D_24 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=24_initial_3Dmodel/trpv1_auto.simple > REFINE3D_25 &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=25_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=26_automask/automask.mrc combine_eo=yes projfile=25_refine3D/trpv1_auto.simple > REFINE3D_27 &
wait

simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=50 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=28_selection/trpv1_auto.simple > INI3D_29 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=29_initial_3Dmodel/trpv1_auto.simple > REFINE3D_30 &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=30_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=31_automask/automask.mrc combine_eo=yes projfile=30_refine3D/trpv1_auto.simple > REFINE3D_32 &
wait


mkdir trpv1_20 trpv1_40 trpv1_60 trpv1_80 trpv1_100 trpv1_base
wait
mv 3_selection/ INIE3D_4 4_initial_3Dmodel/ REFINE3D_5 5_refine3D/ 6_automask/ 7_refine3D/ REFINE3D_7 trpv1_20
wait
mv 8_selection/ INIE3D_9 9_initial_3Dmodel/ REFINE3D_10 10_refine3D/ 11_automask/ 12_refine3D/ REFINE3D_12 trpv1_40
wait
mv 13_selection/ INIE3D_14 14_initial_3Dmodel/ REFINE3D_15 15_refine3D/ 16_automask/ 17_refine3D/ REFINE3D_17 trpv1_60
wait
mv 18_selection/ INIE3D_19 19_initial_3Dmodel/ REFINE3D_20 20_refine3D/ 21_automask/ 22_refine3D/ REFINE3D_22 trpv1_80
wait
mv 23_selection/ INIE3D_24 24_initial_3Dmodel/ REFINE3D_25 25_refine3D/ 26_automask/ 27_refine3D/ REFINE3D_27 trpv1_100
wait
mv 28_selection/ INIE3D_29 29_initial_3Dmodel/ REFINE3D_30 30_refine3D/ 31_automask/ 32_refine3D/ REFINE3D_32 trpv1_base

#not tested yet!!!!