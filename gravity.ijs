NB.  First a low pass filter kernel (Figure 7-4
+/]lowPassK =. (20#0), ((|.i.21)^4) % (20^4)%0.22141
plotOpts plot lowPassK
delta =. (20#0),1,20#0
plotOpts plot highPassK =: delta - lowPassK
pd lowPassK
pd 'show'
pd delta
pd 'show'
   pd _100}.100}. highPassK conv r8mid1sec
   r8mid1sec =. 4096{.(((#r8)%2)-2048)}.r8

plot highPassK conv r8mid1sec

plot 1 o. i.100 * o.1
NB. plot 60hz sine wave sampled at 4096/sec
   plot 1 o. ((60* o.2)%4096) * i.4096
NB. calculate power under convolution
pwr =. 4 : '+/ *: x conv 1 o. ((y * o.2)%4096)*i.4096'
lowPassK pwr 60
