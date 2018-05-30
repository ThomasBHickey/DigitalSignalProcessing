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

Note 'Speeds'
On an array of ? 1000#0:
NIDFT: 6 seconds
ift: 0.4 seconds
ifftw: 0.0003 seconds
)

