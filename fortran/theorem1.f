       program theorem1

       integer vect(181,5),adj(181,181),v(181)
       integer coord1(181),coord2(181),coord3(181),coord4(181)
       integer coord5(181)

       icount=0
       do 10 i1=-2,2
       do 20 i2=-2,2
       do 30 i3=-2,2
       do 40 i4=-2,2
       do 42 i5=-2,2
       ibar=0
       if(i1.eq.0)ibar=ibar+1
       if(i2.eq.0)ibar=ibar+1
       if(i3.eq.0)ibar=ibar+1
       if(i4.eq.0)ibar=ibar+1
       if(i5.eq.0)ibar=ibar+1
       if(ibar.lt.3) goto 42
       icount=icount+1
       v(icount)=1
       if(i1.eq.-1 .or. i1.eq.1) v(icount)=v(icount)*2
       if(i1.eq.0) v(icount)=v(icount)*3
       if(i2.eq.-1 .or. i2.eq.1) v(icount)=v(icount)*2
       if(i2.eq.0) v(icount)=v(icount)*3
       if(i3.eq.-1 .or. i3.eq.1) v(icount)=v(icount)*2
       if(i3.eq.0) v(icount)=v(icount)*3
       if(i4.eq.-1 .or. i4.eq.1) v(icount)=v(icount)*2
       if(i4.eq.0) v(icount)=v(icount)*3
       if(i5.eq.-1 .or. i5.eq.1) v(icount)=v(icount)*2
       if(i5.eq.0) v(icount)=v(icount)*3
       vect(icount,1)=i1
       vect(icount,2)=i2
       vect(icount,3)=i3
       vect(icount,4)=i4
       vect(icount,5)=i5
       coord1(icount)=i1
       coord2(icount)=i2
       coord3(icount)=i3
       coord4(icount)=i4
       coord5(icount)=i5
42     continue
40     continue
30     continue
20     continue
10     continue

       do 50 i=1,181
       do 60 j=1,181
       adj(i,j)=0
       if(vect(i,1)*vect(j,1).eq.-2) adj(i,j)=1
       if(vect(i,2)*vect(j,2).eq.-2) adj(i,j)=1
       if(vect(i,3)*vect(j,3).eq.-2) adj(i,j)=1
       if(vect(i,4)*vect(j,4).eq.-2) adj(i,j)=1
       if(vect(i,5)*vect(j,5).eq.-2) adj(i,j)=1
       isame=0
       if(vect(i,1).eq.vect(j,1)) isame=isame+1
       if(vect(i,2).eq.vect(j,2)) isame=isame+1
       if(vect(i,3).eq.vect(j,3)) isame=isame+1
       if(vect(i,4).eq.vect(j,4)) isame=isame+1
       if(vect(i,5).eq.vect(j,5)) isame=isame+1
       if(isame.eq.4) adj(i,j)=0 
60     continue
50     continue

       icount=0
       do 71 i1=1,181
       if(v(i1).eq.243) icount=icount+1 

       do 72 i2=i1+1,181
       if(adj(i1,i2).eq.0) goto 72
       if(v(i1)+v(i2).eq.243) icount=icount+1 

       do 73 i3=i2+1,181
       if(adj(i1,i3).eq.0) goto 73
       if(adj(i2,i3).eq.0) goto 73
       if(v(i1)+v(i2)+v(i3).eq.243) icount=icount+1 

       do 74 i4=i3+1,181
       if(adj(i1,i4).eq.0) goto 74
       if(adj(i2,i4).eq.0) goto 74
       if(adj(i3,i4).eq.0) goto 74
       if(v(i1)+v(i2)+v(i3)+v(i4).eq.243) icount=icount+1 

       do 75 i5=i4+1,181
       if(adj(i1,i5).eq.0) goto 75
       if(adj(i2,i5).eq.0) goto 75
       if(adj(i3,i5).eq.0) goto 75
       if(adj(i4,i5).eq.0) goto 75
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5).eq.243) icount=icount+1 

       do 76 i6=i5+1,181
       if(adj(i1,i6).eq.0) goto 76
       if(adj(i2,i6).eq.0) goto 76
       if(adj(i3,i6).eq.0) goto 76
       if(adj(i4,i6).eq.0) goto 76
       if(adj(i5,i6).eq.0) goto 76
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6).eq.243) icount=icount+1 

       do 77 i7=i6+1,181
       if(adj(i1,i7).eq.0) goto 77
       if(adj(i2,i7).eq.0) goto 77
       if(adj(i3,i7).eq.0) goto 77
       if(adj(i4,i7).eq.0) goto 77
       if(adj(i5,i7).eq.0) goto 77
       if(adj(i6,i7).eq.0) goto 77
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7).eq.243) icount=icount+1 

       do 78 i8=i7+1,181
       if(adj(i1,i8).eq.0) goto 78
       if(adj(i2,i8).eq.0) goto 78
       if(adj(i3,i8).eq.0) goto 78
       if(adj(i4,i8).eq.0) goto 78
       if(adj(i5,i8).eq.0) goto 78
       if(adj(i6,i8).eq.0) goto 78
       if(adj(i7,i8).eq.0) goto 78
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8).eq.243) icount=icount+1 

       do 79 i9=i8+1,181
       if(adj(i1,i9).eq.0) goto 79
       if(adj(i2,i9).eq.0) goto 79
       if(adj(i3,i9).eq.0) goto 79
       if(adj(i4,i9).eq.0) goto 79
       if(adj(i5,i9).eq.0) goto 79
       if(adj(i6,i9).eq.0) goto 79
       if(adj(i7,i9).eq.0) goto 79
       if(adj(i8,i9).eq.0) goto 79
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9).eq.243) icount=icount+1 

       do 80 i10=i9+1,181
       if(adj(i1,i10).eq.0) goto 80
       if(adj(i2,i10).eq.0) goto 80
       if(adj(i3,i10).eq.0) goto 80
       if(adj(i4,i10).eq.0) goto 80
       if(adj(i5,i10).eq.0) goto 80
       if(adj(i6,i10).eq.0) goto 80
       if(adj(i7,i10).eq.0) goto 80
       if(adj(i8,i10).eq.0) goto 80
       if(adj(i9,i10).eq.0) goto 80
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9)+v(i10).eq.243) icount=icount+1 

80     continue
79     continue
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
