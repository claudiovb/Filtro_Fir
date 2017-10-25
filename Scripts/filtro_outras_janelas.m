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


% Aproximação de M para as janelas de Hamming, Kaiser e Blackman.

% M aproximado considerando a janela de Hamming
M_H=ceil(3.32*pi/(Ws-Wp)); 
% M_H = 15

% M aproximado considerando a janela de Kaiser
M_K=ceil(32/(2.285*(Ws-Wp)));
%¨M_K = 20

% M aproximado considerando a janela de Blackman
M_B=ceil(5.56*pi/(Ws-Wp)); 
% M_B = 25

%% JANELA DE HAMMING

clc; close all; 

nbits = 8;

for M = 114 : 116
    
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi

        % h_a[n] ( h[n] truncada e deslocada ) terá 2*M + 1 amostras a partir de n = 0
        n=0:1:2*M;     %Número de coeficientes = 2*M+1.

        % Resposta ao impulso h[n] truncada pela janela de Hamming
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*hamming(length(n))'; 

        % Etapa de quantização
        h_q = quantizador(h,nbits);

        % A principal ferramenta de verificação é o gabarito que é válido no
        % domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
        % é necessário.

        % H = dtft de h[n] ( H(e^jw) )
        % W = trecho do espectro de frequências de -pi a pi
        [H,W] = dtft(h_q,10000);

%         % Gráfico da resposta em frequência na escala linear
%         Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gráfico da resposta em frequência na escala logarítmica
        Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);
    end
    
end

% Precisão infinita : M = 14 Wc = 0.57*pi

% 16 bits : M = 14 Wc = 0.57*pi

% 10 bits : M = 18 Wc = 0.56*pi

% 8 bits : não foi possível atender às especificações

%% JANELA DE KAISER

clc; close all; 

nbits = 8;

beta=0.1102*(As-8.7);

for M = 50 : 52
    
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi

        % h_a[n] ( h[n] truncada e deslocada ) terá 2*M + 1 amostras a partir de n = 0
        n=0:1:2*M;     %Número de coeficientes = 2*M+1.
        
        %Função de transferência com janela de Kaiser.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*kaiser(length(n),beta)';
        
        % Etapa de quantização
        h_q = quantizador(h,nbits);

        % A principal ferramenta de verificação é o gabarito que é válido no
        % domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
        % é necessário.

        % H = dtft de h[n] ( H(e^jw) )
        % W = trecho do espectro de frequências de -pi a pi
        [H,W] = dtft(h_q,10000);

%         % Gráfico da resposta em frequência na escala linear
%         Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gráfico da resposta em frequência na escala logarítmica
        Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);
        
    end
    
end

% Precisão infinita : M = 13 Wc = 0.58*pi

% 16 bits : M = 13 Wc = 0.58*pi

% 10 bits : M = 16 Wc = 0.58*pi

% 8 bits : M = não foi possível atender às especificações

%% JANELA DE BLACKMAN

clc; close all; 

nbits = 8;

for M = 114 : 116
    
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi

        % h_a[n] ( h[n] truncada e deslocada ) terá 2*M + 1 amostras a partir de n = 0
        n=0:1:2*M;     %Número de coeficientes = 2*M+1.
        
        %Função de transferência com janela de Blackman.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*blackman(length(n))';
        
        % Etapa de quantização
        h_q = quantizador(h,nbits);

        % A principal ferramenta de verificação é o gabarito que é válido no
        % domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
        % é necessário.

        % H = dtft de h[n] ( H(e^jw) )
        % W = trecho do espectro de frequências de -pi a pi
        [H,W] = dtft(h_q,10000);

%         % Gráfico da resposta em frequência na escala linear
%         Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gráfico da resposta em frequência na escala logarítmica
        Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc); 
        
    end
    
end

% Precisão infinita : M = 19 Wc = 0.57*pi

% 16 bits : M = 19 Wc = 0.57*pi

% 10 bits : M = 22 Wc = 0.56*pi

% 8 bits : não foi possível atender às especificações


        