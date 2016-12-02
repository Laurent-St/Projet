%script_BER
function liste_BER=BER(bits,signal_final_bruite)
% INPUTS:
%signal_emis : le signal �mis par la fonction emmetteur (signal initial)
%signal_final : le signal apr�s traitement par le recpteur (il contient
%donc l'effet du bruit)
% OUTPUT:
%BER: rapport du nombre de bits erronn� sur le nombre de bits envoy�
% si le BER est �lev�, alors le message est mal pass�, si BER faible le
% signal a bien �t� transmis

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
    
