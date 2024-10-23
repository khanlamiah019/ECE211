% Part III
function SHS = shsMAtrix(M, LaOA, d_lambda)
% parameters 
AOArad = deg2rad(LaOA);
L = length(LaOA);
S = zeros(M, L);
% steering vectors for each angle 
% https://www.mathworks.com/help/phased/ref/steervec.html
for i = 1:L
  S(:, i) =exp(1j*pi*d_lambda*(0:M-1)'*sin(AOArad(i)));
end
SH = conj(S');
SHS = SH*S;
disp(abs(SHS));
end

