function s_tild=baseband_recepteur(r_t,fc,t,f_max,fs)
%passage en bande de base du signal reçu, avec étape de filtrage
%possibilité de rajouter un déphasage phi

%INPUTS
%-r_t: le message reçu depuis l'émetteur
%-fc: la fréquence porteuse, connue
%-t: le vecteur de temps

%OUTPUTS
%-signal: le signal de sortie

%Génération du filtre
N = 500;
f_cut = f_max*(1+0.1); %la fréquence de coupure est choisie à 20% en plus de la fréquence max du signal reçu.
%créons la réponse en fréquence du filtre pour faire la convolution (h(t))
h = fir1(N,2*f_cut/fs,'low',rectwin(N+1));

%party cos%%%%
c = r_t .* cos(2*pi*fc.*t);
c_filtre = conv(c , h);
c_filtre=c_filtre((N/2)+1:end-(N/2)); %pour éliminer les echantillons en plus
%introduits par le filtre

%party sin%%%%
s = r_t .* sin(2*pi*fc.*t);
s_filtre = conv(s , h);
s_filtre=1i.*s_filtre((N/2)+1:end-(N/2)); %pour éliminer les echantillons en plus
%introduits par le filtre

%addition des deux termes
s_tild = c_filtre + s_filtre;

