function best_part = partition(W)

n = size(W,1);

D = diag(sum(W));

[V, v] = eigs(D-W, D, 2, "sm")

p = 0;

if (v(2,2) > v(1,1))
    p = V(:,2);
else
    p = V(:,1);
end

[_, order] = sort(p);

opt_cut = 1000;
opt_index = 0;

part = zeros(1,n);

A_assoc = 0;
B_assoc = sum(sum(W));

cut = 0;

order

for i = 1:n-1
    cur = order(i);
    A_assoc += D(cur, cur);
    B_assoc -= D(cur, cur);
    cut += D(cur, cur) - 2*part*W(:, cur);
    part(cur) = 1;
    Ncut = cut/A_assoc + cut/B_assoc
    if (Ncut < opt_cut)
        opt_cut = Ncut;
        opt_index = i;
    end
end

opt_index
opt_cut
best_part = sort(order(1:opt_index));
