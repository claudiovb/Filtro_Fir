function [out] = freqplot(in,x,Wp,Ws,deltap,deltas,eixoy,M,Wc)

%A função é usada repetidamente e deseja-se criar figurars diferentes.
%Dessa forma é necessário a cada vez que freqplot seja invocada, uma nova
%figura deve ser criada.
figure;

%Essa é uma função auxiliar que plota o gráfico da resposta em frequência
%do filtro projetado em cima do gabarito para facilitar a primeira etapa da
%verificação.
%in é a função que será plotada; x é o eixo x normalizado; Wp, Ws, deltap e
%deltas são usados para formar as linhas que compõe o gabarito; e eixoy
%decide a escala para o eixo y do gráfico a ser plotado.

switch (eixoy)
    case ('linear')
        %Nesse caso o eixo y é apresentado em escala linear.
        
        plot(x,abs(in),'r');
        
        xlabel('W');
        ylabel('IH(e^jW)I');
%         grid on;
        set(gca,'XTick',0:pi/10:pi);
        set(gca,'XTickLabel',{'0','0.1*pi','0.2*pi','0.3*pi','0.4*pi','0.5*pi','0.6*pi','0.7*pi','0.8*pi','0.9*pi','pi'});
        leg = legend(['M = ',num2str(M),' ','Wc = ',num2str(Wc/pi),'pi']);
        set(leg,'Location','NorthEast');
        %axis define o "zoom" dado na imagem.
        axis([0 pi 0 1.1]);
        %Os comandos abaixo formam o gabarito.
        line([0 Wp],[(1-deltap) (1-deltap)],'Color',[.1 .1 .1]);
        line([0 0], [0 (1-deltap)],'Color',[.1 .1 .1]);
        line([Wp Wp], [0 1-deltap],'Color',[.1 .1 .1]);
        line([0 Wp],[(1+deltap) (1+deltap)],'Color',[.1 .1 .1]);
        line([0 0], [1.1 (1+deltap)],'Color',[.1 .1 .1]);
        line([Wp Wp], [1.1 (1+deltap)],'Color',[.1 .1 .1]);
        line([Ws Ws], [deltas 1.1],'Color',[.1 .1 .1]);
        line([Ws pi], [deltas deltas],'Color',[.1 .1 .1]);
    
    case ('log')
        %Nesse caso o eixo y é apresentado em escala logarítmica.
        
        semilogy(x,abs(in),'r');
        
        xlabel('W');
        ylabel('log ( IH(e^jW )I )');
%         grid on;
        set(gca,'XTick',0:pi/10:pi);
        set(gca,'XTickLabel',{'0','0.1*pi','0.2*pi','0.3*pi','0.4*pi','0.5*pi','0.6*pi','0.7*pi','0.8*pi','0.9*pi','pi'});
        leg = legend(['M = ',num2str(M),' ','Wc = ',num2str(Wc/pi),'pi']);
        set(leg,'Location','NorthEast');
        %axis define o "zoom" dado na imagem.
        axis([0 pi 0.00001 1.1]);
        %Os comandos abaixo formam o gabarito.
        line([0 Wp],[(1-deltap) (1-deltap)],'Color',[.1 .1 .1]);
        line([0 0], [0.0000000000001 (1-deltap)],'Color',[.1 .1 .1]);
        line([Wp Wp], [0.0000000000001 1-deltap],'Color',[.1 .1 .1]);
        line([0 Wp],[(1+deltap) (1+deltap)],'Color',[.1 .1 .1]);
        line([0 0], [1.1 (1+deltap)],'Color',[.1 .1 .1]);
        line([Wp Wp], [1.1 (1+deltap)],'Color',[.1 .1 .1]);
        line([Ws Ws], [deltas 1.1],'Color',[.1 .1 .1]);
        line([Ws pi], [deltas deltas],'Color',[.1 .1 .1]);
    
    otherwise
        
        disp('Opção inválida');
end

% Retornar o vetor de entrada se demonstrou feature interessante para essa
% função.
out=in;

end



%