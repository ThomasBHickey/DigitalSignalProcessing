NB.  First a low pass filter kernel (Figure 7-4
load '~user/projects/Jgwf/init.ijs'
require '~user/projects/DigitalSignalProcessing/init.ijs'

hgwf =. fread jpath'~user/projects/Jgwf/samples/H-H1_LOSC_4_V2-1126259446-32.gwf'
frames =. parseGWF hgwf
h1strain =. 'H1:LOSC-STRAIN' findVect frames

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

NB.plot 1 o. i.100 * o.1
NB. plot 60hz sine wave sampled at 4096/sec
   plot 1 o. ((60* o.2)%4096) * i.4096
NB. calculate power under convolution
pwr =. 4 : '+/ *: x conv 1 o. ((y * o.2)%4096)*i.4096'
lowPassK pwr 60
NB. Plot the mid 10 seconds of the signal
plot (_5 + (i.10*4096)%4096); mid10sec
sec1 =. 4096{. ((-:#r8)- -:4096)}.r8
sec16 =. (4096*16){. ((-:#r8)- -:4096*16)}.r8
refftsec1 =. 0{"1 +. fftw sec1
plot refftsec1 
plot 0{"1 +. fftw sec1 conv lowPassK conv highPassK
NB. hamWin is Hamming Window from Chapter 16 Eq. 16-1
plot 1{"1 +. fftw (hamWin 4176)    *sec1 conv lowPassK conv highPassK
NB. by8 =. 256 8 $ 2048 {. 0{"1 +. fftw sec1
NB.  asds =. %:+/"1 *: by8
NB. plot 2}. ]asds =. %:+/"1 *: 256 8 $ 2048 {. 0{"1 +. fftw sec1*hamWin 4096
NB. plot ^.]asds =. %:+/"1 *: 512 64$ (2048*16) {. 0{"1 +. fftw sec16
NB. plot ^.]asds =. %:+/"1 *: 2048 16$ (2048*16) {. 0{"1 +. fftw sec16
plot ^.]asds =. %:+/"1 *: 4096 8$ (2048*16) {. 0{"1 +. fftw sec16
sec1fqr =. 0{"1 +.fftw sec1
whitefq =. sec1fqr % asds
whitetm =. 0{"1 +. ifftw whitefq
plot 820{. (2048-410)}. whitetm conv lowPassK
