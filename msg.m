function message=msg(N,T_symb,pics_par_T)
%INPUTS:
%-N=nbre de bits
%-T_symb=écart de temps entre 2 bits
%-pics_par_T=OSF=nbre de pics par bit
%OUTPUTS:
%-message=message m(t), onde rectangulaire de -1 à 1

bits=randi(2,1,N)-1;

message=[];

k=1; %pour remplir message
i=1; %pour chercher dans les bits
while (i<=N)
% for i=1:(pics_par_T):N*pics_par_T
    if bits(i)==1
        message(k:k+pics_par_T-1)=1;
    else
        message(k:k+pics_par_T-1)=-1;
    end
    k=k+pics_par_T;
    i=i+1;
end

