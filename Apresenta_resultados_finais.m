%--------------------------------------------------------------------------
%       Funçao que apresenta a soluçao optima e o valor de Z optimo
%--------------------------------------------------------------------------
% Parâmetros de entrada:
%--------------------------------------------------------------------------
% n = nº de variaveis
% m = nº de restriçoes
% z = valor da FO
% SBA = vetor que contem os valores da SBA actual
% flag =0 => método Simplex; flag =1 => método dual do simplex
%--------------------------------------------------------------------------
% Parâmetros de saída:
%--------------------------------------------------------------------------
% - 
%--------------------------------------------------------------------------
function Apresenta_resultados_finais(n,m,SBA,z,flag)
if ~flag
    fprintf('\n=> Quadro otimo pois nao existem valores negativos na linha zj-cj\n')
else
    fprintf('\n=> Quadro otimo pois nao existem valores negativos na coluna b\n')
end
fprintf('\nSoluçao otima:\n')
fprintf('-------------------------------\n')
for j=1:n+m
    fprintf('\tx%d* = %.2f\n',j,SBA(j))
end
fprintf('\nValor otimo de z:\n');
fprintf('-------------------------------\n')
fprintf('\tZ*=%.2f\n',z)
end