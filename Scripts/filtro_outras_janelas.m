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


% Aproxima��o de M para as janelas de Hamming, Kaiser e Blackman.

% M aproximado considerando a janela de Hamming
M_H=ceil(3.32*pi/(Ws-Wp)); 
% M_H = 15

% M aproximado considerando a janela de Kaiser
M_K=ceil(32/(2.285*(Ws-Wp)));
%�M_K = 20

% M aproximado considerando a janela de Blackman
M_B=ceil(5.56*pi/(Ws-Wp)); 
% M_B = 25

%% JANELA DE HAMMING

clc; close all; 

nbits = 8;

for M = 114 : 116
    
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi

        % h_a[n] ( h[n] truncada e deslocada ) ter� 2*M + 1 amostras a partir de n = 0
        n=0:1:2*M;     %N�mero de coeficientes = 2*M+1.

        % Resposta ao impulso h[n] truncada pela janela de Hamming
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*hamming(length(n))'; 

        % Etapa de quantiza��o
        h_q = quantizador(h,nbits);

        % A principal ferramenta de verifica��o � o gabarito que � v�lido no
        % dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
        % � necess�rio.

        % H = dtft de h[n] ( H(e^jw) )
        % W = trecho do espectro de frequ�ncias de -pi a pi
        [H,W] = dtft(h_q,10000);

%         % Gr�fico da resposta em frequ�ncia na escala linear
%         Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gr�fico da resposta em frequ�ncia na escala logar�tmica
        Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);
    end
    
end

% Precis�o infinita : M = 14 Wc = 0.57*pi

% 16 bits : M = 14 Wc = 0.57*pi

% 10 bits : M = 18 Wc = 0.56*pi

% 8 bits : n�o foi poss�vel atender �s especifica��es

%% JANELA DE KAISER

clc; close all; 

nbits = 8;

beta=0.1102*(As-8.7);

for M = 50 : 52
    
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi

        % h_a[n] ( h[n] truncada e deslocada ) ter� 2*M + 1 amostras a partir de n = 0
        n=0:1:2*M;     %N�mero de coeficientes = 2*M+1.
        
        %Fun��o de transfer�ncia com janela de Kaiser.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*kaiser(length(n),beta)';
        
        % Etapa de quantiza��o
        h_q = quantizador(h,nbits);

        % A principal ferramenta de verifica��o � o gabarito que � v�lido no
        % dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
        % � necess�rio.

        % H = dtft de h[n] ( H(e^jw) )
        % W = trecho do espectro de frequ�ncias de -pi a pi
        [H,W] = dtft(h_q,10000);

%         % Gr�fico da resposta em frequ�ncia na escala linear
%         Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gr�fico da resposta em frequ�ncia na escala logar�tmica
        Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);
        
    end
    
end

% Precis�o infinita : M = 13 Wc = 0.58*pi

% 16 bits : M = 13 Wc = 0.58*pi

% 10 bits : M = 16 Wc = 0.58*pi

% 8 bits : M = n�o foi poss�vel atender �s especifica��es

%% JANELA DE BLACKMAN

clc; close all; 

nbits = 8;

for M = 114 : 116
    
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi

        % h_a[n] ( h[n] truncada e deslocada ) ter� 2*M + 1 amostras a partir de n = 0
        n=0:1:2*M;     %N�mero de coeficientes = 2*M+1.
        
        %Fun��o de transfer�ncia com janela de Blackman.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*blackman(length(n))';
        
        % Etapa de quantiza��o
        h_q = quantizador(h,nbits);

        % A principal ferramenta de verifica��o � o gabarito que � v�lido no
        % dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
        % � necess�rio.

        % H = dtft de h[n] ( H(e^jw) )
        % W = trecho do espectro de frequ�ncias de -pi a pi
        [H,W] = dtft(h_q,10000);

%         % Gr�fico da resposta em frequ�ncia na escala linear
%         Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

        % Gr�fico da resposta em frequ�ncia na escala logar�tmica
        Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc); 
        
    end
    
end

% Precis�o infinita : M = 19 Wc = 0.57*pi

% 16 bits : M = 19 Wc = 0.57*pi

% 10 bits : M = 22 Wc = 0.56*pi

% 8 bits : n�o foi poss�vel atender �s especifica��es


        