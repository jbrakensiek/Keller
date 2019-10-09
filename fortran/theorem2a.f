       program theorem2a

*      The output of the executable goes into 'file'

       integer vect(125,3),adj(125,125),v(125)
       integer coord1(125),coord2(125),coord3(125)

       icount=0
       do 10 i1=-2,2
       do 20 i2=-2,2
       do 30 i3=-2,2
       icount=icount+1
       v(icount)=1
       if(i1.eq.-1 .or. i1.eq.1) v(icount)=v(icount)*2
       if(i1.eq.0) v(icount)=v(icount)*3
       if(i2.eq.-1 .or. i2.eq.1) v(icount)=v(icount)*2
       if(i2.eq.0) v(icount)=v(icount)*3
       if(i3.eq.-1 .or. i3.eq.1) v(icount)=v(icount)*2
       if(i3.eq.0) v(icount)=v(icount)*3
       vect(icount,1)=i1
       vect(icount,2)=i2
       vect(icount,3)=i3
       coord1(icount)=i1
       coord2(icount)=i2
       coord3(icount)=i3
30     continue
20     continue
10     continue

       do 50 i=1,125
       do 60 j=1,125
       adj(i,j)=0
       if(vect(i,1)*vect(j,1).eq.-2) adj(i,j)=1
       if(vect(i,2)*vect(j,2).eq.-2) adj(i,j)=1
       if(vect(i,3)*vect(j,3).eq.-2) adj(i,j)=1
60     continue
50     continue

       icount=0
       do 71 i1=1,125
       if(v(i1).eq.27) then
       if(i1.eq.94) then
       icount=icount+1 
       print*,"1"
       print*," "
*      print*,coord1(i1),coord2(i1),coord3(i1)
       print*,i1
       print*," "
       endif
       endif

       do 72 i2=i1+1,125
       if(adj(i1,i2).eq.0) goto 72
       if(v(i1)+v(i2).eq.27) then
       if(i1.eq.94.or.i2.eq.94) then
       icount=icount+1 
       print*,"2"
       print*," "
       print*,i1
       print*,i2
*      print*,coord1(i1),coord2(i1),coord3(i1)
*      print*,coord1(i2),coord2(i2),coord3(i2)
       print*," "
       endif
       endif

       do 73 i3=i2+1,125
       if(adj(i1,i3).eq.0) goto 73
       if(adj(i2,i3).eq.0) goto 73
       if(v(i1)+v(i2)+v(i3).eq.27) then
       if(i1.eq.94.or.i2.eq.94.or.i3.eq.94) then
       icount=icount+1 
       print*,"3"
       print*," "
       print*,i1
       print*,i2
       print*,i3
*      print*,coord1(i1),coord2(i1),coord3(i1)
*      print*,coord1(i2),coord2(i2),coord3(i2)
*      print*,coord1(i3),coord2(i3),coord3(i3)
       print*," "
       endif
       endif

       do 74 i4=i3+1,125
       if(adj(i1,i4).eq.0) goto 74
       if(adj(i2,i4).eq.0) goto 74
       if(adj(i3,i4).eq.0) goto 74
       if(v(i1)+v(i2)+v(i3)+v(i4).eq.27) then
       if(i1.eq.94.or.i2.eq.94.or.i3.eq.94.or.i4.eq.94) then
       icount=icount+1 
       print*,"4"
       print*," "
       print*,i1
       print*,i2
       print*,i3
       print*,i4
*      print*,coord1(i1),coord2(i1),coord3(i1)
*      print*,coord1(i2),coord2(i2),coord3(i2)
*      print*,coord1(i3),coord2(i3),coord3(i3)
*      print*,coord1(i4),coord2(i4),coord3(i4)
       print*," "
       endif
       endif

       do 75 i5=i4+1,125
       if(adj(i1,i5).eq.0) goto 75
       if(adj(i2,i5).eq.0) goto 75
       if(adj(i3,i5).eq.0) goto 75
       if(adj(i4,i5).eq.0) goto 75
       if(v(i1)+v(i2)+v(i3)+v(i4)+v(i5).eq.27) then
       if(i1.eq.94.or.i2.eq.94.or.i3.eq.94.or.i4.eq.94
     c .or.i5.eq.94) then
       icount=icount+1 
       print*,"5"
       print*," "
       print*,i1
       print*,i2
       print*,i3
       print*,i4
       print*,i5
*      print*,coord1(i1),coord2(i1),coord3(i1)
*      print*,coord1(i2),coord2(i2),coord3(i2)
*      print*,coord1(i3),coord2(i3),coord3(i3)
*      print*,coord1(i4),coord2(i4),coord3(i4)
*      print*,coord1(i5),coord2(i5),coord3(i5)
       print*," "
       endif
       endif

       do 76 i6=i5+1,125
       if(adj(i1,i6).eq.0) goto 76
       if(adj(i2,i6).eq.0) goto 76
       if(adj(i3,i6).eq.0) goto 76
       if(adj(i4,i6).eq.0) goto 76
       if(adj(i5,i6).eq.0) goto 76
       if(v(i1)+v(i2)+v(i3)+v(i4)+v(i5)+v(i6).eq.27) then
       if(i1.eq.94.or.i2.eq.94.or.i3.eq.94.or.i4.eq.94
     c .or.i5.eq.94.or.i6.eq.94) then
       icount=icount+1 
       print*,"6"
       print*," "
       print*,i1
       print*,i2
       print*,i3
       print*,i4
       print*,i5
       print*,i6
*      print*,coord1(i1),coord2(i1),coord3(i1)
*      print*,coord1(i2),coord2(i2),coord3(i2)
*      print*,coord1(i3),coord2(i3),coord3(i3)
*      print*,coord1(i4),coord2(i4),coord3(i4)
*      print*,coord1(i5),coord2(i5),coord3(i5)
*      print*,coord1(i6),coord2(i6),coord3(i6)
       print*," "
       endif
       endif

       do 77 i7=i6+1,125
       if(adj(i1,i7).eq.0) goto 77
       if(adj(i2,i7).eq.0) goto 77
       if(adj(i3,i7).eq.0) goto 77
       if(adj(i4,i7).eq.0) goto 77
       if(adj(i5,i7).eq.0) goto 77
       if(adj(i6,i7).eq.0) goto 77
       if(v(i1)+v(i2)+v(i3)+v(i4)+v(i5)+v(i6)+v(i7).eq.27) then
       if(i1.eq.94.or.i2.eq.94.or.i3.eq.94.or.i4.eq.94
     c .or.i5.eq.94.or.i6.eq.94.or.i7.eq.94) then
       icount=icount+1 
       print*,"7"
       print*," "
       print*,i1
       print*,i2
       print*,i3
       print*,i4
       print*,i5
       print*,i6
       print*,i7
*      print*,coord1(i1),coord2(i1),coord3(i1)
*      print*,coord1(i2),coord2(i2),coord3(i2)
*      print*,coord1(i3),coord2(i3),coord3(i3)
*      print*,coord1(i4),coord2(i4),coord3(i4)
*      print*,coord1(i5),coord2(i5),coord3(i5)
*      print*,coord1(i6),coord2(i6),coord3(i6)
*      print*,coord1(i7),coord2(i7),coord3(i7)
       print*," "
       endif
       endif

       do 78 i8=i7+1,125
       if(adj(i1,i8).eq.0) goto 78
       if(adj(i2,i8).eq.0) goto 78
       if(adj(i3,i8).eq.0) goto 78
       if(adj(i4,i8).eq.0) goto 78
       if(adj(i5,i8).eq.0) goto 78
       if(adj(i6,i8).eq.0) goto 78
       if(adj(i7,i8).eq.0) goto 78
       if(v(i1)+v(i2)+v(i3)+v(i4)+v(i5)+v(i6)+v(i7)
     c +v(i8).eq.27) then
       if(i1.eq.94.or.i2.eq.94.or.i3.eq.94.or.i4.eq.94
     c .or.i5.eq.94.or.i6.eq.94.or.i7.eq.94.or.i8.eq.94) then
       icount=icount+1 
       print*,"8"
       print*," "
       print*,i1
       print*,i2
       print*,i3
       print*,i4
       print*,i5
       print*,i6
       print*,i7
       print*,i8
*      print*,coord1(i1),coord2(i1),coord3(i1)
*      print*,coord1(i2),coord2(i2),coord3(i2)
*      print*,coord1(i3),coord2(i3),coord3(i3)
*      print*,coord1(i4),coord2(i4),coord3(i4)
*      print*,coord1(i5),coord2(i5),coord3(i5)
*      print*,coord1(i6),coord2(i6),coord3(i6)
*      print*,coord1(i7),coord2(i7),coord3(i7)
*      print*,coord1(i8),coord2(i8),coord3(i8)
       print*," "
       endif
       endif

78     continue
77     continue
76     continue
75     continue
74     continue
73     continue
72     continue
71     continue

       print*,icount

       end
