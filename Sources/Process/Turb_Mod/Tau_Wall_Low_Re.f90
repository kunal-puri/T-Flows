!==============================================================================!
  real function Tau_Wall_Low_Re(turb, dens, u_tau, u_tan, y_plus)
!------------------------------------------------------------------------------!
!   Calculates tau_wall for low Reynolds approach.                             !
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Const_Mod, only: TINY
  use Turb_Mod,  only: Turb_Type, kappa, e_log
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  type(Turb_Type) :: turb
  real            :: dens, u_tau, u_tan, y_plus
!==============================================================================!

  Tau_Wall_Low_Re = dens * kappa * u_tau * u_tan   &
                  / log(e_log * max(y_plus, 1.05))

  end function
