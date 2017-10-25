function [out] = quantizador(in, nbits)

% Esse quantizador fornece em sua sa�da (out) um sinal equivalente ao 
% sinal de entrada (in) representado com precis�o definida por um n�mero
% nbits.

% Varia��o entre os n�veis os n�veis de quantiza��o
delta = 2^(1-nbits); 

% O comprimento de out deve ser igual ao de in
out=zeros(1,length(in)); 

% O la�o abaixo faz a leitura de cada valor de in, o quantiza e escreve o
% na posi��o equivalente de out
for i=1:1:length(in)
    
    % Satura��o negativa
    if (in(i) <= -1)
        
        % Qualquer valor que se encaixe nessa condi��o dever� ser quantizado
        % para o valor m�nimo permitido pelo quantizador, ou seja, -1. N�o h� 
        % necessidade de passar pela etapa de quantifica��o.
        out(i) = -1;
    
    else
        
        % Satura��o positiva
        if (in(i) >= 1 - delta)
        
            % Qualquer valor que se encaixe nessa condi��o dever� ser
            % quantizado para o valor m�ximo permitido pelo quantizador, ou
            % seja, 1-delta. Tamb�m n�o h� necessidade de passar pela etapa
            % de verifica�o.
            out(i) = 1-delta;
        
        else
            
            % Quando -1<in<1, out dever� ser igual a in quantizado. �
            % poss�vel realizar essa fun��o por uma cadeia de "if"s, mas o
            % conjunto de instru��es abaixo � uma alternativa r�pida para 
            % efetuar essa mesma opera��o.
            out(i) = floor((in(i))*2^(nbits - 1)+0.5)/(2^(nbits-1));
        
        end
        
    end
    
end

end

