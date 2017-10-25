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

%---

%Sugest�o de Wc = 0,5*pi
Wc = 0.5*pi;

%% FILTRO IDEAL: h[n] = (Wc/pi)*sinc(n*Wc/pi)
M = 2000;
% Para simular a dura��o infinita de h[n] sup�s-se -1000 <= n <= 1000
n = -1000:1000;

% Resposta ao impulso h[n] de um filtro ideal 
h = (Wc/pi)*sinc(n*Wc/pi);

%---

% A principal ferramenta de verifica��o � o gabarito que � v�lido no
% dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
% � necess�rio.

% H = dtft de h[n] ( H(e^jw) )
% W = trecho do espectro de frequ�ncias de -pi a pi
[H,W] = dtft(h,15000);

%---

% Gr�fico da resposta em frequ�ncia na escala linear
Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gr�fico da resposta em frequ�ncia na escala logar�tmica
Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% FILTRO CAUSAL: h_a[n] = (Wc/pi)*sinc((n-M)*Wc/pi); M = 34 Wc = 0.5*pi

% F�rmula de Kaiser para estimar a ordem de um filtro FIR passa baixas
N = (20*log10(sqrt(deltas*deltap))+13)/(14.6*(Wp-Ws)/(2*pi));

% For�a N a ser par tendo em vista que N = 2*M
N = 2*(ceil(N/2));

% N = ordem do filtro FIR = 2*M
M = N/2;

% h_a[n] ( h[n] truncada e deslocada ) ter� 2*M + 1 amostras a partir de n = 0
n = 0:1:2*M; % amostras de h_a[n]

% Resposta ao impulso h[n] do filtro causal gerado a partir de h[n]
h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

%---

% A principal ferramenta de verifica��o � o gabarito que � v�lido no
% dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
% � necess�rio.

% H = dtft de h_a[n] ( H_a(e^jw) )
% W = trecho do espectro de frequ�ncias de -pi a pi
[H_a,W] = dtft(h_a,10000);

%---

% Gr�fico da resposta em frequ�ncia na escala linear
Fig3 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gr�fico da resposta em frequ�ncia na escala logar�tmica
Fig4 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% SWEEP

clc; close all; 

for M = 112 : 114
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi
        
        % h_a[n] ( h[n] truncada e deslocada ) ter� 2*M + 1 amostras a partir de n = 0
        n = 0:1:2*M; % amostras de h_a[n]
        
        % Resposta ao impulso h[n] do filtro causal gerado a partir de h[n]
        h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

        %---

        % A principal ferramenta de verifica��o � o gabarito que � v�lido no
        % dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
        % � necess�rio.
        
        % H = dtft de h_a[n] ( H_a(e^jw) )
        % W = trecho do espectro de frequ�ncias de -pi a pi
        [H_a,W] = dtft(h_a,10000);

        %---

        % Gr�fico da resposta em frequ�ncia na escala linear
%         Fig3 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'linear');

        % Gr�fico da resposta em frequ�ncia na escala logar�tmica
        Fig4 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'log',M,Wc);
                
    end
end

%% FILTRO CAUSAL: h_a[n] = (Wc/pi)*sinc((n-M)*Wc/pi); M = 114 Wc = 0.58*pi

clc; close all; 

% Dupla de valores (M , Wc) que miniiza M obtida pelo SWEEP acima
M = 114;
Wc = 0.58*pi;


% h_a[n] ( h[n] truncada e deslocada ) ter� 2*M + 1 amostras a partir de n = 0
n = 0:1:2*M; % amostras de h_a[n]

% Resposta ao impulso h[n] do filtro causal gerado a partir de h[n]
h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

%---

% A principal ferramenta de verifica��o � o gabarito que � v�lido no
% dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
% � necess�rio.

% H = dtft de h_a[n] ( H_a(e^jw) )
% W = trecho do espectro de frequ�ncias de -pi a pi
[H_a,W] = dtft(h_a,10000);

%---

% Gr�fico da resposta em frequ�ncia na escala linear
Fig3 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gr�fico da resposta em frequ�ncia na escala logar�tmica
Fig4 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'log',M,Wc);


% O teste final do filtro ser� feito explorando uma caracter�stica de
% resposta ao impulso.
% Espera-se que um impulso filtrado por h[n] e espera-se que a sa�da seja 
% um sinc multiplicado por Wc/pi com dura��o 2M + 1 e atrasamo M amostras,
% ou seja, o proprio h[n].

% x[n] = impulso[n]
x = zeros(1,length(n));
x(1) = 1;

% y[n] = x[n] filtrado por h[n] = x[n] conv h[n]
y = filtrodigital(x,h_a);

figure;
stem(y);
grid on;
xlabel('x[n]=Impulso[n]');
ylabel('y[n]');
set(gca,'XTick',0:20:2*M);
axis([0 2*M -0.1 0.6]);



