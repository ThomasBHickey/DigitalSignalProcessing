NB.  First a low pass filter kernel (Figure 7-4
+/]lowPassK =. (20#0), ((|.i.21)^4) % (20^4)%0.22141
plotOpts plot lowPassK
delta =. (20#0),1,20#0
plotOpts plot highPassK =: delta - lowPassK
pd lowPassK
pd 'show'
pd delta
pd 'show'