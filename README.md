# QAM Modulation




# Step 1: Data


1. Say we have a stream of data.

2. This data is represented in bits

3. These bits are what we want to transmit.

4. Using a digital encoding, symbols are assigned to bits of data. 


| Bit Chunk      | Symbol Number | 
| ----------- | ----------- |
| 00   | 1    |
| 01   | 2    |
| 10   | 3    |
| 11   | 4    |


Using digital modulation schemes, once we have assigned 'symbols' for each chunk of binary bits, we modulate them onto a carrier. This is where QAM comes in. In QAM, these symbols correspond to points with both real and imaginary parts, and an 'IQ' (In-phase and Quadrature) diagram is used to display the 'constellation' of a QAM format.


| Symbol Number | Amplitude | 
| ----------- | ----------- |
| 00   | 1 + 1j    |
| 01   | 1 - 1j    |
| 10   | -1 + 1j    |
| 11   | -1 - 1j    |

### Constellation Diagram

<p align="center">
<img src="https://github.com/bradleeharr/digital-qam-modulation/assets/56418392/8d4aa6f6-27a4-4a3d-9182-f7d8b17d2591" style="max-width:600px; width: 500px;"/>
</p>

As data is mapped to symbols over time, they form a signal over time:
<p align="center">
  <img src="https://github.com/bradleeharr/digital-qam-modulation/assets/56418392/bb101984-129a-45bf-8571-28ee4a6aaf10">
</p>

This signal has both imaginary (blue) and complex (red) components. This practice of using imaginary numbers is helpful for setting up the signal in theory, but to transmit over a real channel (which has no imaginary component), the signal must be real. Modulation is also performed to convert the signal up to a higher frequency that will propagate better through the environment.

### Upsampling and Modulation 

When the baseband signal is modulated, the real and imaginary parts go into the amplitude and the phase of the signal. For example, in the below image, there are 4 distinct amplitude levels: this is because in the 16-QAM constellation, there is a possibility of 4 different amplitudes. For each amplitude, value, there are 4 possible phase differences. The differences in amplitude is why this is called 'amplitude' modulation, and the fact that we use an imaginary and a real part to the signal to getnerate phase differences for each amplitude is why this is called 'quadrature' amplitude modulation.

|  Bits  |   I   |   Q   | Amplitude (sqrt(I^2 + Q^2)) |
|--------|-------|-------|-----------------------------|
| 0000   | -3    | -3    | sqrt(18) ≈ 4.24             |
| 0001   | -3    | -1    | sqrt(10) ≈ 3.16             |
| 0010   | -3    |  1    | sqrt(10) ≈ 3.16             |
| 0011   | -3    |  3    | sqrt(18) ≈ 4.24             |
| 0100   | -1    | -3    | sqrt(10) ≈ 3.16             |
| 0101   | -1    | -1    | sqrt(2) ≈ 1.41              |
| 0110   | -1    |  1    | sqrt(2) ≈ 1.41              |
| 0111   | -1    |  3    | sqrt(10) ≈ 3.16             |
| 1000   |  1    | -3    | sqrt(10) ≈ 3.16             |
| 1001   |  1    | -1    | sqrt(2) ≈ 1.41              |
| 1010   |  1    |  1    | sqrt(2) ≈ 1.41              |
| 1011   |  1    |  3    | sqrt(10) ≈ 3.16             |
| 1100   |  3    | -3    | sqrt(18) ≈ 4.24             |
| 1101   |  3    | -1    | sqrt(10) ≈ 3.16             |
| 1110   |  3    |  1    | sqrt(10) ≈ 3.16             |
| 1111   |  3    |  3    | sqrt(18) ≈ 4.24             |


<p align="center"> <img src="https://github.com/bradleeharr/digital-qam-modulation/assets/56418392/37fcacc2-d47d-465d-8429-45f40f4518d3" style="max-width:800px; width:800px;> 
</p>

<p align="center">
<img src="https://github.com/bradleeharr/digital-qam-modulation/assets/56418392/fefbfcae-e875-48ae-a63b-3077b4fef8c5" style="max-width:800px; width:800px;"/>
</p>

### Pulse-Shaping 
