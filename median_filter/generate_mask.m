function y = generate_mask(A, B, p, beta)
% p = 1 or 2(mainly)
%

y = zeros(size(A));
if(beta==0)    
    y = (A.^p) ./ (A.^p + B.^p) ;
else
    y = (A./(B+eps))>beta;
end

end