Note 'Chapter 2'
 - Statistics, Probability and Noise
)
Note 'Table 2-1'
Calculation of the Mean and Standard Deviation
These resuls differ from m28 http://jsoftware.com/help/phrases/math_stats.htm
because they are the 'sample' SD, not the population SD, and so use n-1 as
the divisor.

Runs about as fast as m28 referenced above
)

msd =: 3 : 0  NB.  y is points in the signal
mean =. (+/y)%#y
variance =. (+/*:(y-mean))%<:#y
mean, %:variance
)

Note 'Table 2-2'
Mean and Standard Deviation using running statistics

msdr1 runs about 80x slower than the above for 100000 = #y
msdr2 runs 30x faster than msdr1
)
msdr1=: 3 : 0 
'n sum sumsquares' =. 0 0 0
for_yi. y do.
  n =. >:n
  sum =. sum+yi
  sumsquares =. sumsquares + *:yi
  mean =. sum%n
NB.   smoutput 'sum';sum;'sumsquares';sumsquares;'mean';mean
  if. n=1 do.
	sd =. 0
  else. sd =. %:((sumsquares-((*:sum)%n))%<:n)
  end.
mean, sd
end.
)

msdr2 =: 3 : 0
sum =. }.+/\y
sumsquares =. +/*:y
n =. #y
mean =. sum%#y
if. 1=n do. sd=.0
  else. sd =. %:((sumsquares-((*:sum)%n))%<:n)
  end.
mean, sd
)

Note 'Table 2-3'
Calculation of the Histogram, Mean, and Standard Deviation

On a 100k sample (range i.256) this took 50x time and 30x space
than the simple msd.  I'm sure the space could be improved, but 
it does work.
)

msdhist =: 3 : 0
h =. +/"1 (i.256)=/y
mean =. (+/h*i.256)%#y
variance =. +/h* *:(i.256)-mean
sd =. %:variance%<:#y
mean, sd
)

samp =: ?100000 $ 255
msdsamp samp





