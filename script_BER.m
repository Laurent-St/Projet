%script_BER
function liste_BER=BER(bits,signal_final_bruite)
% INPUTS:
%signal_emis : le signal émis par la fonction emmetteur (signal initial)
%signal_final : le signal après traitement par le recpteur (il contient
%donc l'effet du bruit)
% OUTPUT:
%BER: rapport du nombre de bits erronné sur le nombre de bits envoyé
% si le BER est élevé, alors le message est mal passé, si BER faible le
% signal a bien été transmis

rapport=[];
liste_BER=[]
for k=1:20
    rapport(k)=k;
    m_final=recepteur();
    soustraction=bits-m_final;
    bits_errones=sum(abs(soustraction));
    BER=bits_errones/length(m_final);
    liste_BER(k)=BER;
end

plot(rapport,liste_BER);
    
