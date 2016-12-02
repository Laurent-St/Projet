%recepteur
function m_final=recepteur(r_t,temps)
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
kf=500;
fc=6000;
%%%%%%%%%%%%%%%%%%

%env_comp(signal,kf,T_symb,pics_par_T);
fmax_baseband=kf+f_symb; %voir formule labo1 slide 9, avec f_c=0 car baseband.
%[r_t , temps, bits]= bruit(rapport);
s_tild=baseband_recepteur(r_t,fc,temps,fmax_baseband,fs);

%verification: a-t-on le meme signal que celui de l'emetteur?
SEGMENT_SIZE=1024;
DELAY=500;
[psd_s_tild,f_s_tild]=welch(s_tild,temps,SEGMENT_SIZE,DELAY);
%semilogy(f_s_tild,psd_s_tild,'g');

%récupération de s0 et puis du message
s0 = demodulateur(s_tild, f_symb, kf,fs);

m_t = [];
k = 1;
for n=1 : OSF : length(s0)
    sublist = s0(n:n+OSF-1);    %on extrait une sous-liste constitué de tout les réplique d'un bit original
    moyenne = mean(sublist);
    if moyenne > 0
        m_t(k) = 1;
    else
        m_t(k) = 0;
    end
    k = k + 1;
end

T_symb=1/f_symb;
%temps_final=1:(1/f_symb):(length(m_t)/f_symb);
temps_final=0:(T_symb):(length(m_t)*T_symb)-(T_symb);

%%% Conversion binaire en texte
% NBCHAR=11; %A CHANGER EN FCT DU MOT
% m_t = reshape(bits,8,NBCHAR)' ; % nbchar : number of characters --> A DONNER
% text_rx_int = bi2de(m_t)' ; % binary to decimal
% text_rx = char(text_rx_int) ; % decimal to text

m_final=m_t;

    



