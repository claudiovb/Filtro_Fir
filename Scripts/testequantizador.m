% nbits = n�mero de bits usados na quatiza��o apenas 3 ser�o usados somente
% para testar a funcionalidade do bloco quantizador
nbits=3;

% eixox = [-1.2 , 1.2] intervalo virtualmente cont�nuo sendo que 0.001 �
% muito menor que 1.2
eixox = -1.2:0.001:1.2;

% o sinal que passar� pelo quantizador nesse teste ser� uma rampa com
% inclina��o a = 1. Espera-se observar uma sa�da em forma de "escada" com
% satura��o quando rampa < 1 ou rampa > 1 - delta
% delta = 2^(1-nbits)
rampa = -1.2:0.001:1.2;

% rampa_quantizada = rampa quantizada com nbits = 3
rampa_quantizada = quantizador(rampa, nbits);

%%-------------------------------------------------------------------------
plot(eixox,rampa_quantizada);
hold on;
plot(eixox,rampa,'r'); 
hold off;
axis([-1.2 1.2 -1.2 1.2]);
leg = legend(['Rampa Quantizada'], ['Rampa']);
set(leg,'Location','SouthEast');
grid on;