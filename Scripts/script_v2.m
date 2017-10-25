clear all;close all;clc;


janela = 'hamming';
% 'retangular' 'hamming' 'kaiser' 'blackmann'

nbits = 16;
% 8 10 16 - nbits = 128 para precisão infinita

% Os valores ótimos de M e Wc já foram determinados para todos 16 filtros
% e estão disponíveis nesse script. 

% O switch case abaixo retorna M e Wc que geram um filtro h[n] com as
% características desejadas de janela e nbits e que atendam às
% especificações.

% concatenação de janela com nbits para facilitar o switch
escolha = [janela , num2str(nbits)];

switch (escolha)
    case 'retangular128'
        
        M = 114;
        Wc = 0.58*pi;
        
    case 'retangular16'
        
        M = 114;
        Wc = 0.58*pi;
    
    case 'retangular10'
        
        M = 114;
        Wc = 0.58*pi;
        disp('Especificações não foram atingidas nessa situação!');
    
    case 'retangular8'
    
        M = 114;
        Wc = 0.58*pi;
        disp('Especificações não foram atingidas nessa situação!');
    
    case 'hamming128'
        
        M = 14;
        Wc = 0.57*pi;
    
    case 'hamming16'
        
        M = 14;
        Wc = 0.57*pi;
    
    case 'hamming10'
        
        M = 18;
        Wc = 0.56*pi;
    
    case 'hamming8'
        
        M = 114;
        Wc = 0.58*pi;
        disp('Especificações não foram atingidas nessa situação!');
        
        
        
% Usando a janela Kaiser outro parametros é necessário para definir bem o
% comportamento da janela. Esse parâmetro se chama beta e pode ser estimado
% pela expressão seguinte.
% beta=0.1102*(As-8.7);
% beta = 3.4493;

    case 'kaiser128'
        
        M = 13; 
        Wc = 0.58*pi;
        beta=0.1102*(40-8.7);
    
    case 'kaiser16'
        
        M = 13; 
        Wc = 0.58*pi;
        beta=0.1102*(40-8.7);
    
    case 'kaiser10'
        
        M = 16; 
        Wc = 0.58*pi;
        beta=0.1102*(40-8.7);
    
    case 'kaiser8'
    
        M = 114;
        Wc = 0.58*pi;
        beta=0.1102*(As-8.7);
        disp('Especificações não foram atingidas nessa situação!');
        
        
        
        
    case 'blackman128'
        
        M = 19;
        Wc = 0.57*pi;
    
    case 'blackman16'
        
        M = 19;
        Wc = 0.57*pi;
    
    case 'blackman10'
        
        M = 22; 
        Wc = 0.56*pi;
    
    case 'blackman8'
       
        M = 114;
        Wc = 0.58*pi;
        disp('Especificações não foram atingidas nessa situação!');
    
    otherwise
        
        disp('Opção inválida');

end

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

%% DETERMINAÇÃO DA FUNÇÃO DE TRANSFERÊNCIA DO FILTRO

% h_a[n] ( h[n] truncada e deslocada ) terá 2*M + 1 amostras a partir de n = 0
n=0:1:2*M;     %Número de coeficientes = 2*M+1.

% A partir dos valores escolhidos para Wc, M, do tipo de janela e de nbits
% será gerada a resposta ao impulso adequada e quantizada..

switch (janela) 
    
    case 'retangular'
        
        %Função de transferência com janela retangular.
        h=(Wc/pi)*sinc((n-M)*Wc/pi);    
        
    case 'hamming'
        
        %Função de transferência com janela de Hamming.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*hamming(length(n))'; 
        
        
    case 'kaiser'
        %Função de transferência com janela de Kaiser.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*kaiser(length(n),beta)';
        
    case 'blackman'
        
        %Função de transferência com janela de Blackman.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*blackman(length(n))';
        
    otherwise
        
        %Caso haja algum erro a seguinte imagem é retornada.
        disp('Opção inválida para janela');
        
end

% Etapa de quantização
h_q = quantizador(h,nbits);

% A principal ferramenta de verificação é o gabarito que é válido no
% domínio da frequência. Por isso o cálculo da DTFT da resposta ao impulso
% é necessário.

% H = dtft de h[n] ( H(e^jw) )
% W = trecho do espectro de frequências de -pi a pi
[H,W] = dtft(h_q,10000);

% Gráfico da resposta em frequência na escala linear
Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gráfico da resposta em frequência na escala logarítmica
Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% FILTRAGEM

% O teste final do filtro será feito explorando uma característica de
% resposta ao impulso.
% Espera-se que um impulso filtrado por h[n] e espera-se que a saída seja 
% um sinc multiplicado por Wc/pi com duração 2M + 1 e atrasamo M amostras,
% ou seja, o proprio h[n].

% x[n] = impulso[n] de duração arbitrária (por exemplo 200)
x = zeros(1,length(h));
x(1) = 1;

x_q = quantizador (x, nbits);

% y[n] = x[n] filtrado por h[n] = x[n] conv h[n]
y=filtrodigital(x_q,h);

y_q=quantizador(y,nbits);

figure;stem(y_q);xlabel('x[n]=Impulso[n]');ylabel('y[n]');