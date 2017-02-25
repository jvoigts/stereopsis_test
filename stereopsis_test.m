ntrials=50;

imsize=600;
ndots=400;
csize=5;
f=fspecial('gaussian',10,1.8); f=f./max(f(:));

for t=1:ntrials
    figure(1); clf; hold on;
    I=zeros(imsize,imsize*2+10);
    px=rand(1,ndots)*(imsize-1);
    py=rand(1,ndots)*(imsize-1);
    
    xofs(t)=randn*5;
    
    for i=1:ndots
        I(ceil(px(i)),ceil(py(i)+randn(1)./2+1))=1;
    
        if norm( [px(i) py(i)] - [imsize imsize]./2 ) < imsize./csize
            I(ceil(px(i)),ceil(py(i)+imsize+xofs(t)))=1;
        else
            I(ceil(px(i)),ceil(py(i)+imsize))=1;
        end;
    end;
    
    I=conv2(I,f,'same');
    
    if t==1
   
        I(imsize./2+[-60:60],imsize./2+[-60:60])=1;
        I(imsize./2+[-60:60],imsize./2+[-60:60]+imsize)=1;
    else
        
        I(imsize./2+[-20:20],imsize./2+[-20:20])=1;
        I(imsize./2+[-20:20],imsize./2+[-20:20]+imsize)=1;
    end;
    
   I(:,imsize+[-2:2])=1;
    
    image(20+(I*100));
    colormap gray;
    daspect([1 1 1]);
    axis tight;
    drawnow;
    
    
   [x,y,b]=ginput(1);
   %response(t)=norm( [x,y] - [imsize imsize]./2 ) < imsize./csize
   response(t)=b==30;
    
    
end;
disp('done!');

%% stats

[xofs;response]
ll=linspace(min(xofs),max(xofs),25)

figure(2);
clf; hold on;
crate=[];
for i=1:numel(ll)-1
    ii=xofs>ll(i) & xofs<ll(i+1);
    N=sum(ii);
    C=sum(sign(double(response(ii))-0.5));
    
    crate(i)=C/N;
    
end;


 plot(ll(1:end-1),crate, 'k' );
 grid on;
plot([0 0],[-1 1],'r')    