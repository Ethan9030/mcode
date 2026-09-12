x = [1 1 1 1 1];
h = [1 1 1 1 1];

function y = myConv(x, h)

Nx = length(x);
Nh = length(h);

Ny = Nx + Nh - 1;

y = zeros(1, Ny);

for n = 1:Ny

    for k = 1:Nx

        j = n - k + 1;

        if j >= 1 && j <= Nh
            y(n) = y(n) + x(k) * h(j);
        end

    end

end

end

y_my = myConv(x, h);

y_matlab = conv(x, h);

disp('Result from my convolution function:');
disp(y_my);

disp('Result from MATLAB conv function:');
disp(y_matlab);

figure;

subplot(2,2,1);
plot(x, '-o', 'LineWidth', 1.5);
grid on;
title('Input Signal x[n]');
xlabel('n');
ylabel('Amplitude');

subplot(2,2,2);
plot(h, '-o', 'LineWidth', 1.5);
grid on;
title('Input Signal h[n]');
xlabel('n');
ylabel('Amplitude');

subplot(2,2,3);
plot(y_my, '-o', 'LineWidth', 1.5);
grid on;
title('My Convolution Result');
xlabel('n');
ylabel('Amplitude');

subplot(2,2,4);
plot(y_matlab, '-o', 'LineWidth', 1.5);
grid on;
title('MATLAB conv Result');
xlabel('n');
ylabel('Amplitude');

figure;

plot(y_my, '-o', 'LineWidth', 2);
hold on;
plot(y_matlab, '--x', 'LineWidth', 1.5);

grid on;
xlabel('n');
ylabel('Amplitude');
title('Comparison of My Convolution and MATLAB conv');
legend('My Convolution', 'MATLAB conv');