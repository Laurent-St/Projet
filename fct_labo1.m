function [s_t_emis, temps, bits] = fct_labo1()

%%% PARAMETRES %%%

f_symb=500;
T_symb=1/f_symb;
OSF=20000/f_symb;    %OSF=oversampling factor = nombre de pics par bit
                       %fs = 20000 c'est la fréquence tyoique matlab quil
                       %faut mettre pour respecter le critère de nitch
pics_par_T=OSF;
kf=500;
fc=6000;
%%%%%%%%%%%%%%%%%%

%%%% Calcul de l'enveloppe complexe %%%%
[message, bits]=msg(T_symb,OSF);
N=length(bits);
enveloppe_t =env_comp(message,kf,T_symb,OSF);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% INTERVALLE DE TEMPS %%%%
temps=0:(T_symb/OSF):(N*T_symb)-(T_symb/OSF);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Calcul de la PSD de l'enveloppe complexe par Welch %%%%
SEGMENT_SIZE=1024;
DELAY=500;
[psd_env,f_env]=welch(enveloppe_t,temps,SEGMENT_SIZE,DELAY);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Calcul du signal réel et sa PSD %%%%%%%%%%%
signal_reel = s_reel(enveloppe_t, fc, temps);
[psd_s_reel,f_s_reel]=welch(signal_reel,temps,1024,500);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%plots%%%%%%
%semilogy(f_env,psd_env,'b');hold on;
%semilogy(f_s_reel,psd_s_reel,'g');
%%%%%%%%%%%%%%%%%%%%%%

%Return de la fonction
s_t_emis=signal_reel;
