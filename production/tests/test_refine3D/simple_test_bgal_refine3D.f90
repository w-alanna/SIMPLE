program simple_test_bgal_refine3D
    use simple_commander_test_bgal_refine3D
    implicit none
    
    type(test_bgal_refine3D_commander) :: test
    if( command_argument_count() /= 2 ) then
        write(logfhandle,'(a)') 'Usage: simple_test_bgal_refine3D nparts=xx nthr=yy'

    print*, "working..."
    
    call test%exec_test_bgal_refine3D()
end program simple_test_bgal_refine3D