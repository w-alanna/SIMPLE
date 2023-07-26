module simple_commander_test_bgal_refine3D
    include 'simple_lib.f08'
    use simple_cmdline,              only: cmdline
    use simple_commander_base,       only: commander_base
    use simple_commander_project,    only: new_project_commander, import_particles_commander
    use simple_commander_cluster2D,  only: cluster2D_autoscale_commander
    use simple_commander_preprocess, only: map_cavgs_selection_commander
    use simple_commander_abinitio,   only: initial_3Dmodel_commander
    use simple_commander_refine3D,   only: refine3D_commander_distr
    use simple_commander_mask,       only: automask_commander

    implicit none
    type(cmdline) :: new_project_cline, import_particles_cline, cluster2D_cline, map_cavgs_selection_cline
    type(cmdline) :: initial_3Dmodel_cline, refine3D_cline, automask_cline, refine3D_two_cline
    type(new_project_commander)         :: new_project_com
    type(import_particles_commander)    :: import_particles_com
    type(cluster2D_autoscale_commander) :: cluster2D_com 
    type(map_cavgs_selection_commander) :: map_cavgs_selection_com
    type(initial_3Dmodel_commander)     :: initial_3Dmodel_com
    type(refine3D_commander_distr)      :: refine3D_com, refine3D_two_com 
    type(automask_commander)            :: automask_com
    character(len=LONGSTRLEN)           :: cwd=''

    public :: test_bgal_refine3D_commander
    private

    type, extends(commander_base) :: test_bgal_refine3D_commander
        contains
        procedure :: execute      => exec_test_bgal_refine3D
    end type test_bgal_refine3D_commander

    contains

    subroutine exec_test_bgal_refine3D(self, cline)
        class(test_bgal_refine3D_commander), intent(inout) :: self
        class(cmdline),                      intent(inout) :: cline
        ! new project
        new_project_cline = cline
        call new_project_cline%set('prg',      'new_project')
        call new_project_cline%set('projname', 'bgal')

        ! import particles...............
        import_particles_cline = cline

        call import_particles_cline%delete('smpd')
        call import_particles_cline%set('prg',      'import_particles')
        call import_particles_cline%set('deftab',   '/mnt/beegfs/elmlund/testbench/bgal/deftab.txt')
        call import_particles_cline%set('stk',      '/mnt/beegfs/elmlund/testbench/bgal/sumstack.mrc')
        call import_particles_cline%set('cs',        2.7)
        call import_particles_cline%set('fraca',     0.1)
        call import_particles_cline%set('kv',        300.)
        call import_particles_cline%set('projfile', 'bgal.simple')
        call import_particles_cline%set('smpd',      1.275)

        ! cluster2D..............
        cluster2D_cline = cline

        call cluster2D_cline%delete('smpd')
        call cluster2D_cline%set('prg',      'cluster2D')
        call cluster2D_cline%set('ncls',      90.)
        call cluster2D_cline%set('mskdiam',   180.)
        call cluster2D_cline%set('nparts',    4.)
        call cluster2D_cline%set('nthr',      20.)
        call cluster2D_cline%set('objfun',   'euclid')
        call cluster2D_cline%set('projfile', '1_import_particles/bgal.simple')

        ! map cavgs selection..............
        map_cavgs_selection_cline = cline

        call map_cavgs_selection_cline%delete('smpd')
        call map_cavgs_selection_cline%set('prg',  'map_cavgs_selection')
        call map_cavgs_selection_cline%set('stk2', '2_cluster2D/cavgs_iter016_ranked.mrc')
        call map_cavgs_selection_cline%set('ares',  41.)

        ! intial3D model................
        initial_3Dmodel_cline = cline
        !LOW-PASS LIMIT FOR ALIGNMENT:   15.0 ANGSTROMS
        !WARNING! Mask diameter too large, falling back on default value; simple_parameters.f90; line:  1203
        call initial_3Dmodel_cline%delete('smpd')
        call initial_3Dmodel_cline%set('prg',      'initial_3Dmodel')
        call initial_3Dmodel_cline%set('pgrp',     'd2')
        call initial_3Dmodel_cline%set('mskdiam',   180.)
        call initial_3Dmodel_cline%set('nparts',    4.)
        call initial_3Dmodel_cline%set('smpd',      1.275)
        call initial_3Dmodel_cline%set('nthr',      40.)
        call initial_3Dmodel_cline%set('projfile', '3_selection/bgal.simple')

        ! refine3D.....................
        refine3D_cline = cline
        
        call refine3D_cline%delete('smpd')
        call refine3D_cline%set('prg',        'refine3D')
        call refine3D_cline%set('pgrp',       'd2')
        call refine3D_cline%set('mskdiam',     180.)
        call refine3D_cline%set('nparts',      4.)
        call refine3D_cline%set('split_mode', 'even')
        call refine3D_cline%set('nthr',        20.)
        call refine3D_cline%set('maxits',      10.)
        call refine3D_cline%set('refine',     'neigh')
        call refine3D_cline%set('objfun',     'euclid')
        call refine3D_cline%set('nonuniform', 'yes')
        call refine3D_cline%set('sigma_est',  'global')
        

        ! automask....................
        automask_cline = cline

        call automask_cline%delete('smpd')
        call automask_cline%set('prg',     'automask')
        call automask_cline%set('mskdiam',  180.)
        call automask_cline%set('amsklp',   12.)
        call automask_cline%set('mw',       465.)
        call automask_cline%set('thres',    0.012)
        call automask_cline%set('nthr',     20.)
        call automask_cline%set('vol1',    '5_refine3D/recvol_state01_iter010_lp.mrc')
        call automask_cline%set('smpd',     1.275)

        ! refine3D .......................
        refine3D_two_cline = cline

        call refine3D_two_cline%delete('smpd')
        call refine3D_two_cline%set('prg',        'refine3D')
        call refine3D_two_cline%set('pgrp',       'd2')
        call refine3D_two_cline%set('mskdiam',     180.)
        call refine3D_two_cline%set('nparts',      4.)
        call refine3D_two_cline%set('nthr',        20.)
        call refine3D_two_cline%set('maxits',      10.)
        call refine3D_two_cline%set('refine',     'neigh')
        call refine3D_two_cline%set('objfun',     'euclid')
        call refine3D_two_cline%set('ml_reg',     'no')
        call refine3D_two_cline%set('nonuniform', 'yes')
        call refine3D_two_cline%set('sigma_est',  'global')
        call refine3D_two_cline%set('continue',   'yes')
        call refine3D_two_cline%set('mskfile',    '6_automask/automask.mrc')
        call refine3D_two_cline%set('combine_eo', 'yes')
        call refine3D_two_cline%set('projfile',   '5_refine3D/bgal.simple')

        ! execution of the above commands..........................
        call new_project_com%execute(new_project_cline)
        call import_particles_com%execute(import_particles_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call cluster2D_com%execute(cluster2D_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call map_cavgs_selection_com%execute(map_cavgs_selection_cline) 
        
        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call initial_3Dmodel_com%execute(initial_3Dmodel_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call refine3D_com%execute(refine3D_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call automask_com%execute(automask_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call refine3D_two_com%execute(refine3D_two_cline)

    end subroutine exec_test_bgal_refine3D

end module simple_commander_test_bgal_refine3D

!simple_exec prg=test_bgal_refine3D