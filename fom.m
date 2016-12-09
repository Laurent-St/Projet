%scripta figure of merit
function FOM=fom(kf,f_symb,N_0,s_emis,s_final_bruite,s_final_non_bruite)

%%% SRN IN

%%%ratio de la puissance du signal_in et du bruit_in
%%%Puissance du signal d'entrée après modulation
P_SSB_in = (1/length(s_emis)) * sum(s_emis.*s_emis);

%%%% Puissance du bruit initial
f_max_baseband=kf+f_symb; %voir formule labo1 slide 9, avec f_c=0 car baseband.
f_cut = f_max_baseband*(1+0.1); %frequence de coupure du filtre
BWfilter=2*f_cut;

P_bruit_i=N_0*BWfilter;

SNRin=P_SSB_in/P_bruit_i;


%%% SRN OUT
%%%ratio de la puissance du signal_out et du bruit_out
P_SSB_out = (1/length(s_final_bruite)) * sum(s_final_bruite.*s_final_bruite);

%%%% Puissance du bruit final pure
%%%obtention
%%%bruit pur = signal non bruité dans le demodulateur - signal bruité dans le demodulateur
b_p = s_final_non_bruite - s_final_bruite;
P_bruit_pur = (1/length(b_p)) * sum(b_p.*b_p);

SNRout=P_SSB_out/P_bruit_pur;

%%%

FOM = SNRout/SNRin;










