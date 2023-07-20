module simple_commander_test_bgal_refine3D
    include 'simple_lib.f08'
    use simple_cmdline,              only: cmdline
    use simple_commander_base,       only: commander_base
    use simple_cmdline,              only: cmdline
    use simple_commander_project,    only: new_project_commander, import_particles_commander
    use simple_commander_cluster2D,  only: cluster2D_autoscale_commander
    use simple_commander_preprocess, only: map_cavgs_selection_commander
    use simple_commander_abinitio,   only: initial_3Dmodel_commander

    implicit none
    type(cmdline) :: new_project_cline, import_particles_cline, cluster2D_cline, map_cavgs_selection_cline
    type(cmdline) :: initial_3Dmodel_cline
    type(new_project_commander)         :: new_project_com
    type(import_particles_commander)    :: import_particles_com
    type(cluster2D_autoscale_commander) :: cluster2D_com 
    type(map_cavgs_selection_commander) :: map_cavgs_selection_com
    type(initial_3Dmodel_commander)     :: initial_3Dmodel_com
    character(len=LONGSTRLEN)           :: cwd=''

    public :: test_bgal_refine3D_commander

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
        call import_particles_cline%set('prg',    'import_particles')
        call import_particles_cline%set('deftab', '/mnt/beegfs/elmlund/testbench/bgal/deftab.txt')
        call import_particles_cline%set('stk',    '/mnt/beegfs/elmlund/testbench/bgal/sumstack.mrc')
        call import_particles_cline%set('cs',     2.7)
        call import_particles_cline%set('fraca',  0.1)
        call import_particles_cline%set('kv',     300.)
        call import_particles_cline%set('projfile', 'bgal.simple')
        call import_particles_cline%set('smpd',   1.275)

        ! cluster2D..............
        cluster2D_cline = cline

        call cluster2D_cline%delete('smpd')
        call cluster2D_cline%set('prg',     'cluster2D')
        call cluster2D_cline%set('ncls',    90.)
        call cluster2D_cline%set('mskdiam', 180.)
        call cluster2D_cline%set('nparts',  4.)
        call cluster2D_cline%set('nthr',    20.)
        !call cluster2D_cline%set('split_mode', 'even') !test
        call cluster2D_cline%set('objfun',  'euclid')
        call cluster2D_cline%set('projfile', '1_import_particles/bgal.simple')

        ! map cavgs selection..............
        map_cavgs_selection_cline = cline

        call map_cavgs_selection_cline%delete('smpd')
        call map_cavgs_selection_cline%set('prg',  'map_cavgs_selection')
        call map_cavgs_selection_cline%set('stk2', '2_cluster2D/cavgs_iter016_ranked.mrc')
        !call map_cavgs_selection_cline%set('split_mode', 'even') !test
        call map_cavgs_selection_cline%set('ares', 41.)
        call map_cavgs_selection_cline%printline() !CHECK
        
        ! execution of the above commands
        call new_project_com%execute(new_project_cline)
        call import_particles_com%execute(import_particles_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call cluster2D_com%execute(cluster2D_cline)

        call simple_getcwd(cwd)
        call simple_chdir( trim(cwd)//"/../", errmsg="")
        call map_cavgs_selection_com%execute(map_cavgs_selection_cline)        

    end subroutine exec_test_bgal_refine3D

end module simple_commander_test_bgal_refine3D

!simple_exec prg=test_bgal_refine3D