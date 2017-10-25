% Para testar o freqplot, arquivo que plota determinado sinal em cima do
% gabarito de verifica��o gerado pelas especifica��es, ter o valor das
% especifica��es � necess�rio.

% Frequ�ncia de amostragem 
FA=44100; 

%LIMITANTES DO GABARITO DE VERIFICA��O

Ap=0.1; % Ripple m�ximo na banda passante.

% deltap = convers�o para escala linear de Ap
deltap=(10^(Ap/20)-1)/((10^(Ap/20)+1)); 
% deltap = 0.0058

As=40; % Atenua��o m�nima (em dB) na banda de rejei��o.

% deltas = convers�o para escala linear de As
deltas=10^(-(As/20)); 
% delta s = 0.01
%---

Fp=10000; % Frequ�ncia superior de banda passante.

% Wp = convers�o para �ngulo digital de Fp
Wp=2*pi*Fp/FA; % �ngulo superior de banda passante.
% Wp =  1.4248 = 0.4535*pi

Fs=15000; % Frequ�ncia inferior da banda de rejei��o.

% Ws = convers�o para �ngulo digital de Fs
Ws=2*pi*Fs/FA; % �ngulo inferior da banda de rejei��o.
% Ws = 2.1371 = 0,68*pi

%---

%Sugest�o de Wc = 0,5*pi
Wc = 0.5*pi;

% � necess�rio que o eixox nesse caso cubra o espectro de frequ�ncia de 0
% at� pi
eixox = 0:0.001:pi;

% Como deseja-se testar apenas se freqplot faz o gabarito aparecer no
% gr�fico com o zoom adequado, uma fun��o de entrada com comprimento igual
% ao de eixox com todos seus valores iguais 0 � bastante adequada.
h=zeros(1,length(eixox));

%%-------------------------------------------------------------------------

% Testando a op��o do eixo Y em escala linear
Fig1 = freqplot(h,eixox,Wp,Ws,deltap,deltas,'linear',10,1);

% Testando a op��o do eixo Y em escala logar�timica
Fig2 = freqplot(h,eixox,Wp,Ws,deltap,deltas,'log',10,1);