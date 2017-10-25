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

%---

%Sugestão de Wc = 0,5*pi
Wc = 0.5*pi;

%% FILTRO IDEAL: h[n] = (Wc/pi)*sinc(n*Wc/pi)
M = 2000;
% Para simular a duração infinita de h[n] supôs-se -1000 <= n <= 1000
n = -1000:1000;

% Resposta ao impulso h[n] de um filtro ideal 
h = (Wc/pi)*sinc(n*Wc/pi);

%---

% A principal ferramenta de verificação é o gabarito que é válido no
% domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
% é necessário.

% H = dtft de h[n] ( H(e^jw) )
% W = trecho do espectro de frequências de -pi a pi
[H,W] = dtft(h,15000);

%---

% Gráfico da resposta em frequência na escala linear
Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gráfico da resposta em frequência na escala logarítmica
Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% FILTRO CAUSAL: h_a[n] = (Wc/pi)*sinc((n-M)*Wc/pi); M = 34 Wc = 0.5*pi

% Fórmula de Kaiser para estimar a ordem de um filtro FIR passa baixas
N = (20*log10(sqrt(deltas*deltap))+13)/(14.6*(Wp-Ws)/(2*pi));

% Força N a ser par tendo em vista que N = 2*M
N = 2*(ceil(N/2));

% N = ordem do filtro FIR = 2*M
M = N/2;

% h_a[n] ( h[n] truncada e deslocada ) terá 2*M + 1 amostras a partir de n = 0
n = 0:1:2*M; % amostras de h_a[n]

% Resposta ao impulso h[n] do filtro causal gerado a partir de h[n]
h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

%---

% A principal ferramenta de verificação é o gabarito que é válido no
% domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
% é necessário.

% H = dtft de h_a[n] ( H_a(e^jw) )
% W = trecho do espectro de frequências de -pi a pi
[H_a,W] = dtft(h_a,10000);

%---

% Gráfico da resposta em frequência na escala linear
Fig3 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gráfico da resposta em frequência na escala logarítmica
Fig4 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% SWEEP

clc; close all; 

for M = 112 : 114
    for Wc = 0.46*pi : 0.01*pi : 0.68*pi
        
        % h_a[n] ( h[n] truncada e deslocada ) terá 2*M + 1 amostras a partir de n = 0
        n = 0:1:2*M; % amostras de h_a[n]
        
        % Resposta ao impulso h[n] do filtro causal gerado a partir de h[n]
        h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

        %---

        % A principal ferramenta de verificação é o gabarito que é válido no
        % domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
        % é necessário.
        
        % H = dtft de h_a[n] ( H_a(e^jw) )
        % W = trecho do espectro de frequências de -pi a pi
        [H_a,W] = dtft(h_a,10000);

        %---

        % Gráfico da resposta em frequência na escala linear
%         Fig3 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'linear');

        % Gráfico da resposta em frequência na escala logarítmica
        Fig4 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'log',M,Wc);
                
    end
end

%% FILTRO CAUSAL: h_a[n] = (Wc/pi)*sinc((n-M)*Wc/pi); M = 114 Wc = 0.58*pi

clc; close all; 

% Dupla de valores (M , Wc) que miniiza M obtida pelo SWEEP acima
M = 114;
Wc = 0.58*pi;


% h_a[n] ( h[n] truncada e deslocada ) terá 2*M + 1 amostras a partir de n = 0
n = 0:1:2*M; % amostras de h_a[n]

% Resposta ao impulso h[n] do filtro causal gerado a partir de h[n]
h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

%---

% A principal ferramenta de verificação é o gabarito que é válido no
% domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
% é necessário.

% H = dtft de h_a[n] ( H_a(e^jw) )
% W = trecho do espectro de frequências de -pi a pi
[H_a,W] = dtft(h_a,10000);

%---

% Gráfico da resposta em frequência na escala linear
Fig3 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gráfico da resposta em frequência na escala logarítmica
Fig4 = freqplot(H_a,W,Wp,Ws,deltap,deltas,'log',M,Wc);


% O teste final do filtro será feito explorando uma característica de
% resposta ao impulso.
% Espera-se que um impulso filtrado por h[n] e espera-se que a saída seja 
% um sinc multiplicado por Wc/pi com duração 2M + 1 e atrasamo M amostras,
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



