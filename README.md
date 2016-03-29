# arduino-clock-stability-test

This is a small project created to investigate the clock drift of an arduino uno
compatible board. The 1PPS output of a cheap GPS module is used to trigger an
ISR. Theoretically, the ISR should trigger every 1000000µs and the difference
between the ideal and real value is reported via the serial port.

The data acquired during easter 2016 is also supplied, along with an octave
script to analyze the data. Unfortunately, there are some outliers in the data.
The most likely root cause is the bad GPS reception (indoors) and the
less-than-ideal voltage levels. My GPS module, according to spec, outputs 2.8V
when high which is just above the threshold for an ATmega328P powered at 5V.

To reduce the outliers, the analysis script applies a median filter with a
rather large window size. The data reveals a clock drift in the range of almost
100ppm during one day and one can clearly identify when the sun starts shining
through the window.

