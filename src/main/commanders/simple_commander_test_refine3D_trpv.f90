module simple_commander_test_trpv_refine3D
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

    public :: test_refine3D_trpv_commander
    private

    type, extends(commander_base) :: test_refine3D_trpv_commander
        contains
        procedure :: execute      => exec_test_trpv_refine3D
    end type test_refine3D_trpv_commander

    contains

    subroutine exec_test_trpv_refine3D(self, cline)
        class(test_refine3D_trpv_commander), intent(inout) :: self
        class(cmdline),                      intent(inout) :: cline
        integer                                            :: loop
        integer                                            :: counting = 2 !keeps track of the step number
        real                                               :: cluster_sets = 20.
        character(len=24)                                  :: new_intital !for step 4
        character(len=25)                                  :: new_intital_more !for step 4 (counting > 1)
        character(len=30)                                  :: new_refine !step 5
        character(len=31)                                  :: new_refine_more !step 5
        character(len=40)                                  :: new_automask !step 6
        character(len=41)                                  :: new_automask_more !step 6
        character(len=23)                                  :: new_refineA !step 7
        character(len=24)                                  :: new_refineA_more !step 7
        character(len=23)                                  :: new_refineR !step 7
        character(len=24)                                  :: new_refineR_more !step 7

        
        
        ! new project
        new_project_cline = cline
        call new_project_cline%set('prg',      'new_project')
        call new_project_cline%set('projname', 'trpv1')

        ! import particles............
        import_particles_cline = cline

        call import_particles_cline%delete('smpd')
        call import_particles_cline%set('prg',    'import_particles')
        call import_particles_cline%set('ctf',    'flip')
        call import_particles_cline%set('deftab', '/mnt/beegfs/elmlund/testbench/trpv1/deftab.txt')
        call import_particles_cline%set('stk',    '/mnt/beegfs/elmlund/testbench/trpv1/flipnew.mrc')
        call import_particles_cline%set('cs',      2.0)
        call import_particles_cline%set('fraca',   0.100000001)
        call import_particles_cline%set('kv',      300.0)
        call import_particles_cline%set('smpd',    1.21560001)

        ! cluster2D............
        cluster2D_cline = cline

        call cluster2D_cline%delete('smpd')
        call cluster2D_cline%set('prg',       'cluster2D')
        call cluster2D_cline%set('ncls',       150.)
        call cluster2D_cline%set('mskdiam',    175.)
        call cluster2D_cline%set('nparts',     4.)
        call cluster2D_cline%set('nthr',       20.)
        call cluster2D_cline%set('projfile',  '1_import_particles/trpv1.simple')
        call cluster2D_cline%set('objfun',    'euclid')
        call cluster2D_cline%set('ml_reg',    'no')
        call cluster2D_cline%set('sigma_est', 'global')

        ! execution of new project - cluster2D ........................
        call new_project_com%execute(new_project_cline)
        call import_particles_com%execute(import_particles_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call cluster2D_com%execute(cluster2D_cline)
        ! end of execution ...................

        !START OF THE LOOP
        do loop= 1,2 
        
        ! selection ..................................
        map_cavgs_selection_cline = cline

        call map_cavgs_selection_cline%delete('smpd')
        call map_cavgs_selection_cline%set('prg',  'map_cavgs_selection')
        call map_cavgs_selection_cline%set('stk2', '2_cluster2D/cavgs_iter016_ranked.mrc')
        call map_cavgs_selection_cline%set('ares',  cluster_sets)
        ! end of selection .............................
        
        counting = counting + 1

        ! intial3D model.............
        initial_3Dmodel_cline = cline
        !WARNING! Mask diameter too large, falling back on default value; simple_parameters.f90;
        call initial_3Dmodel_cline%delete('smpd')
        call initial_3Dmodel_cline%set('prg',      'initial_3Dmodel')
        call initial_3Dmodel_cline%set('pgrp',     'c4')
        call initial_3Dmodel_cline%set('split_mode', 'even')
        call initial_3Dmodel_cline%set('mskdiam',   175.)
        call initial_3Dmodel_cline%set('nparts',    4.)
        call initial_3Dmodel_cline%set('nthr',      40.)
        call initial_3Dmodel_cline%set('smpd',      1.275)
        call initial_3Dmodel_cline%set('projfile',  'null')
        if (counting > 9) then
            write(new_intital_more, "(I2,A23)") counting, '_selection/trpv1.simple'
            call initial_3Dmodel_cline%set('projfile',  new_intital_more)
        else
            write(new_intital, "(I1,A23)") counting, '_selection/trpv1.simple'
            call initial_3Dmodel_cline%set('projfile',  new_intital)
        end if
        ! end of intital model ........................

        counting = counting + 1

        ! refine3D............
        !refine3D_cline = cline

        !call refine3D_cline%delete('smpd')
        !call refine3D_cline%set('prg',        'refine3D')
        !call refine3D_cline%set('pgrp',       'c4')
        !call refine3D_cline%set('mskdiam',     175.)
        !call refine3D_cline%set('nparts',      4.)
        !call refine3D_cline%set('split_mode', 'even')
        !call refine3D_cline%set('nthr',        20.)
        !call refine3D_cline%set('maxits',      10.)
        !call refine3D_cline%set('refine',     'neigh')
        !call refine3D_cline%set('objfun',     'euclid')
        !call refine3D_cline%set('nonuniform', 'yes')
        !call refine3D_cline%set('sigma_est',  'global')
        !if (counting > 9) then
         !   write(new_refine_more, "(I2,A29)") counting, '_initial_3Dmodel/trpv1.simple'
          !  call refine3D_cline%set('projfile', new_refine_more)
        !else
        !    write(new_refine, "(I1,A23)") counting, '_initial_3Dmodel/trpv1.simple'
        !    call refine3D_cline%set('projfile', new_refine)
        !end if
        ! end of refine3D ...................................

       ! counting = counting + 1

        ! automask..............................
        !automask_cline = cline

        !call automask_cline%delete('smpd')
        !call automask_cline%set('prg',     'automask')
        !call automask_cline%set('mskdiam',  175.)
        !call automask_cline%set('amsklp',   12.)
        !call automask_cline%set('mw',       400.)
        !call automask_cline%set('thres',    0.01)
        !call automask_cline%set('nthr',     20.)
        !if (counting > 9) then
        !    write(new_automask_more, "(I2,A39)") counting, '_refine3D/recvol_state01_iter010_lp.mrc'
        !    call automask_cline%set('vol1', new_automask_more)
        !else
        !    write(new_automask, "(I1,A39)") counting, '_refine3D/recvol_state01_iter010_lp.mrc'
        !    call automask_cline%set('vol1', new_automask)
        !end if
        !call automask_cline%set('smpd',     1.2156)
        ! end of automask .........................................

        !counting = counting + 1

        ! refine3D.....................................................
        !refine3D_two_cline = cline

        !call refine3D_two_cline%delete('smpd')
        !call refine3D_two_cline%set('prg',        'refine3D')
        !call refine3D_two_cline%set('pgrp',       'c4')
        !call refine3D_two_cline%set('mskdiam',     175.)
        !call refine3D_two_cline%set('nparts',      4.)
        !call refine3D_two_cline%set('nthr',        20.)
        !call refine3D_two_cline%set('maxits',      10.)
        !call refine3D_two_cline%set('refine',     'neigh')
        !call refine3D_two_cline%set('objfun',     'euclid')
        !call refine3D_two_cline%set('nonuniform', 'yes')
        !call refine3D_two_cline%set('sigma_est',  'global')
        !call refine3D_two_cline%set('continue',   'yes')
        !if (counting > 9) then
        !    write(new_refineA_more, "(I2,A22)") counting, '_automask/automask.mrc'
        !    call refine3D_two_cline%set('mskfile', new_refineA_more)
        !else
        !    write(new_refineA, "(I1,A22)") counting, '_automask/automask.mrc'
        !    call refine3D_two_cline%set('mskfile', new_refineA)
        !end if
        !counting = counting - 1 !*****needs to be here because _refine3D & _automask arean't the same number*****
        !call refine3D_two_cline%set('combine_eo', 'yes')
        !if (counting > 9) then
        !    write(new_refineR_more, "(I2,A23)") counting, '_refine3D/trpv1.simple'
        !    call refine3D_two_cline%set('projfile', new_refineR_more)
        !else
        !    write(new_refineR, "(I1,A23)") counting, '_refine3D/trpv1.simple'
        !    call refine3D_two_cline%set('projfile', new_refineR)
        !end if
        ! end of refine3D ...............................................

        !counting = counting + 2 !*****because of the -1 *****

        ! execution of selection - finish ..............................
        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call map_cavgs_selection_com%execute(map_cavgs_selection_cline) 
        
        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call initial_3Dmodel_com%execute(initial_3Dmodel_cline)

        !call simple_getcwd(cwd)
        !call simple_chdir( trim(cwd)//"/../", errmsg="")
        !call refine3D_com%execute(refine3D_cline)

        !call simple_getcwd(cwd)
        !call simple_chdir( trim(cwd)//"/../", errmsg="")
        !call automask_com%execute(automask_cline)

        !call simple_getcwd(cwd)
        !call simple_chdir( trim(cwd)//"/../", errmsg="")
        !call refine3D_two_com%execute(refine3D_two_cline)
        ! end of execution ..........................

        cluster_sets = cluster_sets + 20.
        end do
        !END OF THE LOOP

    end subroutine exec_test_trpv_refine3D

end module simple_commander_test_trpv_refine3D

!simple_exec prg=test_trpv_refine3D