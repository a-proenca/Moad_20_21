
function [n,m,A,c,b,x,xB,cB,SBA,zjcj,z]=Progint(n,m,A,c,b,x,xB,cB,SBA,zjcj,z)
otima=0; % Flag que assinala se a solu��o atual � �tima ou n�o
while ~otima
    % Extrai a parte fracion�ria dos elementos da coluna b
    for i=1:m
        fraccb(i)=b(i)-floor(b(i));
    end
    % Assume que a solu��o � �tima
    otima=1;
    % Verifica quais das vari�veis originais est�o na base
    for j=1:n
        % Verifica se a variavel de indice j esta na base
        indexVB=find(xB==j); 
        if ~isempty(indexVB)     % �ndice j faz parte da base
            % Verifica se tem valor fraccion�rio
            if fraccb(indexVB)~=0
                otima=0;
            end
        end
    end
    % Se a solu��o for �tima informa utilizador
    if otima
        disp('A solu��o � otima para o problema de PLIP')
        disp('--> Todas as vari�veis originais s�o inteiras!')
        pause
    % Sen�o constr�i restri��o de corte 
    else
        disp('Existem vari�veis originais com valor fracionario')
        disp('---> Tem que se introduzir uma restri��o de corte')
        disp('     e resolver pelo m�todo dual do Simplex')
        pause
        % Selecciona fs0
        [fs0,linha_fs0]=max(fraccb);    
        % Inicializa restri��o
        restricao=zeros(1,n+m);
        % Calcula partes fracionarias dos elementos da linha_fs0
        fraccA=zeros(1,n+m);
        for j=1:n+m
            fraccA(j)=A(linha_fs0,j)-floor(A(linha_fs0,j));
        end
        % Selecciona variaveis para a restri��o de corte
        for j=1:n+m
            % Verifica se a variavel de indice j n�o est� na base
            indexVB=find(xB==j);
            if isempty(indexVB)
                restricao(j)=fraccA(j);
            end
        end
        % Transformar a restri��o numa de "<="
        restricao=-restricao;
        % Incrementa o n� de restri��es
        m=m+1;  
        % Cria uma coluna para uma nova vari�vel "slack"
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
        % Resolve novo problema pelo m�todo dual do Simplex
        [n,m,A,c,b,x,xB,cB,SBA,zjcj,z]=MDSimplex(n,m,A,c,b,x,xB,cB,SBA,zjcj);
        % Apresenta a solu�ao optima e o valor de Z optimo
        Apresenta_resultados_finais(n,m,SBA,z,0);
    end
end
end
