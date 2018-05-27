Note 'Chapter 6'
 - Convolution -
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
assert (inputSig9 conv impResp9) -: inputSig9 tconv impResp9

Note 'Table 6-2'
Convolution using the Output Side Algorithm
This is the simple translation to J.  'conv' and
'tconv' seem to sidestep the difference.
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