require 'plot'

timeit =. 6!:2
spaceit =. 7!:2

samp255 =: ?100000 $ 255
samp10 =: 10*?100000 $ 0
thisto =: <: @ (#/.~) @ (i.@#@[ , I.)

NB. intervals histogram data (vs. histogram=: <: @ (#/.~) @ (i.@#@[ , I. )
histogram =: 4 : '<: #/.~ (i.#x), x I. y'

d=: +/ 10 1e6 ?.@$ 21
e=: 5 * i.40

plotOpts =. 'type dot;pensize 2;symbols square'

