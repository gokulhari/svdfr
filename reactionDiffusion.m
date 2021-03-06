%   Example 1: of the reaction-diffusion equation with Neumann boundary
%   conditions
%   Written by Gokul Hariharan, harih020@umn.edu

clear; 
close all;
eps = 0.0001;
omega = 0.0;

A = chebop([-1,1]);      % Operator A
B = chebop([-1,1]);      % Operator B
C = chebop([-1,1]);      % Operator C

A.op = @(x,phi)( (1i*omega + eps^2)*phi - diff(phi,2) );
B.op = @(x,d) d;
C.op = @(x,phi) phi;

A.lbc = @(u) diff(u);
A.rbc = @(u) diff(u);

[V,lam] = svdfr(A,B,C,20);

anal_sol1 = (1./(eps^2 + [0:11].^2*pi^2));
anal_sol2 = (1./(eps^2 + ([0:11]+ 0.5).^2*pi^2));
count = 1;
for i = 1:10
    anal_sol(count) = anal_sol1(i);
    anal_sol(count+1) = anal_sol2(i);
    count = count + 2;
end
lam = diag(lam);
len = length(anal_sol);
plot([1:len-1],flipud(lam(2:len)),'sk',[1:len-1],anal_sol(2:end),'xk');
%set(0,'DefaultTextInterpreter', 'latex')
%set(0,'DefaultTextFontname', 'CMU Serif')
xlabel('$n$');
ylabel('$\sigma_n$');
hh = legend('SVDFR','Analytical');
print('-painters','-dsvg','docs/pics/rnd');