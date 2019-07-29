function [ Angles_Cell ] = Angle_Policlimax(I,N,Angles_Cell,LoGs )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
[q,m]=size(I);
for i=1:N
    Angles=Angles_Cell{i};
    Log=abs(LoGs{i});
    if i==1
        Log_n=abs(LoGs{i+1});
        for j=1:q
            for l=1:m
                while (Angles(j,l)==1)
                    if (Log(j,l)<Log_n(j,l))
                        Angles(j,l)=0;
                    end
                end
            end
        end
        Angles_Cell{i}=Angles;
    elseif i==N
        Log_p=abs(LoGs{i-1});
        for j=1:q
            for l=1:m
                while (Angles(j,l)==1)
                    if (Log(j,l)<Log_p(j,l))
                        Angles(j,l)=0;
                    end
                end
            end
        end
        Angles_Cell{i}=Angles;
    else
        Log_p=abs(LoGs{i-1});
        Log_n=abs(LoGs{i+1});
        for j=1:q
            for l=1:m
                while (Angles(j,l)==1)
                    if ((Log(j,l)<Log_p(j,l)) || (Log(j,l)<Log_n(j,l)))
                        Angles(j,l)=0;
                    end
                end
            end
        end
        Angles_Cell{i}=Angles;
    end
end

end

