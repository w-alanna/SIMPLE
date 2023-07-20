module simple_commander_test_refine3D
    include 'simple_lib.f08'
    use simple_cmdline,        only: cmdline
    use simple_commander_base, only: commander_base

    implicit none

    public :: test_refine3D_commander

    type, extends(commander_base) :: test_refine3D_commander
        contains
        procedure :: execute      => exec_test_refine3D
    end type test_refine3D_commander

    contains

    subroutine exec_test_refine3D(self, cline)
        class(test_refine3D_commander), intent(inout) :: self
        class(cmdline),                 intent(inout) :: cline
        print*, "commander is set"
    end subroutine exec_test_refine3D

end module simple_commander_test_refine3D