load '~user/projects/DigitalSignalProcessing/init.ijs'

Note 'Chapter 2'
 - Statistics, Probability and Noise
)
Note 'Table 2-1'
Calculation of the Mean and Standard Deviation
These resuls differ from m28 http://jsoftware.com/help/phrases/math_stats.htm
because they are the 'sample' SD, not the population SD, and so use n-1 as
the divisor (Bessel's correction).

Runs about as fast as m28 referenced above
)

msd =: 3 : 0  NB.  y is points in the signal
mean =. (+/y)%#y
variance =. (+/*:(y-mean))%<:#y
mean, %:variance
)
smoutput 'msd samp255:'; msd samp255

Note 'Table 2-2'
Mean and Standard Deviation using running statistics

msdr1 runs about 80x slower than msd above for 100000 = #y
msdr2 runs 30x faster than msdr1
)
msdr1=: 3 : 0 
'n sum sumsquares' =. 0 0 0
for_yi. y do.
  n =. >:n
  sum =. sum+yi
  sumsquares =. sumsquares + *:yi
  mean =. sum%n
  if. n=1 do.
	sd =. 0
  else. sd =. %:((sumsquares-((*:sum)%n))%<:n)
  end.
mean, sd
end.
)
smoutput 'msdr1 samp255:'; msdr1 samp255
assert (msdr1 samp255) -: msd samp255

msdr2 =: 3 : 0
sum =. _1}+/\y
sumsquares =. +/*:y
n =. #y
mean =. sum%#y
if. 1=n do. sd=.0
  else. sd =. %:((sumsquares-((*:sum)%n))%<:n)
  end.
mean, sd
)
smoutput 'msdr2 samp255:'; msdr2 samp255
assert (msdr2 samp255) -: msd samp255

Note 'Table 2-3'
Calculation of the Histogram, Mean, and Standard Deviation

On a 100k sample (range i.256) this runs about the speed of msd above
)

msdhist =: 3 : 0
  NB. h =. +/"1 (i.256)=/y
  h =. (i.256) histogram y
  mean =. (+/h*i.256)%#y
  variance =. +/h* *:(i.256)-mean
  sd =. %:variance%<:#y
  mean, sd
)
smoutput 'msdhist samp255:'; msdhist samp255

assert (msdhist samp255) -: msd samp255

Note 'Table 2-4'
Calculation of Binned Histogram
Samples assumed 0.0 to 10.0 to be put into 1000 bins
)

binnedhisto =: 3 : 0
  binStarts =. (i.1000) % 1000
  binStarts histogram y
)

binnedhisto samp10
NB. Triangle distribution Figure 2-10 b
plot (2*(i.100)%100) histogram +/?2 1000000 $0
NB. Close to Gaussian Figure 2-10 c
plot (12*(i.100)%100) histogram +/?12 1000000 $0


Note 'Chapter 6'
 - Convolution -
 No programs in chapters 3-5!
)

Note 'Table 6-1'
Convolution using the Input Side Algorithm
)
NB. A naive translation to J
inputSideConv =: 4 : 0 NB. inputSignal inputSideConv impulseResponse
  outSignal =. (<:(#x) + #y) # 0
  for_i. i.#x do.    NB. inputSignal (x)
    for_j. i.#y do.  NB. impulseResponse  (y)
	outSignal =. ( ((i+j){outSignal) + ((i{x)*j{y) ) (i+j)} outSignal 
    end.
  end.
  outSignal
)

inputSig9 =: 0 _1 _1.2 2 1.3 1.3 0.7 0 _0.7
impResp9  =: 1 _0.5 _0.3 _0.2

inputSig9 inputSideConv impResp9

NB. Simpler convolution implementations 
NB. more than 10x faster on small tests
conv =: 4 : '+/ /. x*/y'
tconv =: [: +//. */  NB. the tacit form

assert (inputSig9 inputSideConv impResp9) -: inputSig9 conv impResp9
assert (inputSig9 convolution impResp9) -: inputSig9 tconv impResp9

Note 'Table 6-2'
Convolution using the Output Side Algorithm
This is the simple translation to J.  'convolution' and
'tconvolution' seem to sidestep the difference.
)
outputSideConv =: 4 : 0
  outSignal =. (<:(#x)+#y) # 0
  for_i. i.#outSignal do.
    for_j. i.#y do. NB. impulseResponse
	if. ((i-j)>:0) *. (i-j)<#x do.
	  outSignal =. ((i{outSignal)+(j{y)*(i-j){x ) i}outSignal
	end.
    end.
  end.
  outSignal
)
assert (inputSig9 outputSideConv impResp9) -: inputSig9 tconv impResp9

Note 'Chapter 7'
Properties of Convolution
No programs in Chapter 7, but I try to
reproduce some of the examples.
assert  inputSig9 -: (2+i.#inputSig9) {inputSig9 conv identity9

NB. Figure 7-1b
amp9 =. 0 0 1.6 0 0 0 0 0 0
assert  (pad9 1.6*inputSig9) -: inputSig9 conv amp9

NB. Figure 7-1c
shift9 =. 0 0 0 0 0 0 1 0 0
assert (shift4 pad9 inputSig9) -: inputSig9 conv shift9

NB. Figure 7-1d
echo9 =.     0 0 1 0 0 0 0.6 0 0
justEcho9 =. 0 0 0 0 0 0 0.6 0 0
1 1 1 1 1 1 1 1 1 conv echo9  NB. looks good
assert (inputSig9 conv echo9) -: (inputSig9 conv identity9) + inputSig9 conv justEcho9

NB. Figure 7-2a
)

Note 'Figure 7-1'
Simple impulse responses using shifed and scaled delta functions
)

NB. Figure 7-1a
identity9 =. 0 0 1 0 0 0 0 0 0
trim9 =. (2+i.9) { ]
shift4 =. ] (0 0 0 0 , _4 }. ])
pad9 =. 0 0 , 0 0 0 0 0 0 ,~ ]
NB. drop some leading/trailing 0's and compare to the input
firstDiff =. 0 0 1 _1 0 0 0 0 0


NB. Figure 7-2b
runningSum =. 0 0 , (79+9)$1

NB. Figure 7-3 b
rcurve =. (|.(+/\^:5) i.30)%9e6
firstDifVal =. (11$0),(10$0.03),(10$0.07),(10$0),(10$_0.18),rcurve
NB. hand built firstDifference to running sum
pd resetPlot
pd firstDifVal
pd [runningSumVal=. 81{. 2}. firstDifVal conv runningSum
pd 'show'
NB. Figure 7-3a
NB. computed runningSumVal back to firstDifVal
pd 81{.2}. runningSumVal conv firstDiff
pd 'show'
pd 81 {. 2}. runningSum conv 81{. 2}. runningSumVal conv firstDiff
pd 'show'
assert runningSumVal -: 81{. 2}. runningSum conv 81{. 2}. runningSumVal conv firstDiff

