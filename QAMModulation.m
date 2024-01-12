close all;
up = 100; % Upsampling Factor
rolloff = 0.35;
span = 10;
h = rcosdesign(rolloff,span,up);

numSymbols = 128;
M = 16; % modulation order
max_t = 0.01;
f0 = 100e3; % Center Frequency
snr = 0.1; % Signal to Noise Ratio for Noisy Signal

t = linspace(0,max_t,numSymbols);
tup = linspace(0, max_t, up*numSymbols);
dt = mean(diff(tup));
data = randi([0 15], numSymbols, 1);

sym = qammod(data, M, 'UnitAveragePower', true);


% Upsample and trim leading/tailing edges
sym_up = upfirdn(sym, h, up);
dl = length(sym_up) - length(tup);
tup_filt = [tup linspace(max_t, max_t+dt*dl, dl)];
sym_up_trim = sym_up(dl/2:end-dl/2-1);

% Downsample to test
sym_down = upfirdn(sym_up, h, 1, up);
sym_down = sym_down(span+1:end-span);

% Plot Results
figure; 
subplot(2,1,1); plot(tup, real(sym_up_trim)); hold on; plot(t, real(sym)/sqrt(up)); title('Upsampled');
subplot(2,1,2); plot(t, sym); hold on; plot(t, sym_down); title('Downsampled');
 

sym_mod = real(sym_up .* exp(1j*2*pi*f0*tup.'));
sym_noisy = awgn(sym_mod, snr, 'measured');

% Demodulation
fs = 1/mean(diff(tup));
[i, q] = demod(sym_mod, f0, fs, 'qam');
[i_n, q_n] = demod(sym_noisy, f0, fs, 'qam');
sym_demod = i + 1j*q;
sym_demod_n = i_n + 1j * q_n;

fW = linspace(-fs/2, fs/2, length(tup));
figure;
    subplot(2,1,1); plot(fW, mag2db(abs(fftshift(fft(sym_mod))))); title('Modulated Signal FFT');
    subplot(2,1,2); plot(fW, mag2db(abs(fftshift(fft(sym_up))))); title('Lowpass Signal FFT');

% For base signal
figure; 
    subplot(2,2,1); plot(t, data); title('Data'); 
    subplot(2,2,2); plot(tup, real(sym_up)); hold on; plot(tup, imag(sym_up)); title('Lowpass Signal')
    subplot(2,2,3); plot(tup, sym_mod); title('Bandpass Modulated Signal');
    subplot(2,2,4); plot(tup(1:10:end), real(sym_demod)); hold on; plot(tup(1:10:end), imag(sym_demod)); legend('Real','Imag'); title('Demodulated Signal');

% For noisy signal
figure; 
    subplot(2,2,1); plot(t, data); title('Data'); 
    subplot(2,2,2); plot(tup, real(sym_up)); hold on; plot(tup, imag(sym_up)); title('Lowpass Signal')
    subplot(2,2,3); plot(tup, sym_noisy); title('Noisy Bandpass Modulated Signal');
    subplot(2,2,4); plot(tup(1:10:end), real(sym_demod_n)); hold on; plot(tup(1:10:end), imag(sym_demod_n)); legend('Real','Imag'); title('Noisy Demodulated Signal');

sym_demod = decimate(sym_demod, 100);
sym_demod_n = decimate(sym_demod_n, 100);
% Plotting the constellation diagram
scatterplot(sym_demod);
title('16-QAM Constellation Diagram');
xlabel('In-phase Amplitude');
ylabel('Quadrature Amplitude');
scatterplot(sym_demod_n);
title('16-QAM Constellation Diagram with Noise');
xlabel('In-phase Amplitude');
ylabel('Quadrature Amplitude');
scatterplot(sym)
