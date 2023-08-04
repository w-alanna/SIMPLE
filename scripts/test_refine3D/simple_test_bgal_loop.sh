simple_exec prg=new_project projname=bgal &
wait
cd bgal
simple_exec prg=import_particles deftab=/mnt/beegfs/elmlund/testbench/bgal/deftab.txt stk=/mnt/beegfs/elmlund/testbench/bgal/sumstack.mrc cs=2.7 fraca=0.1 kv=300 smpd=1.275 &
wait
simple_exec prg=cluster2D ncls=90 mskdiam=180 nparts=4 nthr=20 objfun=euclid projfile=1_import_particles/bgal.simple &
wait

echo "---------------------- ares 20 ------------------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=20 &
wait
simple_exec prg=initial_3Dmodel pgrp=d2 mskdiam=180 nthr=40 projfile=3_selection/bgal.simple &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global &
wait
simple_exec prg=automask mskdiam=180 amsklp=12 mw=465 thres=0.012 nthr=20 vol1=5_refine3D/recvol_state01_iter010_lp.mrc smpd=1.275 &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid ml_reg=no nonuniform=yes sigma_est=global continue=yes mskfile=6_automask/automask.mrc combine_eo=yes projfile=5_refine3D/bgal.simple
wait

echo "---------------------- ares 40 ------------------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=40 &
wait
simple_exec prg=initial_3Dmodel pgrp=d2 mskdiam=180 nthr=40 projfile=8_selection/bgal.simple &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global &
wait
simple_exec prg=automask mskdiam=180 amsklp=12 mw=465 thres=0.012 nthr=20 vol1=10_refine3D/recvol_state01_iter010_lp.mrc smpd=1.275 &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid ml_reg=no nonuniform=yes sigma_est=global continue=yes mskfile=11_automask/automask.mrc combine_eo=yes projfile=10_refine3D/bgal.simple
wait

echo "---------------------- ares 60 ------------------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=60 &
wait
simple_exec prg=initial_3Dmodel pgrp=d2 mskdiam=180 nthr=40 projfile=13_selection/bgal.simple &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global &
wait
simple_exec prg=automask mskdiam=180 amsklp=12 mw=465 thres=0.012 nthr=20 vol1=15_refine3D/recvol_state01_iter010_lp.mrc smpd=1.275 &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid ml_reg=no nonuniform=yes sigma_est=global continue=yes mskfile=16_automask/automask.mrc combine_eo=yes projfile=15_refine3D/bgal.simple
wait

echo "---------------------- ares 80 ------------------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=80 &
wait
simple_exec prg=initial_3Dmodel pgrp=d2 mskdiam=180 nthr=40 projfile=18_selection/bgal.simple &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global &
wait
simple_exec prg=automask mskdiam=180 amsklp=12 mw=465 thres=0.012 nthr=20 vol1=20_refine3D/recvol_state01_iter010_lp.mrc smpd=1.275 &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid ml_reg=no nonuniform=yes sigma_est=global continue=yes mskfile=21_automask/automask.mrc combine_eo=yes projfile=20_refine3D/bgal.simple &
wait

echo "---------------------- ares 100 ------------------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=100 &
wait
simple_exec prg=initial_3Dmodel pgrp=d2 mskdiam=180 nthr=40 projfile=23_selection/bgal.simple &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global &
wait
simple_exec prg=automask mskdiam=180 amsklp=12 mw=465 thres=0.012 nthr=20 vol1=25_refine3D/recvol_state01_iter010_lp.mrc smpd=1.275 &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid ml_reg=no nonuniform=yes sigma_est=global continue=yes mskfile=26_automask/automask.mrc combine_eo=yes projfile=25_refine3D/bgal.simple
wait

echo "---------------------- ares 41 ------------------------------"
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=41 &
wait
simple_exec prg=initial_3Dmodel pgrp=d2 mskdiam=180 nthr=40 projfile=28_selection/bgal.simple &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global &
wait
simple_exec prg=automask mskdiam=180 amsklp=12 mw=465 thres=0.012 nthr=20 vol1=30_refine3D/recvol_state01_iter010_lp.mrc smpd=1.275 &
wait
simple_exec prg=refine3D pgrp=d2 mskdiam=180 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid ml_reg=no nonuniform=yes sigma_est=global continue=yes mskfile=31_automask/automask.mrc combine_eo=yes projfile=30_refine3D/bgal.simple
wait

mkdir bgal_20 bgal_40 bgal_60 bgal_80 bgal_100 bgal_base_41
wait
mv 3_selection/ 4_initial_3Dmodel/ 5_refine3D/ 6_automask/ 7_refine3D/ bgal_20
wait
mv 8_selection/ 9_initial_3Dmodel/ 10_refine3D/ 11_automask/ 12_refine3D/ bgal_40
wait
mv 13_selection/ 14_initial_3Dmodel/ 15_refine3D/ 16_automask/ 17_refine3D/ bgal_60
wait
mv 18_selection/ 19_initial_3Dmodel/ 20_refine3D/ 21_automask/ 22_refine3D/ bgal_80
wait
mv 23_selection/ 24_initial_3Dmodel/ 25_refine3D/ 26_automask/ 27_refine3D/ bgal_100
wait
mv 28_selection/ 29_initial_3Dmodel/ 30_refine3D/ 31_automask/ 32_refine3D/ bgal_base_41


# ~/projects/SIMPLE/scripts/test_refine3D/simple_test_bgal_loop.sh