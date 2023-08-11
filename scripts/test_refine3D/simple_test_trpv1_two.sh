simple_exec prg=new_project dir=./ &
wait
simple_exec prg=import_particles ctf=flip deftab=/mnt/beegfs/elmlund/testbench/trpv1/deftab.txt stk=/mnt/beegfs/elmlund/testbench/trpv1/flipnew.mrc cs=2.00000000 fraca=0.100000001 kv=300.000000 smpd=1.21560001 &
wait
simple_exec prg=cluster2D ncls=150 mskdiam=175 nparts=4 nthr=20 projfile=1_import_particles/trpv1.simple objfun=euclid ml_reg=no sigma_est=global &
wait
simple_exec prg=map_cavgs_selection stk2=2_cluster2D/cavgs_iter016_ranked.mrc ares=10 &
wait
simple_exec prg=initial_3Dmodel pgrp=c4 mskdiam=175 nthr=40 projfile=3_selection/trpv1.simple &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global projfile=4_initial_3Dmodel/trpv1.simple &
wait
simple_exec prg=automask mskdiam=175 amsklp=12 mw=400 thres=0.01 nthr=20 vol1=5_refine3D/recvol_state01_iter010_lp.mrc smpd=1.2156 &
wait
simple_exec prg=refine3D pgrp=c4 mskdiam=175 nparts=4 nthr=20 maxits=10 refine=neigh objfun=euclid nonuniform=yes sigma_est=global continue=yes mskfile=6_automask/automask.mrc combine_eo=yes projfile=5_refine3D/trpv1.simple &
wait
echo "------------- 10 ---------------------"