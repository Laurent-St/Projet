%main

%%% PARAMETRES %%%
f_symb=500;
T_symb=1/f_symb;
OSF=20000/f_symb;    %OSF=oversampling factor = nombre de pics par bit
                       %fs = 20000 c'est la fréquence typique matlab qu'il
                       %faut mettre pour respecter le critère de nitch
pics_par_T=OSF;
kf=500;
fc=6000;
%%%%%%%%%%%%%%%%%%

%%%% CREATION DES BITS %%%%
N=1000;
bits=randi(2,1,N)-1;

%%%% EMISSION DU SIGNAL %%%%

[s_t_emis,temps]=emetteur(bits);

%%%% RECEPTION DU SIGNAL NON BRUITE %%%%

m_final_non_bruite=recepteur(s_t_emis,temps);

%%%% AJOUT DU BRUIT %%%
rapport=6;
[bruit_n,N_0]=bruit(rapport,s_t_emis,bits);
r_t=s_t_emis+bruit_n;

%%%% RECEPTION DU SIGNAL BRUITE %%%%
m_final_bruite=recepteur(r_t,temps);

%%%% AFFICHAGE_BER ET FOM%%%%
rapport_BER=[];
liste_BER=[];
liste_FOM=[];
for k=1:20
    rapport_BER(k)=k;
    [bruit_n_BER,N_0]=bruit(k,s_t_emis,bits);
    r_t_BER=s_t_emis+bruit_n_BER;
    m_final_bruite_BER=recepteur(r_t_BER,temps);
    soustraction=bits-m_final_bruite_BER;
    bits_errones=sum(abs(soustraction));
    BER=bits_errones/length(m_final_bruite_BER);
    liste_BER(k)=BER;
    FOM = fom(kf,f_symb,N_0,s_t_emis,m_final_bruite_BER,m_final_non_bruite);
    liste_FOM(k)=FOM;
end

%plot(rapport_BER,liste_BER);
%plot(rapport_BER,liste_FOM);

%%%%FOM
%FOM = fom(kf,f_symb,N_0,s_t_emis,m_final_bruite,m_final_non_bruite);
