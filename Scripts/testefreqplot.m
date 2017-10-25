% Para testar o freqplot, arquivo que plota determinado sinal em cima do
% gabarito de verificação gerado pelas especificações, ter o valor das
% especificações é necessário.

% Frequência de amostragem 
FA=44100; 

%LIMITANTES DO GABARITO DE VERIFICAÇÃO

Ap=0.1; % Ripple máximo na banda passante.

% deltap = conversão para escala linear de Ap
deltap=(10^(Ap/20)-1)/((10^(Ap/20)+1)); 
% deltap = 0.0058

As=40; % Atenuação mínima (em dB) na banda de rejeição.

% deltas = conversão para escala linear de As
deltas=10^(-(As/20)); 
% delta s = 0.01
%---

Fp=10000; % Frequência superior de banda passante.

% Wp = conversão para ângulo digital de Fp
Wp=2*pi*Fp/FA; % Ângulo superior de banda passante.
% Wp =  1.4248 = 0.4535*pi

Fs=15000; % Frequência inferior da banda de rejeição.

% Ws = conversão para ângulo digital de Fs
Ws=2*pi*Fs/FA; % Ângulo inferior da banda de rejeição.
% Ws = 2.1371 = 0,68*pi

%---

%Sugestão de Wc = 0,5*pi
Wc = 0.5*pi;

% É necessário que o eixox nesse caso cubra o espectro de frequência de 0
% até pi
eixox = 0:0.001:pi;

% Como deseja-se testar apenas se freqplot faz o gabarito aparecer no
% gráfico com o zoom adequado, uma função de entrada com comprimento igual
% ao de eixox com todos seus valores iguais 0 é bastante adequada.
h=zeros(1,length(eixox));

%%-------------------------------------------------------------------------

% Testando a opção do eixo Y em escala linear
Fig1 = freqplot(h,eixox,Wp,Ws,deltap,deltas,'linear',10,1);

% Testando a opção do eixo Y em escala logarítimica
Fig2 = freqplot(h,eixox,Wp,Ws,deltap,deltas,'log',10,1);