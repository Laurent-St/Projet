%main_fct_de_kf

%programme main où on fait varier kf et donc pas le rapport E_b/N_0 à la
%fin

%%% PARAMETRES %%%
f_symb=500;
T_symb=1/f_symb;
fs=20000;       %freq d'echantillonage de matlab
OSF=20000/f_symb;    %OSF=oversampling factor = nombre de pics par bit
                       %fs = 20000 c'est la fréquence typique matlab qu'il
                       %faut mettre pour respecter le critère de nitch
pics_par_T=OSF;
fc=6000;
%%%%%%%%%%%%%%%%%%

%%%% CREATION DES BITS %%%%
N=1000;
bits=randi(2,1,N)-1;

vecteur_kf=50:25:1000;
vecteur_BER_FM=[];
vecteur_BER_FSK=[];

x=0;
for kf=50:25:1000
    x=x+1;
    %%%% EMISSION DU SIGNAL %%%%

    [s_t_emis,temps]=emetteur(bits,kf);
    
    %%%Deux cas de reception  ATTENTION AUSSI FAIRE VARIER para_dephasage EN BAS

    %%%sans déphasage
    phi = 0;

    %%%avec déphasage
    %phi = pi/4; %introduction d'un déphasage à la reception en effet rien ne dit que reception instantanée

    %%%% RECEPTION DU SIGNAL NON BRUITE %%%%
    phi = pi/4; %introduction d'un déphasage à la reception en effet rien ne dit il reception instantannée
    s_tild_non_bruite=recepteur(s_t_emis,temps,phi,kf);
    m_final_non_bruite=demodulation_FM(s_tild_non_bruite,f_symb,kf,fs,OSF,temps);

    %%%% AJOUT DU BRUIT %%%
    rapport=6;
    [bruit_n,N_0]=bruit(rapport,s_t_emis,bits);
    r_t=s_t_emis+bruit_n;

    %%%% RECEPTION DU SIGNAL BRUITE %%%%
    s_tild=recepteur(r_t,temps,phi,kf);

    %%%% DEMODULATION FM %%%
    m_final_bruite=demodulation_FM(s_tild,f_symb,kf,fs,OSF,temps);

    %%% DEMODULATION FSK %%%
    %%% avec déphasage
    % para_dephasage=1;
    % m_final_FSK=demodulation_FSK(s_tild,f_symb,kf,fs,OSF,temps,para_dephasage);

    %%% sans déphasage
    para_dephasage=0;
    m_final_FSK=demodulation_FSK(s_tild,f_symb,kf,fs,OSF,temps,para_dephasage);
    
    %%% BER
    soustraction_FM=bits-m_final_bruite;
    soustraction_FSK=bits-m_final_FSK;
    
    bits_errones_FM=sum(abs(soustraction_FM));
    bits_errones_FSK=sum(abs(soustraction_FSK));

    BER_FM=bits_errones_FM/length(m_final_bruite);
    BER_FSK=bits_errones_FSK/length(m_final_FSK);
    
    vecteur_BER_FM(x)=BER_FM;
    vecteur_BER_FSK(x)=BER_FSK;
    
end

plot(vecteur_kf,vecteur_BER_FM,'r');hold on;
plot(vecteur_kf,vecteur_BER_FSK,'g'); hold on;
xlabel('Selectivité fréquentielle k_f'); hold on;
ylabel('Bit Error Rate');