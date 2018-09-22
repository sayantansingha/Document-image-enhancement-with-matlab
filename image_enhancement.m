a=imread('hi411.jpg');
figure,imshow(a);%1
b=rgb2gray(a);
%figure,imshow(b)%2
b1=histeq(b);
%figure,imshow(b1)%3
value=graythresh(b1);
disp(value*255);
z=zeros(size(b1,1),size(b1,2));
for i=1:size(b1,1)
    for j=1:size(b1,2)
        z(i,j)=150;
    end
end
for i=1:size(b1,1)
    for j=1:size(b1,2)
        if b(i,j)<(value * 255)
            z(i,j)=0;
        end
    end
end
%figure,imshow(z);

W = im2bw(a);
%figure,imshow(W);

%new part
iblur= imgaussfilt(b,2);
histimg=histeq(b);
iblur1=imgaussfilt(histimg,2);
figure,imshow(histimg);%3
e=edge(iblur1,'sobel');
%figure,imshow(e);%4

ef=edge(b,'canny');
%figure,imshow(ef);
%third part
re=zeros(size(b,1),size(b,2));
for i=1:size(b,1)
    for j=1:size(b,2)
        if e(i,j)==ef(i,j)
          re(i,j)=255;  
        end
    end
end
%figure,imshow(re);%5
for i=1:size(b,1)
    for j=1:size(b,2)
        if z(i,j)==0
        re(i,j)=0; 
            
        end
    
    end

end
%figure,imshow(re);

%
%
%
%part from sa_21.m
%%%%
%
%
%%
a=imread('hi411.jpg');
%imshow(a);
c=rgb2gray(a);
%b=rgb2gray(a);
%Iblur = imgaussfilt(b,2);
%figure,imshow(c);
%first part of the algorithm
b=histeq(c);
%figure,imshow(b);
%b=imread('qwe.jpg');
level=graythresh(b);
e=size(b,1);
f=size(b,2);
min=255;
max=0;
W = im2bw(a);
%imshow(W);
%disp(W);
for i=1:e
    for j=1:f
        if b(i,j)<min
            min=b(i,j);
        end
        if b(i,j)>max
            max=b(i,j);
        end
        
    end
end
%imshow(c);
%disp(min);
%disp(level);
%disp(b);
d=zeros(e,f);
x=zeros(e,f);
for i=1:e
    for j=1:f
        d(i,j)=100;
    end
end
%imshow(d);
disp(256*level);
for i=1:e
    for j=1:f
        if b(i,j)>=min && b(i,j)<=(100*level)/2
            d(i,j)=0;
        end
    end
end
%figure,imshow(d);%6
%second part of the algorithm
%
%
%

Iblur = imgaussfilt(c,2);
%figure,imshow(Iblur)
%e=edge(Iblur,'sobel');
e=edge(c,'sobel');
%figure,imshow(e);
size_row=size(c,1);
size_coloumn=size(c,2);
min=0;
sq=zeros(size_row,size_coloumn);
sc=zeros(size_row,size_coloumn);
k=zeros(size_row,size_coloumn);
for i=1:size_row
    for j=1:size_coloumn
        if e(i,j)>min
            min=e(i,j);
            
        end
        k(i,j)=255;
        x(i,j)=255;
        sq(i,j)=255;
    end
end
%figure,imshow(d);
%canny
min=0;
%sq=edge(Iblur,'canny');
sq=edge(Iblur,'canny');
for i=1:size_row
    for j=1:size_coloumn
        if sq(i,j)>=min
            min=sq(i,j);
            
        end
        sc(i,j)=255;
    end
end
figure,imshow(sc);%7
figure,imshow(sq);%8
for i=1:size_row
    for j=1:size_coloumn
        if min==sq(i,j)
            sc(i,j)=0;
        end
    end
end
figure,imshow(sc);
%end canny
for i=1:size_row
    for j=1:size_coloumn
        if min==e(i,j)
            k(i,j)=0;
        end
    end
end
%figure,imshow(k); %we have to use k for final filter
for i=1:size_row
    for j=1:size_coloumn
        if d(i,j)==0
            x(i,j)=0;
        end
        if k(i,j)==0
            x(i,j)=0;
        end
        if sc(i,j)==0
            x(i,j)=0;
        end
        
        
    end
end
%figure,imshow(x);
mask=zeros(5,5);
for i=1:5
    for j=1:5
     mask(i,j)=255;
    end
end

    late=0;
for i=1:size_row
    for j=1:f
        if sc(i,j)==0 %&& we+i-1<=size_row && ek+j-1<=f
            for we=1:5
                for ek=1:5
                    if we+i-1<=size_row && ek+j-1<=f
                    mask(we,ek)=b(we+i-1,ek+j-1);
                    end
                end
            end
            %figure,imshow(mask);
            
            mask1=histeq(mask);
            min=255;
            for we=1:5
                for ek=1:5
                    if min>mask1(we,ek)
                        min=mask1(we,ek);
                    end
                end
            end
            for we=1:5
                for ek=1:5
                    if min==mask1(we,ek) || mask1(we,ek)<min+40
                        x(we,ek)=0;
                     %   disp(x(we,ek));
                     end
                end
            end
            
        end
        
        
    end
end
%figure,imshow(x);
%figure,imshow(sc);
%%
%%
%intersection part
final=zeros(size(b,1),size(b,2));
faltu=zeros(size(b,1),size(b,2));
for i=1:size(b,1)
    for j=1:size(b,2)
        final(i,j)=255;
        faltu(i,j)=255;
    end
end

for i=1:size(b,1)
    for j=1:size(b,2)
        if x(i,j)==re(i,j)
            final(i,j)=re(i,j);
            faltu(i,j)=re(i,j);%filter
        end
    end
end
%%
%figure,imshow(final); %%fiba


%%%


%forth part 
a=imread('hi411.jpg');

b=rgb2gray(a);
c=histeq(b);
mask=zeros(225);
p=0;
f=zeros(size(b,1),size(b,2));
%figure,imshow(f)
z=zeros(81);
for i=1:9:size(b,1)
    for j=1:9:size(b,2)
        if 9+i<=size(b,1)
            if 9+j<=size(b,2)
                res=0;
        for k=i:9+i
            for l=j:9+j
                res=res+1;
                z(res)=b(k,l);
                f(k,l)=255;
            end
        end
        mean1=mean(z);
        sd=std2(z);
        thresol=mean1+(sd*2);
 %       disp(thresol);
        for k=i:9+i
            for l=j:9+j
                if b(k,l)<=thresol
                    final(k,l)=0;
                       % f(k,l)=0;
                end
            end
        end

        
        
            end
        
        end
    end
end
figure,imshow(final);
%
%
%
iblur12= imgaussfilt(b,2);
figure,imshow(iblur12);
iblur3=imgaussfilt(iblur12,4);
figure,imshow(iblur3);
ed5=edge(iblur3,'sobel');
figure,imshow(ed5);

for i=1:size(b,1)
    for j=1:size(b,2)
        if ed5(i,j)<155
            if i+4<size(b,1) && j+4<size(b,2)
           for p=i:i+4
               for q=j:j+4
                  
                   if sc(p,q)==0
                       final(p,q)=255;
                   end
                   
               end
           end
            end
        end
    end
end

%figure,imshow(final);
b13=im2bw(final);
intersec1=final;

figure,imshow(b13);



%second part%
a=imread('hi3.jpg');
figure,imshow(a);
b=rgb2gray(a);
b1=histeq(b);
value=graythresh(b1);
disp(value*255);
z=zeros(size(b1,1),size(b1,2));
for i=1:size(b1,1)
    for j=1:size(b1,2)
        z(i,j)=150;
    end
end
for i=1:size(b1,1)
    for j=1:size(b1,2)
        if b(i,j)<(value * 255)
            z(i,j)=0;
        end
    end
end
%figure,imshow(z);

W = im2bw(a);
%figure,imshow(W);

%new part
iblur= imgaussfilt(b,2);
histimg=histeq(b);
iblur1=imgaussfilt(histimg,2);
figure,imshow(histimg);
e=edge(iblur1,'sobel');
%figure,imshow(e);%6

ef=edge(b,'canny');
figure,imshow(ef);%7
%third part
re=zeros(size(b,1),size(b,2));
for i=1:size(b,1)
    for j=1:size(b,2)
        if e(i,j)==ef(i,j)
          re(i,j)=255;  
        end
    end
end
figure,imshow(re);%8
for i=1:size(b,1)
    for j=1:size(b,2)
        if z(i,j)==0
        re(i,j)=0; 
            
        end
    
    end

end
%figure,imshow(re);

%
%
%
%part from sa_21.m
%%%%
%
%
%%
a=imread('hi411.jpg');
%imshow(a);
c=rgb2gray(a);

%first part of the algorithm
b=histeq(c);
figure,imshow(b); %9
%b=imread('qwe.jpg');
level=graythresh(b);
e=size(b,1);
f=size(b,2);
min=255;
max=0;
W = im2bw(a);

%disp(W);
for i=1:e
    for j=1:f
        if b(i,j)<min
            min=b(i,j);
        end
        if b(i,j)>max
            max=b(i,j);
        end
        
    end
end
d=zeros(e,f);
x=zeros(e,f);
for i=1:e
    for j=1:f
        d(i,j)=100;
    end
end
%imshow(d);
disp(256*level);
for i=1:e
    for j=1:f
        if b(i,j)>=min && b(i,j)<=(100*level)/2
            d(i,j)=0;
        end
    end
end
figure,imshow(d);%10
%second part of the algorithm
%
%
%


Iblur = imgaussfilt(c,2);
%e=edge(Iblur,'sobel');
e=edge(c,'sobel');
figure,imshow(e);
size_row=size(c,1);
size_coloumn=size(c,2);
min=0;
sq=zeros(size_row,size_coloumn);
sc=zeros(size_row,size_coloumn);
k=zeros(size_row,size_coloumn);
%figure,imshow(k);
%figure,imshow(Iblur);
for i=1:size_row
    for j=1:size_coloumn
        if e(i,j)>min
            min=e(i,j);
            
        end
        k(i,j)=255;
        x(i,j)=255;
        sq(i,j)=255;
    end
end
figure,imshow(d);%11
%canny
min=0;

sq=edge(Iblur,'canny');
for i=1:size_row
    for j=1:size_coloumn
        if sq(i,j)>min
            min=sq(i,j);
            
        end
        sc(i,j)=255;
    end
end
%figure,imshow(sc);
%figure,imshow(sq);
for i=1:size_row
    for j=1:size_coloumn
        if min==sq(i,j)
            sc(i,j)=0;
        end
    end
end
%figure,imshow(sc);
%end canny
for i=1:size_row
    for j=1:size_coloumn
        if min==e(i,j)
            k(i,j)=0;
        end
    end
end
figure,imshow(k); %we have to use k for final filter 12
for i=1:size_row
    for j=1:size_coloumn
        if d(i,j)==0
     %       x(i,j)=0;
        end
        if k(i,j)==0
            x(i,j)=0;
        end
        if sc(i,j)==0
            x(i,j)=0;
        end
        
        
    end
end
%figure,imshow(x);
mask=zeros(5,5);
for i=1:5
    for j=1:5
     mask(i,j)=255;
    end
end

    late=0;
for i=1:size_row
    for j=1:f
        if sc(i,j)==1
            for we=1:5
                for ek=1:5
                    mask(we,ek)=b(we+i-1,ek+j-1);
                end
            end
            %figure,imshow(mask);
            
            mask1=histeq(mask);
            min=255;
            for we=1:5
                for ek=1:5
                    if min>mask1(we,ek)
                        min=mask1(we,ek);
                    end
                end
            end
            for we=1:5
                for ek=1:5
                    if min==mask1(we,ek) || mask1(we,ek)<min+40
                        x(we,ek)=0;
                     %   disp(x(we,ek));
                     end
                end
            end
            
        end
        
        
    end
end
%figure,imshow(x);
%figure,imshow(sc);
%%
%%
%intersection part
final=zeros(size(b,1),size(b,2));
faltu=zeros(size(b,1),size(b,2));
for i=1:size(b,1)
    for j=1:size(b,2)
        final(i,j)=255;
        faltu(i,j)=255;
    end
end

for i=1:size(b,1)
    for j=1:size(b,2)
        if x(i,j)==re(i,j)
            final(i,j)=re(i,j);
            faltu(i,j)=re(i,j);%filter
        end
    end
end
%%
%figure,imshow(final); %%fiba

%figure,imshow(final);



%forth part 
a=imread('hi411.jpg');

b=rgb2gray(a);
c=histeq(b);
mask=zeros(225);p=0;
f=zeros(size(b,1),size(b,2));
z=zeros(81);
for i=1:9:size(b,1)
    for j=1:9:size(b,2)
        if 9+i<=size(b,1)
            if 9+j<=size(b,2)
                res=0;
        for k=i:9+i
            for l=j:9+j
                res=res+1;
                z(res)=b(k,l);
                f(k,l)=255;
            end
        end
        mean1=mean(z);
        sd=std2(z);
        thresol=mean1+(sd*2);
 %       disp(thresol);
        for k=i:9+i
            for l=j:9+j
                if b(k,l)<=thresol
                    final(k,l)=0;
                       % f(k,l)=0;
                end
            end
        end

        
        
            end
        
        end
    end
end
%figure,imshow(final);
%
%
%
iblur12= imgaussfilt(b,2);
figure,imshow(iblur12);
iblur3=imgaussfilt(iblur12,4);
figure,imshow(iblur3);
ed5=edge(iblur3,'sobel');
figure,imshow(ed5);%13

for i=1:size(b,1)
    for j=1:size(b,2)
        if ed5(i,j)<155
            if i+4<size(b,1) && j+4<size(b,2)
           for p=i:i+4
               for q=j:j+4
                  
                   if sc(p,q)==0
                       final(p,q)=255;
                   end
                   
               end
           end
            end
        end
    end
end

%figure,imshow(final);
b13=im2bw(final);
intersec2=final;
%figure,imshow(b13);
%
%final part
xe=zeros(size(b,1),size(b,2));
for i=1:size(b,1)
    for j=1:size(b,2)
        if intersec2(i,j)==0
            if i+2<size(b,1) && j+2<size(b,2)
            for p=i:i+2
                for q=j:j+2
                    if intersec1(p,q)==0
                        final(p,q)=0;
                    end
                end
            end
            
            end
            
        end
    end
end
%figure,imshow(final);
%time for union
temp=zeros(size(b,1),size(b,2));
value=graythresh(b);
for i=1:size(b,1)
    for j=1:size(b,2)
        if intersec1(i,j)==intersec2(i,j)
            final(i,j)=intersec2(i,j);
        end
               temp(i,j)=255;
    end
end
vi=graythresh(b);
    for i=1:size(b,1)
        for j=1:size(b,2)
            if b(i,j)<=255*vi
                temp(i,j)=0;
            end
        end
    end
figure,imshow(final);%14
for i=1:size(b,1)
    for j=1:size(b,2)
        if final(i,j)==0
       if i+2<size(b,1) && j+2<size(b,2)
           for qw=i:2+i
               for we=j:2+j
                if temp(qw,we)==0
                    final(qw,we)=0;
                    
                end
               end
           end
       end
        end
    end
end
    
figure,imshow(temp);   
figure,imshow(final);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%last
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%part
a=imread('hi411.jpg');
%figure,imshow(a);
b=rgb2gray(a);
c=graythresh(b);
k1i=zeros(size(b,1),size(b,2));
k12i=zeros(size(b,1),size(b,2));
k13i=zeros(size(b,1),size(b,2));
k14i=zeros(size(b,1),size(b,2));
k15i=zeros(size(b,1),size(b,2));
k16i=zeros(size(b,1),size(b,2));
k17i=zeros(size(b,1),size(b,2));
k18i=zeros(size(b,1),size(b,2));
k19i=zeros(size(b,1),size(b,2));
k10i=zeros(size(b,1),size(b,2));
k_finali=zeros(size(b,1),size(b,2));

ki=zeros(size(b,1),size(b,2));
for i=1:size(b,1)
    for j=1:size(b,2)
        ki(i,j)=255;
        k1i(i,j)=255;
        k12i(i,j)=255;
        k13i(i,j)=255;
        k14i(i,j)=255;
        k15i(i,j)=255;
        k16i(i,j)=255;
        k17i(i,j)=255;
        k18i(i,j)=255;
        k19i(i,j)=255;
        k10i(i,j)=255;
        k_finali(i,j)=255;
    end
end
k3i=edge(b,'canny');
figure,imshow(k3i);
figure,imshow(k_finali);
for i=1:size(b,1)
    for j=1:size(b,2)
        if b(i,j)<=200*c
        ki(i,j)=0;
        end
        if b(i,j)<=210*c
        k1i(i,j)=0;
        end
        if b(i,j)<=220*c
        k12i(i,j)=0;
        end
        if b(i,j)<=230*c
        k13i(i,j)=0;
        end
        if b(i,j)<=240*c
        k14i(i,j)=0;
        end
        if b(i,j)<=250*c
        k14i(i,j)=0;
        end
        if b(i,j)<=260*c
        k15i(i,j)=0;
        end
        
    end
end
k2i=edge(b,'sobel');
figure,imshow(k2i);
figure,imshow(ki);
figure,imshow(k1i);
figure,imshow(k12i);
figure,imshow(k13i);
%figure,imshow(k);
d=histeq(b);
min=255;
max=0;
for i=1:size(b,1)
    for j=1:size(b,2)
        if max<k2i(i,j)
            max=k2i(i,j);
        end
    end
end
disp(max);
%figure,imshow(k16);
%figure,imshow(d);
ei=edge(d,'sobel');
figure,imshow(ei);
%for i=1:size(b,1)
   % for j=1:size(b,2)
    %    if d(i,j)<=50*c
   %     k1(i,j)=0;
  %      end
 %   end
%end
%figure,imshow(k1);
Iblur=imgaussfilt(b,3);
k9i=edge(Iblur,'sobel');
figure,imshow(k9i);

%figure,imshow(k);
%figure,imshow(k1);
%figure,imshow(k12);
%figure,imshow(k13);
%figure,imshow(k14);
prob_count=0;
res=0;
%disp(k_final);
for i=1:size(b,1)
    for j=1:size(b,2)
        if ki(i,j)==0
            prob_count=prob_count+1;
        end
        if k1i(i,j)==0
            prob_count=prob_count+1;
        end
        if k12i(i,j)==0
            prob_count=prob_count+1;
        end
        if k13i(i,j)==0
            prob_count=prob_count+1;
        end
        if k14i(i,j)==0
            prob_count=prob_count+1;
        end
        if k15i(i,j)==0
            prob_count=prob_count+1;
        end
        if k2i(i,j)==1
            prob_count=prob_count+6;
        end
        if k9i(i,j)==1
            prob_count=prob_count+1.5;
        end
        if ei(i,j)==100
            prob_count=prob_count+1;
        end
            

        
        if prob_count>=4
            k_finali(i,j)=0;
        end
        
        prob_count=0;




        
    end
end
%disp(k_final);
k45=zeros(2,2);
k451=zeros(3,3);
for i=1:size(b,1)
    for j=1:size(b,2)
        k45(i,j)=255;
    end
end
for i=1:size(b,1)
    for j=1:size(b,2)
        k451(i,j)=255;
    end
end
for i=1:size(b,1)
    for j=1:size(b,2)
        if k_finali(i,j)==0
            if i+3<=size(b,1) && j+3<=size(b,2)
                for pw=i:i+2
                    for py=j:j+2
                        if final(pw,py)==0
                        %k45(pw,py)=b(pw,py);
                        k_finali(pw,py)=final(pw,py);
                        end
                    end
                end
                for pw=i:i+3
                    for py=j:j+3
                        k451(pw,py)=k_finali(pw,py);
                    end
                end
                %if pw+2<=size(k451,1) && py+2<=size(k451,2)
                %if k451(pw+2,py)==k451(pw,py+2)
                 %   k_finali(pw+1,py+1)=0;
                %end
                %if k451(pw+2,py+2)==k451(pw,py)
                 %   k_finali(pw+1,py+1)=0;
                %end
                %end
            end
            
        end
    end
end
figure,imshow(k_finali);
