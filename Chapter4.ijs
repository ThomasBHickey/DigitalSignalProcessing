Note 'Chapter 2'
Not much code in Chapter 2
)

NB. Table 4-1 Floating point error accumulation
fperror =. 3 : 0
  cum =. 1.0
  a =. ?0
  b =. ?0
  smoutput 'a';a;'b';b
  for_i. i.y do.
    cum =. cum + a
    cum =. cum + b
    cum =. cum - a
    cum =. cum - b
  end.
  cum
)
fperror2 =. 3 : 0
  'a b' =. ? 0 0
  +/ 1, y $ a,b,(-a),(-b)
)
NB. Not able to see any error accumulation
   fperror 1e5  NB. 1
   fperror 1e5  NB. 0.99999999999999989
   fperror 1e7  NB. 0.99999999999999989
   fperror2 1e7  NB. 1

NB. Table 4-2 Comparison of floating and integer variable for loop control
NB. In 64-bit J, it's harder to see this
(9!:11)  20  NB. show more digits
   +/ 1000#0.01  NB. =>9.9999999999998312
NB. Lets try  1,000,000,000 (1e9).  Careful, this takes ~8 Gbytes
   +/ 1e9#1e_8 NB. =>10.000000125228309
(9!:11) 6  NB. back to normal
   +/ 1e9#1e_8  NB. =>10
