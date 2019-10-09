       program threecovtest

       integer vect(125,3),perm(6,3),aut(6,2,2,2,125)
       integer number(10000),store(10000,8),temp(8) 
       integer coord1(125),coord2(125),coord3(125)
       integer m(2,-2:2)
       integer cube(0:4,0:4,0:4)

*      '3cov' is the output of theorem2a.f + Brakensiek's covers
       open(unit=7,file='3cov')

       icount=0
       do 10 i1=-2,2
       do 12 i2=-2,2
       do 14 i3=-2,2
       icount=icount+1
       cube(i1+2,i2+2,i3+2)=icount
       vect(icount,1)=i1
       vect(icount,2)=i2
       vect(icount,3)=i3
       coord1(icount)=i1
       coord2(icount)=i2
       coord3(icount)=i3
14     continue
12     continue
10     continue

       icount=0
       do 20 i1=1,3
       do 22 i2=1,3
       do 24 i3=1,3

       if(i1.eq.i2) goto 24
       if(i1.eq.i3) goto 24
       if(i2.eq.i3) goto 24

       icount=icount+1
       perm(icount,1)=i1
       perm(icount,2)=i2
       perm(icount,3)=i3

24     continue
22     continue
20     continue

       m(1,-2)=-2
       m(1,-1)=-1
       m(1,0)=0
       m(1,1)=1
       m(1,2)=2

       m(2,-2)=-2
       m(2,-1)=2
       m(2,0)=0
       m(2,1)=1
       m(2,2)=-1

       do 40 k=1,6
       do 41 i1=1,2
       do 42 i2=1,2
       do 43 i3=1,2
       do 44 i=1,125
       do 46 j=1,125
  
       if(m(i1,vect(i,1)).ne.vect(j,perm(k,1))) goto 46
       if(m(i2,vect(i,2)).ne.vect(j,perm(k,2))) goto 46
       if(m(i3,vect(i,3)).ne.vect(j,perm(k,3))) goto 46

       aut(k,i1,i2,i3,i)=j

46     continue
44     continue
43     continue
42     continue
41     continue
40     continue

       icount=0
       do 50 idummy=1,522

       if(idummy.le.455) then
       read(7,*) numblocks
       do 52 i=1,numblocks
       read(7,*) temp(i)
52     continue
       endif

       if(idummy.gt.455) then
       read(7,*) numblocks
       do 53 i=1,numblocks
       read(7,999) ii1,ii2,ii3
999    format(3i1)
       temp(i)=cube(ii1,ii2,ii3)
53     continue
       endif

       do 54 n=1,icount
       if(numblocks.ne.number(n)) goto 54

       do 55 k=1,6
       do 71 i1=1,2
       do 72 i2=1,2
       do 73 i3=1,2

       do 57 i=1,numblocks
       do 58 j=1,numblocks
       if(aut(k,i1,i2,i3,temp(i)).eq.store(n,j)) goto 57
58     continue
       goto 73
57     continue

       goto 50

73     continue
72     continue
71     continue
55     continue

54     continue

       icount=icount+1
       number(icount)=numblocks
       do 59 i=1,numblocks
       store(icount,i)=temp(i)
59     continue 

50     continue 

       print*,icount
       print*,' '

       do 100 iii=4,20
       do 60 i=1,icount
       if(number(i).eq.iii) then
       print*,number(i)
       print*," "
       do 62 j=1,number(i)
       print*,vect(store(i,j),1),vect(store(i,j),2),
     c vect(store(i,j),3)
62     continue 
       print*,' '
       endif
60     continue
100    continue

       end
