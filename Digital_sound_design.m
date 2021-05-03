[sound_array, fs] = audioread('EhrEhr.m4a'); 
a = sound_array(fs*0.7:fs*0.85)*25;
sound_array=[a*0;a;a*0;a;a*0;a;a*0;a;a*0;a;a*0]+ 0.0000001;
soundsc(sound_array,fs);
time= [1:length(sound_array)]/fs;

figure (1); clf;
plot (time, sound_array); 
xlim ([time(1) time(end) ]);
xlabel ('Time (sec)'); 
ylabel ('x(t)'); 
grid minor; 
box on;

%CPSD 
nfft = fs/10; 
window = hann(fs/40);
noverlap= round(length(window)*0.9); 
[Px1, f]= cpsd (sound_array, sound_array, window, noverlap, nfft, fs);

%PSD plot 
figure (2); clf; 
plot (f, 10*(Px1)); 
xlim ([0 10000]); 
ylim([-100 -40]); 
xlabel('Frequency(Hz)'); 
ylabel ('PSD(dB)'); 
grid minor;
box on;

% Spectrogram 
[S, F, T, P]=spectrogram(sound_array, window, noverlap, nfft, fs);
figure (3); clf;
surf(T, F, 20*log10(abs(S)), 'edgecolor', 'none');
view(0, 90);
xlabel ('Time (sec)');
ylabel ('Frequency (Hz)');
xlim ([T(1) T(end)]) 
ylim ([0 10000]) 
colormap(jet);  
caxis ([-50 50]);
box on;