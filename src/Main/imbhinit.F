      SUBROUTINE IMBHINIT
*
*      
*     Initialization of massive black hole
*
      INCLUDE 'common6.h'
      REAL*8 XIMBH(3),VIMBH(3)
      
*     Read massive black hole mass and output time interval
*     BIMBH: criterion to reduce the step (Solar mass)
*     DTBH: data output time interview (NB unit)
      if(rank.eq.0) READ (5,*) BIMBH, DTBH, NIMBH

#ifdef PARALLEL
      CALL MPI_BCAST(BIMBH,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
*      CALL MPI_BCAST(XIMBH,3,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
*      CALL MPI_BCAST(VIMBH,3,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
      CALL MPI_BCAST(DTBH,1,MPI_REAL8,0,MPI_COMM_WORLD,ierr)
#endif      

*     Reset mass of particle N, treat N as IMBH
      BIMBH = BIMBH/ZMBAR
      DO I = N,N-NIMBH,-1
         KSTAR(I) = 14
         TEV(I) = MAX(2*TCRIT,1000000.0)
      END DO
**     Store the name of massive black hole
**      NIMBH = N

*     Printing initial massive black hole data
*      IF(rank.eq.0) write(6,1) NIMBH,BIMBH,XIMBH(1:3),
*     &     VIMBH(1:3)
* 1    format('MBH Initialization:  NAME',I12,' M[M*]',E15.5,
*     &     ' X(1:3)[PC]',3E15.5,' V(1:3)[km/s]',3E15.5)
      
      RETURN
      
      END

***** Note:------------------------------------------------------------**
      
C      SUBROUTINE IMBHRESTART
C*
C*      
C*     Initialization of massive black hole
C*
C      INCLUDE 'common6.h'
C 
C*     Search index of massive black hole
C      IBH = 0
C      DO K = N,1,-1
C         IF (NAME(K).EQ.NIMBH) THEN
C            IBH = K
C            GO TO 10
C         END IF
C      END DO
C 
C      if(IBH.eq.0) then
C         if(rank.eq.0) print*,'BH not found! N',NIMBH
C         call flush(6)
C         call abort
C      end if
C 
C 10   BIMBH = BODY(IBH)*ZMBAR
C 
C*     Print massive black hole data
C      IF(rank.eq.0) write(6,1) IBH,NIMBH,BIMBH,X(1:3,IBH)*RBAR,
C     &     XDOT(1:3,IBH)*VSTAR
C 1    format('MBH: IBH',I12,' NAME',I12,' M[M*]',E15.5,
C     &     ' X(1:3)[PC]',3E15.5,' V(1:3)[km/s]',3E15.5)
C      call flush(6)
C 
C      RETURN
C 
C      END
