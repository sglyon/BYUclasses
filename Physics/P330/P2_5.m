% Spencer Lyon
A=[14,42,91,79,95,65,3,84,93,67,75,74,39,65,17];
disp ('original A');
disp(A);
n = length(A);

for j=1:1:n-1
    for i=1:1:n-1
        if A(i) > A(i+1)
            temp = A(i);
            A(i) = A(i+1);
            A(i+1) = temp;
        end
    end
end

disp ('sorted A');
disp(A);