function [n,m,A,c,b,x,xB,cB,SBA,zjcj,z]=MDSimplex(n,m,A,c,b,x,xB,cB,SBA,zjcj)
%--------------------------------------------------------------------------
%                  Implementacao do Metodo  Dual do Simplex
%--------------------------------------------------------------------------
% Variaveis principais:
%--------------------------------------------------------------------------
% n = no de variaveis originais
% m = no de restricoes funcionais
% A = matriz dos coeficientes das variveis nas restricoes
% b = vetor dos termos independentes das restricoes
% c = vetor dos coeficientes das variaveis na FO
% x = vector com os indices de todas as variaveis
% xB = vector com os indices das variaveis basicas
% cB = vector com os coeficientes das variaveis basicas na FO 
% Zjcj = vector com os valores da linha Zj-cj
% z = valor da FO
% SBA = vector com os valores da SBA em cada iteracao
%--------------------------------------------------------------------------
% Limpa novamente janela de comandos
clc
termina=0;              % Controla a execucao do ciclo
iteracao=1;             % Contabiliza o n. de iteracoes
while ~termina
   % Calcula valores da linha zj-cj e o valor de z
   for j=1:n+m
       zjcj(j)=cB'*A(:,j)-c(j); 
   end
   z=cB'*b;
   % Testa se solução é otima
   [valor_min,linha_pivot]=min(b); 
  
   if valor_min>=0
       % Quadro otimo
       Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,zjcj,z,iteracao,0,0,0)
       termina=1;
   else
      % Inicializa vetor de quocientes com +oo
      q=realmax*ones(1,n+m);
      for j=1:n+m
          if A(linha_pivot,j)<0
              q(j)=zjcj(j)/abs(A(linha_pivot,j));
          end
      end
      [valor_min,coluna_pivot]=min(q);
      % Variável que vai entrar na base - x(coluna_pivot)
      % Variável que vai sair da base - xB(linha_pivot)
      % Apresenta quadro Simplex
      Apresenta_quadro_Simplex(n,m,c,xB,cB,A,b,zjcj,z,iteracao,1,x(coluna_pivot),xB(linha_pivot))
      pause % Espera que utilizador pressione uma tecla para continuar...
   
      % Atualiza base
      xB(linha_pivot)=x(coluna_pivot);
      cB(linha_pivot)=c(coluna_pivot);
   
      % Transforma elemento pivot em 1
      aux=1/A(linha_pivot,coluna_pivot); % Inverso do elemento pivot
      A(linha_pivot,:)=aux*A(linha_pivot,:);
      b(linha_pivot)=aux*b(linha_pivot);
      % Transforma restantes elementos da coluna pivot em zero
      % (i)' = (i) - K * (linha pivot)' (K = valor a eliminar)
      for i=1:m
         if i~=linha_pivot
             K=A(i,coluna_pivot);
             A(i,:)=A(i,:) - K*A(linha_pivot,:);
             b(i)=b(i) - K*b(linha_pivot);
         end
      end
      % Atualiza SBA
      for j=1:n+m
         % Verifica se indice j pertence à base (ao vetor xB)
         posicao=find(xB==j); 
         if isempty(posicao) % j não pertence a xB
             SBA(j)=0;
         else                % j pertence à base e está na linha "posicao"
             SBA(j)=b(posicao);
         end
      end   
   end  
   iteracao=iteracao+1;      
end
z=-z;
end
