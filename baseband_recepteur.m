function s_tild=baseband_recepteur(r_t,fc,t,f_max,fs)
%passage en bande de base du signal re�u, avec �tape de filtrage
%possibilit� de rajouter un d�phasage phi

%INPUTS
%-r_t: le message re�u depuis l'�metteur
%-fc: la fr�quence porteuse, connue
%-t: le vecteur de temps

%OUTPUTS
%-signal: le signal de sortie

%G�n�ration du filtre
N = 500;
f_cut = f_max*(1+0.1); %la fr�quence de coupure est choisie � 20% en plus de la fr�quence max du signal re�u.
%cr�ons la r�ponse en fr�quence du filtre pour faire la convolution (h(t))
h = fir1(N,2*f_cut/fs,'low',rectwin(N+1));

%party cos%%%%
c = r_t .* cos(2*pi*fc.*t);
c_filtre = conv(c , h);
c_filtre=c_filtre((N/2)+1:end-(N/2)); %pour �liminer les echantillons en plus
%introduits par le filtre

%party sin%%%%
s = r_t .* sin(2*pi*fc.*t);
s_filtre = conv(s , h);
s_filtre=1i.*s_filtre((N/2)+1:end-(N/2)); %pour �liminer les echantillons en plus
%introduits par le filtre

%addition des deux termes
s_tild = c_filtre + s_filtre;

