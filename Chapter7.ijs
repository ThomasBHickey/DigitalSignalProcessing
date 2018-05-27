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
firstDiffImp =: 0 0 1 _1 0 0 0 0 0
NB. Figure 7-2b
runningSumImp =: 0 0 , (79+9)$1

NB. Hand built Figure 7-3b
rcurve =: (|.(+/\^:5) i.30)%9e6
firstDiffVal =: (11$0),(10$0.03),(10$0.07),(10$0),(10$_0.18),rcurve
plotOpts plot firstDiffVal

NB. Computed 7-3a
runningSumVal=: 81{. 2}.   firstDiffVal conv runningSumImp
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
firstDift =: 0 , }. - }:

runningSum =: 3 : 0
  yd =. {. y
  for_i. 1+i.<:#y do.
	yd =. yd, ((<:i){yd) + i{y
  end.
  yd
)	

runningSumt =. +/\i.#


