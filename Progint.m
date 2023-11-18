
function [n,m,A,c,b,x,xB,cB,SBA,zjcj,z]=Progint(n,m,A,c,b,x,xB,cB,SBA,zjcj,z)
otima=0; % Flag que assinala se a solução atual é ótima ou não
while ~otima
    % Extrai a parte fracionária dos elementos da coluna b
    for i=1:m
        fraccb(i)=b(i)-floor(b(i));
    end
    % Assume que a solução é ótima
    otima=1;
    % Verifica quais das variáveis originais estão na base
    for j=1:n
        % Verifica se a variavel de indice j esta na base
        indexVB=find(xB==j); 
        if ~isempty(indexVB)     % Índice j faz parte da base
            % Verifica se tem valor fraccionário
            if fraccb(indexVB)~=0
                otima=0;
            end
        end
    end
    % Se a solução for ótima informa utilizador
    if otima
        disp('A solução é otima para o problema de PLIP')
        disp('--> Todas as variáveis originais são inteiras!')
        pause
    % Senão constrói restrição de corte 
    else
        disp('Existem variáveis originais com valor fracionario')
        disp('---> Tem que se introduzir uma restrição de corte')
        disp('     e resolver pelo método dual do Simplex')
        pause
        % Selecciona fs0
        [fs0,linha_fs0]=max(fraccb);    
        % Inicializa restrição
        restricao=zeros(1,n+m);
        % Calcula partes fracionarias dos elementos da linha_fs0
        fraccA=zeros(1,n+m);
        for j=1:n+m
            fraccA(j)=A(linha_fs0,j)-floor(A(linha_fs0,j));
        end
        % Selecciona variaveis para a restrição de corte
        for j=1:n+m
            % Verifica se a variavel de indice j não está na base
            indexVB=find(xB==j);
            if isempty(indexVB)
                restricao(j)=fraccA(j);
            end
        end
        % Transformar a restrição numa de "<="
        restricao=-restricao;
        % Incrementa o nº de restrições
        m=m+1;  
        % Cria uma coluna para uma nova variável "slack"
        novacol=zeros(m,1);
        novacol(m)=1;
        % Actualiza variaveis
        A=[A; restricao];
        A=[A novacol];
        c=[c 0];
        x=[x (n+m)];
        xB(m)=n+m;
        cB(m)=0;
        b=[b;-fs0];
        SBA=[SBA;0];
        zjcj=[zjcj 0];
        % Resolve novo problema pelo método dual do Simplex
        [n,m,A,c,b,x,xB,cB,SBA,zjcj,z]=MDSimplex(n,m,A,c,b,x,xB,cB,SBA,zjcj);
        % Apresenta a soluçao optima e o valor de Z optimo
        Apresenta_resultados_finais(n,m,SBA,z,0);
    end
end
end
