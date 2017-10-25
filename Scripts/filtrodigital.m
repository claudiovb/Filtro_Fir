function [out]= filtrodigital (in,h)

% Esse bloco � respons�vel por filtrar o sinal x[n]. out recebe in filtrado
% pelo filtro composto pelos coeficientes de h. O vetor mem simula a mem�ria
% que armazena amostras atrasadas de x[n].

% Em outras palavras este c�digo monta a estutura de um filtro FIR

% O comprimento de out deve ser igual ao de in.
out=zeros([1,length(in)]); 

% O comprimento de mem deve ser igual ao de h. 
mem=zeros([1,length(h)]); 

for i=1:length(in)
    mem(1)=in(i); 
    
    for j=1:length(h)              %Nesse for � feito mem[i]*h[i] para cada
        out(i)=mem(j)*h(j)+out(i); %i e a soma de todos esses valores.
    end
    
    for k=length(mem):-1:2 %Essa parte do c�digo � respons�vel por simular
        mem(k)=mem(k-1);   %o atraso na mem�ria inserido por cada um dos 
    end                    %delays que comp�e o filtro.
    
end

end


