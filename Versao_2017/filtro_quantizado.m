clear all;close all;clc;

%% ESPECIFICAÇÕES E PARÂMETROS

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
% Ws = 2.1371 = 0,6803*pi

%% FILTRO QUANTIZADO

% nbits = número de bits que se deseja usar na quantização
nbits = 2;
% nbits = 128 para precisão infinita

%---

% Dupla de valores (M , Wc) do filtro causal
M = 114;
Wc = 0.58*pi;

%---

% h_a[n] ( h[n] truncada e deslocada ) terá 2*M+ 1 amostras a partir de n = 0
n=0:1:2*M;     %Número de coeficientes = 2*M+1.

% Resposta ao impulso h[n] do filtro causal
h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

% Etapa de quantização
h_q = quantizador (h_a,nbits); % h_q = h_a quantizado por nbits

% H = dtft de h_a[n] ( H_a(e^jw) )
% W = trecho do espectro de frequências de -pi a pi
[H_q,W] = dtft(h_q,10000);

% Gráfico da resposta em frequência na escala linear
Fig1 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gráfico da resposta em frequência na escala logarítmica
Fig2 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% SWEEP

clc; close all; 

nbits = 10;

for M = 220 : 220
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi
        
        % h_a[n] ( h[n] truncada e deslocada ) terá 2*M+ 1 amostras a partir de n = 0
        n=0:1:2*M;     %Número de coeficientes = 2*M+1.

        % Resposta ao impulso h[n] do filtro causal
        h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

        % Etapa de quantização
        h_q = quantizador (h_a,nbits); % h_q = h_a quantizado por nbits

        % H = dtft de h_a[n] ( H_a(e^jw) )
        % W = trecho do espectro de frequências de -pi a pi
        [H_q,W] = dtft(h_q,10000);

%         % Gráfico da resposta em frequência na escala linear
%         Fig1 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gráfico da resposta em frequência na escala logarítmica
        Fig2 = freqplot(H_q,W,Wp,Ws,deltap,deltas,'log',M,Wc);
        
    end
    
end

