Note 'Chapter 8'
The Discrete Fourier Transform
)
Note 'Table 8-1'
The Inverse Discrete Fourier Transform
Naive translation from Basic
)
require 'trig'
require 'math/fftw'

NIDFT =: 3 : 0  NB. y contains the real and imaginary frequency domain
  'rex imx' =. y
  assert (#rex) = #imx
  n =. +:<:#rex  NB. a 257 rex results in 512 points in the time domain signal
  rex =. rex % -:n  NB. Formula 8-3 for values in frequency domain
  imx =. imx % -:n
  rex =. (-:0{rex) 0 } rex  NB. Two special cases
  rex =. (-:_1{rex) _1} rex

  xx =. 512#0  NB. accumulator
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
imx =. 17#0
NIDFT rex;imx


basis=: %: %~ 0j2p1&% ^@* */~@i.  NB. http://code.jsoftware.com/wiki/Guides/Fourier_Transform
ft=: +/ .* basis@#
ift=: +/ .* +@basis@#
