function s0 = demodulateur(s_tild, f_symb, kf,fs)


%a facteur du slope ici fixé à 1
a= 1;
%delta_f = kf*Amplitude or ici amplitude=1
delta_f = kf;
BT = 2*delta_f + 2*f_symb; %bande-passante du message

% Calcul dérivée pour les slopes
delta_t=1/fs;
derivee=diff(s_tild); %diff donne un vecteur avec Sn - S(n-1), S(n-1)-S(n-2), etc.
derivee=[0 derivee];
derivee=(1/delta_t)*derivee; %par définition de la dérivée

%%%% CIRCUIT SLOPE 1 %%%%%

%fmessage = f_symbol 
s_tild_1 = a* (derivee + 1i * BT .* s_tild);

%on effectue le module de ceci pour supprimer l'exponentielle
abs_s_tild_1 = abs(s_tild_1);

%%%%% CIRCUIT SLOPE 2: Meme principe mais avec des - dans la formule %%%%
s_tild_2 = -a* (derivee - 1i * BT .* s_tild);
abs_s_tild_2=abs(s_tild_2);

% Obtention de s0

s0=abs_s_tild_1-abs_s_tild_2;



