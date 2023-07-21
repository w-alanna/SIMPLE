program simple_test_refine3D
    include 'simple_lib.f08'
    use simple_image,                only: image
    use simple_commander_project,    only: new_project_commander, import_particles_commander
    use simple_cmdline,              only: cmdline
    use simple_commander_cluster2D,  only: cluster2D_autoscale_commander !new
    use simple_commander_preprocess, only: map_cavgs_selection_commander
    use simple_commander_abinitio,   only: initial_3Dmodel_commander
    use simple_commander_refine3D,   only: refine3D_commander !new
    use simple_parameters,           only: params_glob
    implicit none
    type(new_project_commander)         :: new_project_com
    type(import_particles_commander)    :: import_particles_com
    type(cluster2D_autoscale_commander) :: cluster2D_com !new
    type(map_cavgs_selection_commander) :: map_cavgs_selection_com
    type(initial_3Dmodel_commander)     :: initial_3Dmodel_com
    type(refine3D_commander)            :: refine3D_com !new
    
    type(cmdline)                    :: new_project_cline, cline, import_particles_cline, cluster2D_cline, map_cavgs_selection_cline
    type(cmdline)                    :: initial_3Dmodel_cline, refine3D_cline
    character(len=LONGSTRLEN)        :: cwd=''
    if( command_argument_count() < 2 )then
        write(logfhandle,'(a)') 'Usage: simple_test_refine3D nparts=xx nthr=yy'
        stop
    else
        call cline%parse_oldschool
    endif
    call cline%checkvar('nparts', 1)
    call cline%checkvar('nthr',   2)
    call cline%printline() !CHECK

    !---------- bgal dataset -----------------
    ! new project
    new_project_cline = cline
    call new_project_cline%set('projname', 'bgal')
    call new_project_cline%printline() !CHECK
    !call simple_getcwd(cwd)
    
    ! import particles...............
    import_particles_cline = cline
    call import_particles_cline%delete('smpd')
    call import_particles_cline%set('prg',    'import_particles')
    call import_particles_cline%set('deftab', '/mnt/beegfs/elmlund/testbench/bgal/deftab.txt')
    call import_particles_cline%set('stk',    '/mnt/beegfs/elmlund/testbench/bgal/sumstack.mrc')
    call import_particles_cline%set('cs',     2.7)
    call import_particles_cline%set('fraca',  0.1)
    call import_particles_cline%set('kv',     300.)
    call import_particles_cline%set('projfile', 'bgal.simple')
    call import_particles_cline%set('smpd',   1.275)
    !call import_particles_cline%set('split_mode', 'even')
    call import_particles_cline%printline() !CHECK

    ! cluster2D..............
    cluster2D_cline = cline

    call cluster2D_cline%delete('smpd')
    call cluster2D_cline%set('prg',     'cluster2D')
    call cluster2D_cline%set('ncls',    90.)
    !call cluster2D_cline%set('smpd',    1.275)
    call cluster2D_cline%set('mskdiam', 180.)
    call cluster2D_cline%set('nparts',  4.)
    call cluster2D_cline%set('nthr',    20.)
    call cluster2D_cline%set('split_mode', 'even') !test
    call cluster2D_cline%set('objfun',  'euclid')
    !call cluster2D_cline%set('mkdir',   'yes')
    call cluster2D_cline%set('projfile', '1_import_particles/bgal.simple')
    call cluster2D_cline%printline() !CHECK

    ! map cavgs selection..............
    map_cavgs_selection_cline = cline

    call map_cavgs_selection_cline%delete('smpd')
    call map_cavgs_selection_cline%set('prg',  'map_cavgs_selection')
    call map_cavgs_selection_cline%set('stk2', '2_cluster2D/cavgs_iter016.mrc') !2_cluster2D/cavgs_iter016_ranked.mrc
    call map_cavgs_selection_cline%set('split_mode', 'even') !test
    call map_cavgs_selection_cline%set('ares', 41.)
    call map_cavgs_selection_cline%printline() !CHECK

    !intial3D model................
    initial_3Dmodel_cline = cline

    !there is a math error; Program received signal SIGFPE: Floating-point exception - erroneous arithmetic operation.
    call initial_3Dmodel_cline%delete('smpd')
    call initial_3Dmodel_cline%set('prg',     'initial_3Dmodel')
    call initial_3Dmodel_cline%set('smpd',    1.275)
    call initial_3Dmodel_cline%set('pgrp',    'd2')
    call initial_3Dmodel_cline%set('mskdiam',  180.)
    call initial_3Dmodel_cline%set('nthr',     40.)
    call initial_3Dmodel_cline%set('projfile', '3_selection/bgal.simple')
    call initial_3Dmodel_cline%printline() !CHECK

    ! refine3D ..........
    !refine3D_cline = cline

    !call simple_getcwd(cwd)
    !call simple_chdir( trim(cwd)//"/../", errmsg="")

    !call refine3D_cline%delete('smpd')
    !call refine3D_cline%set('prg', 'refine3D')
    !call refine3D_cline%set('pgrp', 'd2')
    !call refine3D_cline%set('mskdiam', 180.)
    !call refine3D_cline%set('nparts', 4.) (exclude this; only for ..distr)
    !call refine3D_cline%set('nthr', 20.)
    !call refine3D_cline%set('maxits', 10.)
    !call refine3D_cline%set('refine', 'neigh')
    !call refine3D_cline%set('objfun', 'euclid')
    !call refine3D_cline%set('nonuniform', 'yes')
    !call refine3D_cline%set('sigma_est', 'global')
    !call refine3D_com%execute(refine3D_cline)

    ! automask .......

    ! refine3D ........
    
    ! actual execuation of the above commands
    call new_project_com%execute(new_project_cline)
    call import_particles_com%execute(import_particles_cline)

    call simple_getcwd(cwd)
    call simple_chdir( trim(cwd)//"/../", errmsg="")
    !params_glob%split_mode = 'even'
    call cluster2D_com%execute(cluster2D_cline)

    call simple_getcwd(cwd)
    call simple_chdir( trim(cwd)//"/../", errmsg="")

    call map_cavgs_selection_com%execute(map_cavgs_selection_cline)

    call simple_getcwd(cwd)
    call simple_chdir( trim(cwd)//"/../", errmsg="")

   ! call initial_3Dmodel_com%execute(initial_3Dmodel_cline)
end program simple_test_refine3D
