function [nbre_1,nbre_moins]=comptage_1(t,message)
%INPUTS:
%-t= instant auquel on se trouve
%-message
%OUTPUT:
%-nbre_1=nombre de 1 du message de 0 à t
%-nbre_moins=nombre de -1 du message de 0 à t

nbre_1=0;
nbre_moins=0;
for i=1:t
    if message(i)==1
        nbre_1=nbre_1+1;
    else
        nbre_moins=nbre_moins+1;
    end
end
