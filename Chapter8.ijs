Note 'Chapter 8'
The Discrete Fourier Transform
)
require '~user/projects/DigitalSignalProcessing/init.ijs'

Note 'Table 8-1'
The Inverse Discrete Fourier Transform
Naive translation from Basic
)


NB. NIDFT =: 3 : 0  NB. y contains the real and imaginary frequency domain
NB.   'rex imx' =. y
NB.   assert (#rex) = #imx
NIDFT =: 3 : 0  NB. pass in the complex frequency domain values
 'rex imx' =. |:+.y
  n =. +:<:#rex  NB. a 257 rex results in 512 points in the time domain signal
  rex =. rex % -:n  NB. Formula 8-3 for values in frequency domain
  imx =. imx % -:n
  rex =. (-:0{rex) 0 } rex  NB. Two special cases
  rex =. (-:_1{rex) _1} rex

  xx =. n#0  NB. accumulator
  NB. Eq. 8-2 loop thru each frequency
  for_k. i.#rex do.
	for_i. i.#xx do.
	  xx =. ((i{xx)+(k{rex)*cos 2p1*k*i%n) i } xx
        xx =. ((i{xx)+(k{imx)*sin 2p1*k*i%n) i } xx
	end.
  end.
  xx
)

rex =. 17# 32
NB. imx =. 17#0
NIDFT rex  NB. matches Figure 8-6 (32 0 0 0 ...


ftbasis=: %: %~ 0j2p1&% ^@* */~@i. NB. http://code.jsoftware.com/wiki/Guides/Fourier_Transform
ft=: +/ .* ftbasis@#
ift=: +/ .* +@ftbasis@#
assert rex -: 0{"1 +. ft ift rex

NB. '(ift rex)% %:#rex' matches NIDFT
assert 1e_10> +/| ((ift rex)% %:#rex) - (#rex) {. NIDFT rex
NB. ifftw matches first #rex elements returned by NIDFT rex
assert 1e_10> +/| (ifftw rex) - (#rex) {. NIDFT rex

Note 'Table 8-2'
The Discrete Fourier Transform
)
NDFT =: 3 : 0 
  n =. #y
  rex =. (>:-:n)#0
  imx =. rex
  for_k. i.#rex do.
	for_i. i.n do.
	  rex =. ((k{rex) + (i{y)*cos 2p1*k*i%n) k} rex
	  imx =. ((k{imx) - (i{y)*sin 2p1*k*i%n) k} imx
	end.
  end.
  rex j. imx
)

assert rex -: 0{"1 +. NDFT NIDFT rex  NB. Just to real part

Note 'Speed of inverse df transform'
On an array of ? 1000#0:
NIDFT: 6 seconds
ift: 0.4 seconds
ifftw: 0.0003 seconds
)

Note 'Polar Notation'
*. transforms complex r/i into polar,

)

polar =: 4 : '*. x j. y'
tpolar =: [: *. j.  NB. tacit version
assert (*. 3j4) = 3 polar 4  NB. 5 0.927295
'mag ang' =. *.3j4
assert 3j4 = mag r. ang


NB. Figure 8-10 d.
phase =. (1p1-2p1|1p1+(4p1%25) * i.51)
pd 'reset'
pd 'title d.PhaseX[ ]'
pd 'xcaption Frequency'
pd 'ycaption Phase (radians)'
pd plotOpts
pd ((i.51)%100); phase
pd 'show'

NB. Figure 8-10 c.
a =. cos +/\10#1%10
b =. 1-|.a
mag =. (11#1), a, b, (51-(#a)+(#b)+11)#0
pd 'reset'
pd 'title c. Mag X[ ]'
pd 'xcaption Frequency'
pd 'ycaption Amplitude'
pd plotOpts
pd ((i.51)%100); mag
pd 'show'

NB. Figure 8-10 a.
pol =. mag r. phase
pd 'reset'
pd 'title a. Re X[ ]'
pd 'xcaption Frequency'
pd 'ycaption Amplitude'
pd plotOpts
pd 0{"1 +.pol
pd 'show'

NB. Figure 8-10 b.
pd 'reset'
pd 'title b. Im X[ ]'
pd 'xcaption Frequency'
pd 'ycaption Amplitude'
pd plotOpts
pd 1{"1 +.pol
pd 'show'





