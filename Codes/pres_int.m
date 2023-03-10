function F = pres_int(f, pres_full)

  pres_full = (pres_full(:)); 
  
% f = lonxlatxpres

%   if size(f, 1) ~= length(pres_full)
%     error('Length of pres_full must be equal to number of rows of f.')
%   end
  
    %trapezoidal integral from surface to Plev
  F = trapz(pres_full,f,3);
  
  
%   % define pres on half levels
%   num_lev    = length(pres_full);
%   pres_half = zeros(num_lev+1, 1);
%   
%   pres_half(num_lev+1) = 1;  % lowest half level is ground
%   for j = num_lev : -1 : 1
%     pres_half(j) = 2*pres_full(j) - pres_half(j+1);
%   end
% 
%   d_pres  = diff(pres_half);
%   d_pres2 = repmat(d_pres, [1 size(f, 2) size(f,3)]);
%   
%   if top
%     F      = squeeze(sum(f .* d_pres2));
%   else
%    for i = 1:size(f,3)
%     for j = 1:size(f,2)
%      F(:,j,i) = flipud(cumsum(flipud(f(:,j,i) .* d_pres)));
%     end
%    end
%   end
%   pres_half = pres_half(1:num_lev);
