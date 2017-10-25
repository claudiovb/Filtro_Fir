function [out] = quantizador(in, nbits)

% Esse quantizador fornece em sua saída (out) um sinal equivalente ao 
% sinal de entrada (in) representado com precisão definida por um número
% nbits.

% Variação entre os níveis os níveis de quantização
delta = 2^(1-nbits); 

% O comprimento de out deve ser igual ao de in
out=zeros(1,length(in)); 

% O laço abaixo faz a leitura de cada valor de in, o quantiza e escreve o
% na posição equivalente de out
for i=1:1:length(in)
    
    % Saturação negativa
    if (in(i) <= -1)
        
        % Qualquer valor que se encaixe nessa condição deverá ser quantizado
        % para o valor mínimo permitido pelo quantizador, ou seja, -1. Não há 
        % necessidade de passar pela etapa de quantificação.
        out(i) = -1;
    
    else
        
        % Saturação positiva
        if (in(i) >= 1 - delta)
        
            % Qualquer valor que se encaixe nessa condição deverá ser
            % quantizado para o valor máximo permitido pelo quantizador, ou
            % seja, 1-delta. Também não há necessidade de passar pela etapa
            % de verificaão.
            out(i) = 1-delta;
        
        else
            
            % Quando -1<in<1, out deverá ser igual a in quantizado. É
            % possível realizar essa função por uma cadeia de "if"s, mas o
            % conjunto de instruções abaixo é uma alternativa rápida para 
            % efetuar essa mesma operação.
            out(i) = floor((in(i))*2^(nbits - 1)+0.5)/(2^(nbits-1));
        
        end
        
    end
    
end

end

