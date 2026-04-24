! =============================================================================================
!       Author : Marco Fenucci 
!         Date : April 2026
!  Institution : ESA NEO Coordination Centre 
! =============================================================================================
module dust_module
   implicit none
   private
   ! For FORTRAN programming
   integer, parameter :: dkind=kind(1.d0)
   ! Mathematical Constants 
   real(kind=dkind), parameter :: pi = 4.d0*atan(1.d0) 
   real(kind=dkind), parameter :: duepi = 2.d0*pi
   real(kind=dkind), parameter :: deg2rad = pi/180.d0
   real(kind=dkind), parameter :: rad2deg = 180.d0/pi
   ! ===========================================
   ! Physical parameters: standard units [kg, m, s, K]
   ! ===========================================
   ! Astronomical Unit [m]
   real(kind=dkind), parameter :: AU   = 149597870700.d0
   real(kind=dkind), parameter :: au2m = AU
   real(kind=dkind), parameter :: m2au = 1.d0/AU
   ! Speed of light [m s^-1]
   real(kind=dkind), parameter :: clight = 299792458.d0
   ! Conversions
   real(kind=dkind), parameter :: h2s = 3600.d0
   real(kind=dkind), parameter :: s2h = 1.d0/h2s
   real(kind=dkind), parameter :: d2s = 24.d0*h2s
   real(kind=dkind), parameter :: s2d = 1.d0/d2s
   real(kind=dkind), parameter :: d2h = 24.d0
   real(kind=dkind), parameter :: h2d = 1.d0/d2h
   real(kind=dkind), parameter :: y2d = 365.25d0
   real(kind=dkind), parameter :: d2y = 1.d0/365.25d0
   real(kind=dkind), parameter :: y2s = 365.25d0*d2s
   real(kind=dkind), parameter :: s2y = 1.d0/y2s
   real(kind=dkind), parameter :: yr2my = 1.d-6
   real(kind=dkind), parameter :: my2yr = 1/yr2my
   real(kind=dkind), parameter :: s2my  = s2y*yr2my
   real(kind=dkind), parameter :: my2s  = 1.d0/s2my
   real(kind=dkind), parameter :: my2d  = my2yr*y2d 
   real(kind=dkind), parameter :: d2my  = 1.d0/my2d 
   ! For radiation force
   real(kind=dkind) :: rp_csi
   real(kind=dkind) :: rp_rho
   real(kind=dkind) :: rp_s
   real(kind=dkind) :: rp_QPR
   real(kind=dkind) :: rp_beta

   public :: h2s, s2h, d2s, s2d, y2d, d2y, y2s, s2y, yr2my, s2my, my2s, h2d, d2h, deg2rad, rad2deg, m2au
   public :: clight
   public :: rp_csi, rp_rho, rp_s, rp_QPR, rp_beta

end module dust_module

