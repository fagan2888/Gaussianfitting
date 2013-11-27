# -*- coding: utf-8 -*-
"""
Created on Wed Nov 27 05:38:17 2013

@author: Dawnknight
"""

from PIL import Image
import scipy as sp
import numpy as np
import matplotlib as mpl
#from pylab import *
import math

im = np.array(Image.open('test.bmp').convert('L')).astype(float)
y,x = np.where(im==255)

y_avg = sum(y)/len(y)
x_avg = sum(x)/len(x)


y2,x2 = np.where(im!=255)

L = np.array([y2-y_avg,x2-x_avg])

r_s = (L*L).sum(axis=0)

A = np.array([r_s,np.ones(len(r_s))]).T


D_L = np.ones(len(x2))  #initail D_L
for i in range(0,len(x2)):
    D_L[i]=math.log(im[y2[i],x2[i]])

m,c = np.linalg.lstsq(A,D_L)[0]    

#ata = np.dot(A.T,A)
#m,c = np.dot(np.dot(np.linalg.inv(ata),A.T),D_L)

#m = -1/(2*sigma)
sigma = -m*2
# c = log(amplitude)-0.5*log(2pi)-log(sigma)
amp = math.e**(c+math.log(sigma)+0.5*math.log(2*np.pi))



