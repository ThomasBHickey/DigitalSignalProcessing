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
