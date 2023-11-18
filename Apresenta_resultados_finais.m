%--------------------------------------------------------------------------
%       Fun�ao que apresenta a solu�ao optima e o valor de Z optimo
%--------------------------------------------------------------------------
% Par�metros de entrada:
%--------------------------------------------------------------------------
% n = n� de variaveis
% m = n� de restri�oes
% z = valor da FO
% SBA = vetor que contem os valores da SBA actual
% flag =0 => m�todo Simplex; flag =1 => m�todo dual do simplex
%--------------------------------------------------------------------------
% Par�metros de sa�da:
%--------------------------------------------------------------------------
% - 
%--------------------------------------------------------------------------
function Apresenta_resultados_finais(n,m,SBA,z,flag)
if ~flag
    fprintf('\n=> Quadro otimo pois nao existem valores negativos na linha zj-cj\n')
else
    fprintf('\n=> Quadro otimo pois nao existem valores negativos na coluna b\n')
end
fprintf('\nSolu�ao otima:\n')
fprintf('-------------------------------\n')
for j=1:n+m
    fprintf('\tx%d* = %.2f\n',j,SBA(j))
end
fprintf('\nValor otimo de z:\n');
fprintf('-------------------------------\n')
fprintf('\tZ*=%.2f\n',z)
end