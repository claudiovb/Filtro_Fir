function [out]= filtrodigital (in,h)

% Esse bloco é responsável por filtrar o sinal x[n]. out recebe in filtrado
% pelo filtro composto pelos coeficientes de h. O vetor mem simula a memória
% que armazena amostras atrasadas de x[n].

% Em outras palavras este código monta a estutura de um filtro FIR

% O comprimento de out deve ser igual ao de in.
out=zeros([1,length(in)]); 

% O comprimento de mem deve ser igual ao de h. 
mem=zeros([1,length(h)]); 

for i=1:length(in)
    mem(1)=in(i); 
    
    for j=1:length(h)              %Nesse for é feito mem[i]*h[i] para cada
        out(i)=mem(j)*h(j)+out(i); %i e a soma de todos esses valores.
    end
    
    for k=length(mem):-1:2 %Essa parte do código é responsável por simular
        mem(k)=mem(k-1);   %o atraso na memória inserido por cada um dos 
    end                    %delays que compõe o filtro.
    
end

end


