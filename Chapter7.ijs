Note 'Chapter 7'
Properties of Convolution
No programs in Chapter 7, but I try to
reproduce some of the examples.
)
Note 'Figure 7-1'
Simple impulse responses using shifed and scaled delta functions
)
Note 'Chapter 7'
Properties of Convolution
)
NB. Figure 7-1a
NB. drop some leading/trailing 0's and compare to the input
trim9 =: (2+i.9) { ]
identity9 =. 0 0 1 0 0 0 0 0 0
assert  inputSig9 -: (2+i.#inputSig9) {inputSig9 conv identity9

NB. Figure 7-1b
pad9 =: 0 0 , 0 0 0 0 0 0 ,~ ]
amp9 =: 0 0 1.6 0 0 0 0 0 0
assert  (pad9 1.6*inputSig9) -: inputSig9 conv amp9

NB. Figure 7-1c
shift9 =: 0 0 0 0 0 0 1 0 0
shift4 =: ] (0 0 0 0 , _4 }. ])
assert (shift4 pad9 inputSig9) -: inputSig9 conv shift9

NB. Figure 7-1d
echo9 =:     0 0 1 0 0 0 0.6 0 0
justEcho9 =: 0 0 0 0 0 0 0.6 0 0
1 1 1 1 1 1 1 1 1 conv echo9  NB. looks good
assert (inputSig9 conv echo9) -: (inputSig9 conv identity9) + inputSig9 conv justEcho9

NB. Figure 7-2a
firstDiffImp =: 0 0 1 _1 , 77$0 
NB. Figure 7-2b
runningSumImp =: 0 0 , 79$1
NB.runningSumImp=: 0 0 1  1 1 1 1 1 1

NB. Hand built Figure 7-3b
rcurve =: (|.(+/\^:5) i.30)%9e6
firstDiffVal =: (11$0),(10$0.03),(10$0.07),(10$0),(10$_0.18),rcurve
plotOpts plot firstDiffVal

NB. Computed 7-3a
runningSumVal=: 81{. 2}.   firstDiffVal conv runningSumImp, 70$1  NB. extend runninSumImp
plotOpts plot runningSumVal
NB. and back to Figure 7-3b
NB. computed runningSumVal back to firstDifVal
plotOpts plot 81{.2}. runningSumVal conv firstDiffImp
NB. See if back and forth gives a round trip
assert runningSumVal -: 81{. 2}. runningSumImp conv 81{. 2}. runningSumVal conv firstDiffImp

NB. Table 7-1
NB. Calculation of the First Difference
NB. y goes from 0 to n-1;  x goes from 0 to n-1
firstDif =: 3 : 0
  yd =. 0
  for_i. 1+i.<:#y do.
	yd =. yd, (i{y)-(<:i){y
  end.
yd
)

plotOpts plot firstDif runningSumVal

firstDif2 =: 3 : '0, (}.y) - }:y'
firstDif2a =: 3 : '0, (}. - }:) y'
assert (firstDif2 runningSumVal) -: firstDif runningSumVal
NB. Here is the tacit version
firstDift =: 0 , }. - }:

runningSum =: 3 : 0
  yd =. {. y
  for_i. 1+i.<:#y do.
	yd =. yd, ((<:i){yd) + i{y
  end.
  yd
)	
NB. The tacit verstion is a bit shorter!
runningSumt =. +/\

Note 'Figure 7-4'
Typical low-pass filter kernels
)
NB. Figure 7-4 a. Exponential
expV =. (20#0), 0.22 % 1.25^i.21
xscale =. _20+i.41
plotOpts plot xscale; expV

NB. Figure 7-4b. Square pulse
sqV =. (20#0), (9#0.1), 12#0
plotOpts plot xscale;sqV 

NB. Figure 7-4c. Sinc
NB. Offset slightly to get '1' at '0' (0 = 0%0 in J)
x =. _20.00001+i.41
sincV=.0.2*(sin x)%x
plotOpts plot xscale;sincV 

NB. Figure 7-5
delta =. (20#0),1,20#0

NB. Figure 7-5a Exponential
plotOpts plot xscale;delta-expV
NB. Figure 7-5b Square pulse
plotOpts plot xscale;delta-sqV
NB. Figure 7-5c Sinc
plotOpts plot xscale;delta-sincV

Note 'Figure 7-8'
Communutative property in system theory
)
a =. firstDiffVal
b =. runningSumImp
yab =. a conv b
yba =. b conv a
assert yab -: yba

Note 'Figure 7-9'
Associative property in system theory
)
xn =. firstDiffVal
h1n =. runningSumImp
h2n =. firstDiffImp
yna =. (#xn){.(xn conv h1n) conv h2n
ynb =. (#xn){.(xn conv h2n) conv h1n
assert 1e_10>+/|yna-ynb  NB. not quite the same, but sum of differences is small
NB. ALSO Convolution using a convolved convolution
h12n =. (#xn){.h1n conv h2n NB. combine the convolutions first
ync  =. (#xn){.xn conv 81{.h12n
assert 1e_14>|+/ync - yna 
(firstDiffVal conv runninSumImp)

Note 'Figure 7-10'
Distributive property in system theory
)
yna =. (xn conv h1n) + xn conv h2n
ynb =. xn conv h1n+h2n
assert 1e_14>+/|yna-ynb  NB. sum of magnitudes of differences is small

Note 'Figute 7-11'
Transference between the input and output
)

xna =. firstDiffVal
hn =. runningSumImp
yna =. (#xna){.xna conv hn
xnb =. 3*xna
ynb =. (#xna){.xnb conv hn
assert 1e_12>+/|ynb-3*yna

Note 'Figure 7-12'
Convolving a pulse with itself
)
xn =. (15#0), (5#1), (5#0), (5#1), 15#0
plotOpts plot xn
plotOpts plot xn conv xn
plotOpts plot xn conv xn conv xn
plotOpts plot (xn conv xn) conv (xn conv xn)
plotOpts plot xn conv xn conv xn conv xn conv xn conv xn conv xn conv xn conv xn

Note 'Figure 7-13'
Correlation
)

plot spike =. (10#0), (100 -20*i.6), 75#0
plot shiftScaleSpike =. _65 |. spike%100
plot noise =. _0.1 + 0.2 * ?(#spike)#0
plot noiseSSSpike =. noise+shiftScaleSpike
plot spikeImp =. 21 {. 9}. spike%100
plot noiseSSSpike conv |. spikeImp