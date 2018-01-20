from deModel import DeFixedInt
from deModel import arrayFixedInt
import numpy as np

a=DeFixedInt(8,10,-3.3)

npFloat=np.ones((32,32))
#npFixedPoint=arrayFixedInt(8,2,npFloat)
#npFixedPoint[0][1]=npFloat[2]
print(npFloat)
#print(npFixedPoint)
print(a)
