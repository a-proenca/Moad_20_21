% Limpa janela de comandos
clc 
disp('-------------------------------------------------------------------')
disp('        Resolucao de um problema pelo metodo dual do Simplex       ')
disp('-------------------------------------------------------------------')
disp(' Assume-se que:                                                    ')
disp(' -> Funcao objetivo esta na forma de minimizacao                   ')
disp(' -> Todas as restricoes sao de ">="                                ')
disp(' -> Todas as variaveis sao >=0                                     ')
disp('-------------------------------------------------------------------')
% Le dados do problema
[n,m,c,A,b]=Le_dados;
% Converte para o modelo standard
[c,A,b]=Converte(c,A,b);
% Inicializa variáveis
[A,c,b,x,xB,cB,SBA,zjcj]=Inicializa(n,m,A,c,b);
% Resolve pelo metodo dual do Simplex
[n,m,A,c,b,x,xB,cB,SBA,zjcj,z]=MDSimplex(n,m,A,c,b,x,xB,cB,SBA,zjcj);
% Apresenta valores de x* e z*
Apresenta_resultados_finais(n,m,SBA,z,1)