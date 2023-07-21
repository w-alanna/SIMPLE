module simple_commander_testing
    include 'simple_lib.f08'
    use simple_cmdline,        only: cmdline
    use simple_commander_base, only: commander_base

    implicit none

    public :: testing_commander

    type, extends(commander_base) :: testing_commander
        contains
        procedure :: execute => exec_testing_commander
    end type testing_commander

    contains

    subroutine exec_testing_commander(self, cline)
        class(testing_commander), intent(inout) :: self
        class(cmdline),                 intent(inout) :: cline

        print*, ' the commander is working!!!'

    end subroutine exec_testing_commander


end module simple_commander_testing