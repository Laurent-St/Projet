function m_final=demodulation_FM(s_tild,f_symb,kf,fs,OSF,temps)


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