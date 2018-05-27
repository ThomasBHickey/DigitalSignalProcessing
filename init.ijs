require 'plot'

timeit =: 6!:2
spaceit =: 7!:2

samp255 =: ?100000 $ 255
samp10 =: 10*?100000 $ 0
thisto =: <: @ (#/.~) @ (i.@#@[ , I.)

NB. intervals histogram data (vs. histogram=: <: @ (#/.~) @ (i.@#@[ , I. )
histogram =: 4 : '<: #/.~ (i.#x), x I. y'

plotOpts =: 'type dot;pensize 2;symbols square'

pts =: 3 : '1 o. ((y*o.2)%4096)*i.4096'
NB. plot one second @ 4096 sampling at given hz
hz =. 90
pts60=. 1 o. ((60* o.2)%4096) * i.4096
pts10=. 1 o. ((22* o.2)%4096) * i.4096
pts1000=. 1 o. ((1000* o.2)%4096) * i.4096

plot (i.4096); pts 60
plot (i.4096); pts 5



