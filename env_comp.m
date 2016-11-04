function enveloppe_t =env_comp(message,kf,T_symb,pics_par_T)
%INPUTS: 
%-message=le message m(t)
%-kf=sélectivité fréquentielle
%-T_symb=intervalle de temps entre 2 pics
%-pics_par_T=OSF=nbre de pics par bit
%OUTPUT: 
%-enveloppe=l'enveloppe complexe du message: e_s(t) 
%ATTENTION L'ENVELOPPE COMPLEXE DEPEND DU TEMPS


%%%%CALCUL DE L'INTEGRALE DE m(t) %%%%
% [nbre_1,nbre_moins]=comptage_1(t,message);
aire_t= (T_symb/pics_par_T) * cumsum(message);

enveloppe_t=exp(1i*2*pi*kf*aire_t);