       program theorem3

       integer vect(391,5),adj(391,391),v(391)
       integer coord1(391),coord2(391),coord3(391),coord4(391)
       integer coord5(391)

       icount=0
       do 10 i1=-3,3
       do 20 i2=-3,3
       do 30 i3=-3,3
       do 40 i4=-3,3
       do 42 i5=-3,3
       ibar=0
       if(i1.eq.0)ibar=ibar+1
       if(i2.eq.0)ibar=ibar+1
       if(i3.eq.0)ibar=ibar+1
       if(i4.eq.0)ibar=ibar+1
       if(i5.eq.0)ibar=ibar+1
       if(ibar.lt.3) goto 42
       icount=icount+1
       v(icount)=1
       if(i1.eq.-2 .or. i1.eq.2) v(icount)=v(icount)*2
       if(i1.eq.-1 .or. i1.eq.1) v(icount)=v(icount)*3
       if(i1.eq.0) v(icount)=v(icount)*4
       if(i2.eq.-2 .or. i2.eq.2) v(icount)=v(icount)*2
       if(i2.eq.-1 .or. i2.eq.1) v(icount)=v(icount)*3
       if(i2.eq.0) v(icount)=v(icount)*4
       if(i3.eq.-2 .or. i3.eq.2) v(icount)=v(icount)*2
       if(i3.eq.-1 .or. i3.eq.1) v(icount)=v(icount)*3
       if(i3.eq.0) v(icount)=v(icount)*4
       if(i4.eq.-2 .or. i4.eq.2) v(icount)=v(icount)*2
       if(i4.eq.-1 .or. i4.eq.1) v(icount)=v(icount)*3
       if(i4.eq.0) v(icount)=v(icount)*4
       if(i5.eq.-2 .or. i5.eq.2) v(icount)=v(icount)*2
       if(i5.eq.-1 .or. i5.eq.1) v(icount)=v(icount)*3
       if(i5.eq.0) v(icount)=v(icount)*4
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

       do 50 i=1,391
       do 60 j=1,391
       adj(i,j)=0
       if(abs(vect(i,1)-vect(j,1)).eq.4) adj(i,j)=1
       if(abs(vect(i,2)-vect(j,2)).eq.4) adj(i,j)=1
       if(abs(vect(i,3)-vect(j,3)).eq.4) adj(i,j)=1
       if(abs(vect(i,4)-vect(j,4)).eq.4) adj(i,j)=1
       if(abs(vect(i,5)-vect(j,5)).eq.4) adj(i,j)=1
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
       do 71 i1=1,391
       if(v(i1).eq.1024) icount=icount+1 

       do 72 i2=i1+1,391
       if(adj(i1,i2).eq.0) goto 72
       if(v(i1)+v(i2).eq.1024) icount=icount+1 

       do 73 i3=i2+1,391
       if(adj(i1,i3).eq.0) goto 73
       if(adj(i2,i3).eq.0) goto 73
       if(v(i1)+v(i2)+v(i3).eq.1024) icount=icount+1 

       do 74 i4=i3+1,391
       if(adj(i1,i4).eq.0) goto 74
       if(adj(i2,i4).eq.0) goto 74
       if(adj(i3,i4).eq.0) goto 74
       if(v(i1)+v(i2)+v(i3)+v(i4).eq.1024) icount=icount+1 

       do 75 i5=i4+1,391
       if(adj(i1,i5).eq.0) goto 75
       if(adj(i2,i5).eq.0) goto 75
       if(adj(i3,i5).eq.0) goto 75
       if(adj(i4,i5).eq.0) goto 75
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5).eq.1024) icount=icount+1 

       do 76 i6=i5+1,391
       if(adj(i1,i6).eq.0) goto 76
       if(adj(i2,i6).eq.0) goto 76
       if(adj(i3,i6).eq.0) goto 76
       if(adj(i4,i6).eq.0) goto 76
       if(adj(i5,i6).eq.0) goto 76
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6).eq.1024) icount=icount+1 

       do 77 i7=i6+1,391
       if(adj(i1,i7).eq.0) goto 77
       if(adj(i2,i7).eq.0) goto 77
       if(adj(i3,i7).eq.0) goto 77
       if(adj(i4,i7).eq.0) goto 77
       if(adj(i5,i7).eq.0) goto 77
       if(adj(i6,i7).eq.0) goto 77
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7).eq.1024) icount=icount+1 

       do 78 i8=i7+1,391
       if(adj(i1,i8).eq.0) goto 78
       if(adj(i2,i8).eq.0) goto 78
       if(adj(i3,i8).eq.0) goto 78
       if(adj(i4,i8).eq.0) goto 78
       if(adj(i5,i8).eq.0) goto 78
       if(adj(i6,i8).eq.0) goto 78
       if(adj(i7,i8).eq.0) goto 78
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8).eq.1024) icount=icount+1 

       do 79 i9=i8+1,391
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
     c +v(i9).eq.1024) icount=icount+1 

       do 80 i10=i9+1,391
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
     c +v(i9)+v(i10).eq.1024) icount=icount+1 

       do 81 i11=i10+1,391
       if(adj(i1,i11).eq.0) goto 81
       if(adj(i2,i11).eq.0) goto 81
       if(adj(i3,i11).eq.0) goto 81
       if(adj(i4,i11).eq.0) goto 81
       if(adj(i5,i11).eq.0) goto 81
       if(adj(i6,i11).eq.0) goto 81
       if(adj(i7,i11).eq.0) goto 81
       if(adj(i8,i11).eq.0) goto 81
       if(adj(i9,i11).eq.0) goto 81
       if(adj(i10,i11).eq.0) goto 81
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9)+v(i10)+v(i11).eq.1024) icount=icount+1 

       do 82 i12=i11+1,391
       if(adj(i1,i12).eq.0) goto 82
       if(adj(i2,i12).eq.0) goto 82
       if(adj(i3,i12).eq.0) goto 82
       if(adj(i4,i12).eq.0) goto 82
       if(adj(i5,i12).eq.0) goto 82
       if(adj(i6,i12).eq.0) goto 82
       if(adj(i7,i12).eq.0) goto 82
       if(adj(i8,i12).eq.0) goto 82
       if(adj(i9,i12).eq.0) goto 82
       if(adj(i10,i12).eq.0) goto 82
       if(adj(i11,i12).eq.0) goto 82
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9)+v(i10)+v(i11)+v(i12).eq.1024) icount=icount+1 

       do 83 i13=i12+1,391
       if(adj(i1,i13).eq.0) goto 83
       if(adj(i2,i13).eq.0) goto 83
       if(adj(i3,i13).eq.0) goto 83
       if(adj(i4,i13).eq.0) goto 83
       if(adj(i5,i13).eq.0) goto 83
       if(adj(i6,i13).eq.0) goto 83
       if(adj(i7,i13).eq.0) goto 83
       if(adj(i8,i13).eq.0) goto 83
       if(adj(i9,i13).eq.0) goto 83
       if(adj(i10,i13).eq.0) goto 83
       if(adj(i11,i13).eq.0) goto 83
       if(adj(i12,i13).eq.0) goto 83
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9)+v(i10)+v(i11)+v(i12)+v(i13).eq.1024) icount=icount+1 

       do 84 i14=i13+1,391
       if(adj(i1,i14).eq.0) goto 84
       if(adj(i2,i14).eq.0) goto 84
       if(adj(i3,i14).eq.0) goto 84
       if(adj(i4,i14).eq.0) goto 84
       if(adj(i5,i14).eq.0) goto 84
       if(adj(i6,i14).eq.0) goto 84
       if(adj(i7,i14).eq.0) goto 84
       if(adj(i8,i14).eq.0) goto 84
       if(adj(i9,i14).eq.0) goto 84
       if(adj(i10,i14).eq.0) goto 84
       if(adj(i11,i14).eq.0) goto 84
       if(adj(i12,i14).eq.0) goto 84
       if(adj(i13,i14).eq.0) goto 84
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9)+v(i10)+v(i11)+v(i12)+v(i13)+
     c v(i14).eq.1024) icount=icount+1 

       do 85 i15=i14+1,391
       if(adj(i1,i15).eq.0) goto 85
       if(adj(i2,i15).eq.0) goto 85
       if(adj(i3,i15).eq.0) goto 85
       if(adj(i4,i15).eq.0) goto 85
       if(adj(i5,i15).eq.0) goto 85
       if(adj(i6,i15).eq.0) goto 85
       if(adj(i7,i15).eq.0) goto 85
       if(adj(i8,i15).eq.0) goto 85
       if(adj(i9,i15).eq.0) goto 85
       if(adj(i10,i15).eq.0) goto 85
       if(adj(i11,i15).eq.0) goto 85
       if(adj(i12,i15).eq.0) goto 85
       if(adj(i13,i15).eq.0) goto 85
       if(adj(i14,i15).eq.0) goto 85
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9)+v(i10)+v(i11)+v(i12)+v(i13)+
     c v(i14)+v(i15).eq.1024) icount=icount+1 

       do 86 i16=i15+1,391
       if(adj(i1,i16).eq.0) goto 86
       if(adj(i2,i16).eq.0) goto 86
       if(adj(i3,i16).eq.0) goto 86
       if(adj(i4,i16).eq.0) goto 86
       if(adj(i5,i16).eq.0) goto 86
       if(adj(i6,i16).eq.0) goto 86
       if(adj(i7,i16).eq.0) goto 86
       if(adj(i8,i16).eq.0) goto 86
       if(adj(i9,i16).eq.0) goto 86
       if(adj(i10,i16).eq.0) goto 86
       if(adj(i11,i16).eq.0) goto 86
       if(adj(i12,i16).eq.0) goto 86
       if(adj(i13,i16).eq.0) goto 86
       if(adj(i14,i16).eq.0) goto 86
       if(adj(i15,i16).eq.0) goto 86
       if(v(i1)+v(i2)+v(i3)+v(i4)
     c +v(i5)+v(i6)+v(i7)+v(i8)
     c +v(i9)+v(i10)+v(i11)+v(i12)+v(i13)+
     c v(i14)+v(i15)+v(i16).eq.1024) icount=icount+1

86     continue
85     continue
84     continue
83     continue
82     continue
81     continue
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
