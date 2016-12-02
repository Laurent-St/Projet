function [bruit_n,N_0]=bruit(rapport,signal_reel,bits)

%INPUT: rapport EN DECIBELS = E_b/N_0, initialement fixé, on le fait varier pour impacter le bruit et afficher la BER  

%anciennement fct_labo3

f_symb=500;
T_symb=1/f_symb;
OSF=20000/f_symb;

% [signal_reel,temps,bits]=emetteur();

%%%% CALCUL PSD SIGNAL REEL %%%%
% [psd_s_reel,f_s_reel]=welch(signal_reel,temps,1024,500);
% semilogy(f_s_reel,psd_s_reel,'g');

%%%% AJOUT DU BRUIT BLANC ADDITIF GAUSSIEN %%%%

% 1) Calcul de N_0, l'intensité spectrale du bruit

% E_b est l'énergie d'un bit
%x_dB=rapport;
rapport_non_decibel=10^(rapport/10); %c'est le rapport E_b/N_0

T_s=T_symb/OSF; %période entre 2 petits pics
s_carre=signal_reel.*signal_reel;
E_b=(1/length(bits))*(T_s)*sum(s_carre);

N_0=E_b/rapport_non_decibel;

% 2) Calcul de la puissance du bruit
P_n = (1/T_s) * N_0 * 0.5;
bruit_n = sqrt(P_n) * (randn(1, length(signal_reel)));


%%%% CALCUL PSD BRUIT %%%%
% [psdbruit,fbruit]=welch(bruit_n,temps,1024,500);
% semilogy(fbruit,psdbruit,'r');hold on
% semilogy(f_s_reel,psd_s_reel,'g');  %comparaison avec le signal


%%%% CALCUL PSD SIGNAL bruité %%%%
% [psd_r_n,f_r_n]=welch(r_n,temps,1024,500);
% semilogy(f_r_n,psd_r_n,'g');hold on
% semilogy(f_s_reel,psd_s_reel,'r');