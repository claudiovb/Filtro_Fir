clear all;close all;clc;


janela = 'hamming';
% 'retangular' 'hamming' 'kaiser' 'blackmann'

nbits = 16;
% 8 10 16 - nbits = 128 para precis�o infinita

% Os valores �timos de M e Wc j� foram determinados para todos 16 filtros
% e est�o dispon�veis nesse script. 

% O switch case abaixo retorna M e Wc que geram um filtro h[n] com as
% caracter�sticas desejadas de janela e nbits e que atendam �s
% especifica��es.

% concatena��o de janela com nbits para facilitar o switch
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
        disp('Especifica��es n�o foram atingidas nessa situa��o!');
    
    case 'retangular8'
    
        M = 114;
        Wc = 0.58*pi;
        disp('Especifica��es n�o foram atingidas nessa situa��o!');
    
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
        disp('Especifica��es n�o foram atingidas nessa situa��o!');
        
        
        
% Usando a janela Kaiser outro parametros � necess�rio para definir bem o
% comportamento da janela. Esse par�metro se chama beta e pode ser estimado
% pela express�o seguinte.
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
        disp('Especifica��es n�o foram atingidas nessa situa��o!');
        
        
        
        
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
        disp('Especifica��es n�o foram atingidas nessa situa��o!');
    
    otherwise
        
        disp('Op��o inv�lida');

end

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

%% DETERMINA��O DA FUN��O DE TRANSFER�NCIA DO FILTRO

% h_a[n] ( h[n] truncada e deslocada ) ter� 2*M + 1 amostras a partir de n = 0
n=0:1:2*M;     %N�mero de coeficientes = 2*M+1.

% A partir dos valores escolhidos para Wc, M, do tipo de janela e de nbits
% ser� gerada a resposta ao impulso adequada e quantizada..

switch (janela) 
    
    case 'retangular'
        
        %Fun��o de transfer�ncia com janela retangular.
        h=(Wc/pi)*sinc((n-M)*Wc/pi);    
        
    case 'hamming'
        
        %Fun��o de transfer�ncia com janela de Hamming.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*hamming(length(n))'; 
        
        
    case 'kaiser'
        %Fun��o de transfer�ncia com janela de Kaiser.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*kaiser(length(n),beta)';
        
    case 'blackman'
        
        %Fun��o de transfer�ncia com janela de Blackman.
        h=(Wc/pi)*sinc((n-M)*Wc/pi).*blackman(length(n))';
        
    otherwise
        
        %Caso haja algum erro a seguinte imagem � retornada.
        disp('Op��o inv�lida para janela');
        
end

% Etapa de quantiza��o
h_q = quantizador(h,nbits);

% A principal ferramenta de verifica��o � o gabarito que � v�lido no
% dom�nio da frequ�ncia. Por isso o c�lculo da DTFT da resposta ao impulso
% � necess�rio.

% H = dtft de h[n] ( H(e^jw) )
% W = trecho do espectro de frequ�ncias de -pi a pi
[H,W] = dtft(h_q,10000);

% Gr�fico da resposta em frequ�ncia na escala linear
Fig1 = freqplot(H,W,Wp,Ws,deltap,deltas,'linear',M,Wc);

% Gr�fico da resposta em frequ�ncia na escala logar�tmica
Fig2 = freqplot(H,W,Wp,Ws,deltap,deltas,'log',M,Wc);

%% FILTRAGEM

% O teste final do filtro ser� feito explorando uma caracter�stica de
% resposta ao impulso.
% Espera-se que um impulso filtrado por h[n] e espera-se que a sa�da seja 
% um sinc multiplicado por Wc/pi com dura��o 2M + 1 e atrasamo M amostras,
% ou seja, o proprio h[n].

% x[n] = impulso[n] de dura��o arbitr�ria (por exemplo 200)
x = zeros(1,length(h));
x(1) = 1;

x_q = quantizador (x, nbits);

% y[n] = x[n] filtrado por h[n] = x[n] conv h[n]
y=filtrodigital(x_q,h);

y_q=quantizador(y,nbits);

figure;stem(y_q);xlabel('x[n]=Impulso[n]');ylabel('y[n]');