# Arithmetic_Encoding_-_Decoding_Using_MATLAB
INTRODUCTION
Arithmetic coding is a form of entropy encoding used in lossless data compression. Normally, a string of characters such as the words "hello there" is represented using a fixed number of bits per character.

EQUAL PROBABILITIES
In the simplest case, the probability of each symbol occurring is equal. For example, consider a set of three symbols, A, B, and C, each equally likely to occur. Simple block encoding would require 2 bits per symbol, which is wasteful: one of the bit variations is never used. That is to say, A=00, B=01, and C=10, but 11 is unused. 
A more efficient solution is to represent a sequence of these three symbols as a rational number in base 3 where each digit represents a symbol. For example, the sequence "ABBCAB" could become 0.011201.In arithmetic coding as a value in the interval [0, 1). The next step is to encode this ternary number using a fixed-point binary number of sufficient precision to recover it, such as 0.00101100102 — this is only 10 bits; 2 bits are saved in comparison with naïve block encoding. This is feasible for long sequences because there are efficient, in-place algorithms for converting the base of arbitrarily precise numbers.

DEFINING A MODEL
In general, arithmetic coders can produce near-optimal output for any given set of symbols and probabilities (the optimal value is −log2P bits for each symbol of probability P, see source coding theorem). Compression algorithms that use arithmetic coding start by determining a model of the data – basically a prediction of what patterns will be found in the symbols of the message. The more accurate this prediction is, the closer to optimal the output will be. 

ENCODING & DECODINIG
In general, each step of the encoding process, except for the very last, is the same; the encoder has basically just three pieces of data to consider: 
The next symbol that needs to be encoded
The current interval (at the very start of the encoding process, the interval is set to [0,1], but that will change)
The probabilities the model assigns to each of the various symbols that are possible at this stage (as mentioned earlier, higher-order or adaptive models mean that these probabilities are not necessarily the same in each step.)
The encoder divides the current interval into sub-intervals, each representing a fraction of the current interval proportional to the probability of that symbol in the current context. Whichever interval corresponds to the actual symbol that is next to be encoded becomes the interval used in the next step.
When all symbols have been encoded, the resulting interval unambiguously identifies the sequence of symbols that produced it. Anyone who has the same final interval and model that is being used can reconstruct the symbol sequence that must have entered the encoder to result in that final interval. 
It is not necessary to transmit the final interval, however; it is only necessary to transmit one fraction that lies within that interval. In particular, it is only necessary to transmit enough digits (in whatever base) of the fraction so that all fractions that begin with those digits fall into the final interval; this will guarantee that the resulting code is a prefix code. 

