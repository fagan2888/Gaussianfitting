# -*- coding: utf-8 -*-
"""
Created on Sun Nov 24 23:10:14 2013

@author: andy
"""

from PIL import Image
import scipy as sp
import numpy as np
import matplotlib as mpl
from pylab import *

im = array(Image.open('test.bmp').convert('L'))
im_T = transpose(im)
y = np.where(im==255)[0]
x = np.where(im_T==255)[0]

y_avg = sum(y)/len(y)
x_avg = sum(x)/len(x)

R_s = (x-x_avg)**2+(y-y_avg)**2


y2 = np.where(im!=255)[0]
x2 = np.where(im_T!=255)[0]  

L = array([y2-y_avg,x2-x_avg])

sigma = np.dot(L,L.T)/(len(x2)-1)


index = np.argmax(R_s);
X_l = array([x[index],y[index]])
u =array([x_avg,y_avg])
P =matrix(X_l-u)

A = 255*2*pi*det(sigma)**0.5*e**float(0.5*P*matrix(sigma).I*P.T )






def Gassian_2D(x,y,u,sigma,A):
    k=matrix([x,y])
    P=matrix(k-u)
    G=A/((2*pi)*det(sigma)**0.5)*e**(-0.5*P*matrix(sigma).I*P.T);
    return G



