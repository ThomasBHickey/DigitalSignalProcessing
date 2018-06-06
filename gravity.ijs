NB.  First a low pass filter kernel (Figure 7-4
load '~user/projects/Jgwf/init.ijs'
+/]lowPassK =. (20#0), ((|.i.21)^4) % (20^4)%0.22141
plotOpts plot lowPassK
delta =. (20#0),1,20#0
highPassK =: delta - lowPassK
pd lowPassK
pd 'show'
pd delta
pd 'show'
   pd _100}.100}. highPassK conv r8mid1sec
   r8mid1sec =. 4096{.(((#r8)%2)-2048)}.r8
mid10sec =. (10*4096){. ((-:#r8)-5*4096){. r8
Note 'Different filters'
Showing the results of filters on a second of gwf data
)
pd 'reset'
pd 'new 0 510 750 750'
pd 'title lowPassK conv r8'
pd 30}. _30}.lowPassK conv r8mid1sec
pd 'new 0 260 750 500'
pd 'title highPassK conv r8'
pd 30}. _30}.highPassK conv r8mid1sec
pd 'new 0 10 750 250'
pd 'title lowPassK conv w.  highPassK r8'
pd 60}. _60}.lowPassK conv highPassK conv r8mid1sec
pd 'show'

plot 1 o. i.100 * o.1
NB. plot 60hz sine wave sampled at 4096/sec
   plot 1 o. ((60* o.2)%4096) * i.4096
NB. calculate power under convolution
pwr =. 4 : '+/ *: x conv 1 o. ((y * o.2)%4096)*i.4096'
lowPassK pwr 60
NB. Plot the mid 10 seconds of the signal
plot (_5 + (i.10*4096)%4096); mid10sec
