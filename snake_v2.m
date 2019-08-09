startt();
function startt()
h.fig1=figure;
set(gcf,'position',[500,500,600,100])
h.diff_t = uicontrol('style','text','String','DIFFICULTY',...
                         'units','normalized','position',[0.02 0.3 0.20 0.25]);
h.diff = uicontrol('style','slider',...
                   'Min',0.1,'Max',1,'Value',0.1,...
                   'units','normalized','position',[0.2 0.2 0.5 0.6],...
                   'SliderStep', [0.11 0.11]);
h.diff_text = uicontrol('Style', 'text','String',round(get(h.diff,'Value')*10),...
                        'units','normalized','position',[0.72 0.45 0.05 0.2],...
                        'fontsize',15);
set(h.diff,'callback',{@difficulty, h})
h.start = uicontrol('style','pushbutton','String','Start',...
                     'units','normalized','position',[0.8 0.3 0.15 0.4],...
                     'callback',{@snake, h});                
end
function difficulty(~,~,h)
dif=round(get(h.diff,'Value')*10);
set(h.diff_text,'string',dif);
end


function snake(~,~,h)
dif=0.2-get(h.diff,'Value')/5;
close all
figure('keypressfcn',@direction)
hold on
dir=2;  %1-up 2-down 3-right 4-left 
function direction(~,data)
    if data.Character=='w'&&dir~=2&&flag==0
        dir=1;
    elseif data.Character=='s'&&dir~=1&&flag==0
        dir=2;
    elseif data.Character=='d'&&dir~=4&&flag==0
        dir=3;
    elseif data.Character=='a'&&dir~=3&&flag==0
        dir=4;
    end
    flag=1;
end
sn = zeros(100,2);
sn(1,:)=[0 -1];
sn(2,:)=[0 0]; 
size=2;
a=randi([-15 15]);
b=randi([-15 15]);
notout=1;
while notout
    clf
    xlim([-16 16])
    ylim([-16 16])
    rectangle('Position',[-16 -16 32 32])
    axis off
    hold on
    p=plot(a,b,'*');
    for i=2:size
        if sn(i,1)==sn(1,1)&&sn(i,2)==sn(1,2) || sn(1,1)==-16 || sn(1,1)==16 || sn(1,2)==-16 || sn(1,2)==16
            notout=0;
            break;
        end
    end
    for j=1:size-1
        plot([sn(j+1,1),sn(j,1)], [sn(j+1,2),sn(j,2)], 'LineWidth',4);
    end
    caption = sprintf('SCORE : %d', size-2);
    title(caption, 'FontSize', 10);
    pause(dif);
    switch dir
        case 1
            sn=[sn(1,1) sn(1,2)+1;sn];
        case 2
            sn=[sn(1,1) sn(1,2)-1;sn];
        case 3
            sn=[sn(1,1)+1 sn(1,2);sn];
        case 4
            sn=[sn(1,1)-1 sn(1,2);sn];
    end
        flag=0;
        if sn(1,1)==a&&sn(1,2)==b
            size=size+1;
            delete(p)
            while 1
                a=randi([-15 15]);
                b=randi([-15 15]);
                f=0;
                for i=1:size
                    if sn(i,1)==a&&sn(i,2)==b
                        f=1;
                        break;
                    end
                end
                if f==0
                    break;
                end
            end
            p=plot(a,b,'*');
        else
            sn(size+1,:)=[];
        end 
        
        
end
waitfor(msgbox(sprintf('GAME OVER !!! YOUR SCORE : %d',size-2)));
close all
startt();
end