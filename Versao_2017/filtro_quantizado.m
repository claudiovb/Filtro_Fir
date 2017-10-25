clear all;close all;clc;

%% ESPECIFICA��ES E PAR�METROS

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
% Ws = 2.1371 = 0,6803*pi

%% FILTRO QUANTIZADO

% nbits = n�mero de bits que se deseja usar na quantiza��o
nbits = 2;
% nbits = 128 para precis�o infinita

%---

% Dupla de valores (M , Wc) do filtro causal
M = 114;
Wc = 0.58*pi;

%---

% h_a[n] ( h[n] truncada e deslocada ) ter� 2*M+ 1 amostras a partir de n = 0
n=0:1:2*M;     %N�mero de coeficientes = 2*M+1.

% Resposta ao impulso h[n] do filtro causal
h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

% Etapa de quantiza��o
h_q = quantizador (h_a,nbits); % h_q = h_a quantizado por nbits

% H = dtft de h_a[n] ( H_a(e^jw) )
% W = trecho do espectro de frequ�ncias de -pi a pi
[H_q,W] = dtft(h_q,10000);

% Gr�fico da resposta em frequ�ncia na escala linear
Fig1 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gr�fico da resposta em frequ�ncia na escala logar�tmica
Fig2 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% SWEEP

clc; close all; 

nbits = 10;

for M = 220 : 220
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi
        
        % h_a[n] ( h[n] truncada e deslocada ) ter� 2*M+ 1 amostras a partir de n = 0
        n=0:1:2*M;     %N�mero de coeficientes = 2*M+1.

        % Resposta ao impulso h[n] do filtro causal
        h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

        % Etapa de quantiza��o
        h_q = quantizador (h_a,nbits); % h_q = h_a quantizado por nbits

        % H = dtft de h_a[n] ( H_a(e^jw) )
        % W = trecho do espectro de frequ�ncias de -pi a pi
        [H_q,W] = dtft(h_q,10000);

%         % Gr�fico da resposta em frequ�ncia na escala linear
%         Fig1 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gr�fico da resposta em frequ�ncia na escala logar�tmica
        Fig2 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'log',M,Wc);
        
    end
    
end

