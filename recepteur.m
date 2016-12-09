%recepteur
function s_tild=recepteur(r_t,temps,phi,kf)
%r_t est le signal d'entrée

%anciennement script_labo2

%%% PARAMETRES %%%
f_symb=500;
T_symb=1/f_symb;
fs=20000;
OSF=20000/f_symb;    %OSF=oversampling factor = nombre de pics par bit
                       %fs = 20000 c'est la fréquence typique matlab qu'il
                       %faut mettre pour respecter le critère de nitch
pics_par_T=OSF;
fc=6000;
%%%%%%%%%%%%%%%%%%

%env_comp(signal,kf,T_symb,pics_par_T);
fmax_baseband=kf+f_symb; %voir formule labo1 slide 9, avec f_c=0 car baseband.
%[r_t , temps, bits]= bruit(rapport);
s_tild=baseband_recepteur(r_t,fc,temps,fmax_baseband,fs,phi);

%verification: a-t-on le meme signal que celui de l'emetteur?
SEGMENT_SIZE=1024;
DELAY=500;
[psd_s_tild,f_s_tild]=welch(s_tild,temps,SEGMENT_SIZE,DELAY);
%semilogy(f_s_tild,psd_s_tild,'g');


    



