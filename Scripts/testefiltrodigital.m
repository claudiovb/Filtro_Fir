% Para testar o filtro, um impulso foi inserido na entrada e observou-se a
% saída. Espera-se uma função do tipo sinc na saída.

% Dupla de valores (M , Wc) do filtro causal
M = 114;
Wc = 0.58*pi;

% n = duração do filtro causal
n = 0:1:2*M; % amostras de h_a[n]

% Resposta ao impulso h[n] do filtro causal
h_a = (Wc/pi)*sinc((n-M)*Wc/pi);

% x[n] = impulso[n]
x = zeros(1,length(n));
x(1) = 1;

y = filtrodigital(x,h_a);
figure;
stem(y);
grid on;
xlabel('x[n]=Impulso[n]');
ylabel('y[n]');
set(gca,'XTick',0:20:2*M);
axis([0 2*M -0.1 0.6]);
