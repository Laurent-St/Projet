function bits_recus = demodulation_FSK(s_tild,f_symb,kf,fs,OSF,temps,para_dephasage)

%s_tild = e_r, l'enveloppe complexe
%fs = frequence matlab
%fm = frequence du message une fois oversimplé, fsymbole
delta_N = fs/f_symb;
bits_recus=[];
e_s0=exp(-1j*2*pi*kf*(temps)); %hypothese0, c'est un bit 0
e_s1=exp(1j*2*pi*kf*(temps));     %hypothese1, c'est un bit 1

compteur=0; %pour le stockage des bits dans la liste
for L =1:delta_N:length(temps)-delta_N+1; %for pour chaque bit du message de départ
    compteur=compteur+1;
%     n = 1:1:delta_N -1;

    e_s0_temp=e_s0(L:L+delta_N-1);
    e_s1_temp=e_s1(L:L+delta_N-1);
    s_tild_temp=s_tild(L:L+delta_N-1);

    %corrélation du message avc l'hypo0
    res_0 = 0;
    res_1 = 0;
    
    %%% Produit scalaire pour l'hypothèse %%%
    for k = 1:1:delta_N -1  % for sur les valeurs de l'overssampling d'un bit
        res_0 = res_0 + s_tild_temp(k) * (e_s0_temp(k))';
        res_1 = res_1 + s_tild_temp(k) * (e_s1_temp(k))';
    end

    %%%on a introduit un déphasage donc on prend le module
    if para_dephasage == 1
        if abs(res_0) > abs(res_1)
            bit = 0;
        else
            bit = 1;
        end
    else
        if real(res_0) > real(res_1)
            bit = 0;
        else
            bit = 1;
        end
    end
    bits_recus(compteur) = bit;
end
        
    