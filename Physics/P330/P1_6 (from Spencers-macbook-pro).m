A=[1,2,3;4,5,6;7,8,9];
B=[1,4,5;9,6,3;2,3,1];
v1=[1,1,2];
v2=[0.40824829 ; -0.81649658 ; 0.40824829];

matrix_product = A * B; % Standard matrix multiplication of A by B on the right.
element_wise_product = A .* B; % Each element in A multiplied by corresponding element in B
element_wise_divide = A ./ B; % Each element in A divided by corresponding element in B

 
row_vector = v1 * A;% Output is 3 x 1 vector
col_vector = A * v2; % Again, dimensions don't line upA*v1
Nan_result = A* v1; % No result. Dimensions don't line up

