!==============================================================================!
  subroutine Grid_Mod_Exchange_Cells_Int(grid, phi)
!------------------------------------------------------------------------------!
!   Exchanges the values of a cell-based integer array between the processors. !
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  type(Grid_Type) :: grid
  integer         :: phi(-grid % n_bnd_cells:grid % n_cells)
!-----------------------------------[Locals]-----------------------------------!
  integer :: ln, c1, c2, len_s, len_r, sub
!==============================================================================!

  ! Fill the buffers with new values
  do sub = 1, n_proc
    len_s = grid % comm % cells_send(sub) % n_items
    do ln = 1, len_s
      c1 = grid % comm % cells_send(sub) % map(ln)
      grid % comm % cells_send(sub) % i_buff(ln) = phi(c1)
    end do
  end do

  ! Exchange the values
  do sub = 1, n_proc
    len_s = grid % comm % cells_send(sub) % n_items
    len_r = grid % comm % cells_recv(sub) % n_items
    if(len_s + len_r > 0) then
      call Comm_Mod_Sendrecv_Int_Arrays(            &
        grid % comm % cells_send(sub) % i_buff(1),  &  ! array to be sent
        len_s,                                      &  ! sending length
        grid % comm % cells_recv(sub) % i_buff(1),  &  ! array to be received
        len_r,                                      &  ! receiving length
        sub)                                           ! destination processor
    end if
  end do

  ! Fill the buffers with new values
  do sub = 1, n_proc
    len_r = grid % comm % cells_recv(sub) % n_items
    do ln = 1, len_r
      c2 = grid % comm % cells_recv(sub) % map(ln)
      phi(c2) = grid % comm % cells_recv(sub) % i_buff(ln)
    end do
  end do

  end subroutine
