% nbits = número de bits usados na quatização apenas 3 serão usados somente
% para testar a funcionalidade do bloco quantizador
nbits=3;

% eixox = [-1.2 , 1.2] intervalo virtualmente contínuo sendo que 0.001 é
% muito menor que 1.2
eixox = -1.2:0.001:1.2;

% o sinal que passará pelo quantizador nesse teste será uma rampa com
% inclinação a = 1. Espera-se observar uma saída em forma de "escada" com
% saturação quando rampa < 1 ou rampa > 1 - delta
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