!> \file gw_coalescence_pmax.f90  Calculates the maximum initial period that can be brought to 0 within a certain time

!***********************************************************************************************************************************
program gwpmax    
  use SUFR_kinds, only: double
  use SUFR_constants, only: set_SUFR_constants, c3rd,pi2, pc_g,pc_c, msun, solday,julyear
  
  implicit none
  real(double) :: m1,m2,per,time,cst
  character :: tmpstr*(99)
  
  if(command_argument_count().eq.3) then
     call get_command_argument(1, tmpstr)
     read(tmpstr,*) M1
     call get_command_argument(2, tmpstr)
     read(tmpstr,*) M2
     call get_command_argument(3, tmpstr)
     read(tmpstr,*) time
  else
     write(*,'(/,A)')'  This program calculates the maximum initial period that can converge (to 0) due to GWs within a '// &
          'certain time'
     write(6,'(A,/)')'  Syntax: gw_coalescence_pmax  <M1> <M2> <time>  (Mo and Gyr)'
     stop
  end if
  
  call set_SUFR_constants()
  
  cst = 5.d0/256.d0 * pi2**(-8*c3rd) * pc_c**5/pc_g**(5*c3rd) * (m1+m2)**(c3rd) / (m1*m2*msun**(5*c3rd))
  
  per = (time*1.d9*julyear/cst)**0.375d0/solday
  
  write(6,'(/,A,1p,G13.5,A5,/)') '  Maximum initial period for convergence:',per,'days'
  
end program gwpmax
!***********************************************************************************************************************************