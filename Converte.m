function [c,A,b]=Converte(c,A,b)
% Converte minimização em maximização
c=-c;
% Converte restrições no tipo "<="
b=-b;
A=-A;
end