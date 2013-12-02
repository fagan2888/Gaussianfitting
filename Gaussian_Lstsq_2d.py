# -*- coding: utf-8 -*-
"""
Created on Wed Nov 27 10:51:26 2013

@author: loaner
"""

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
from mpl_toolkits.mplot3d import Axes3D

# according x,y,center, sigma and amplitude find corresponing value
def Gaussian_2d(x,y,xc,yc,sigma,amp):   
    P = np.array([x-xc,y-yc])
    G = amp/(2*np.pi*det(sigma)**0.5)*np.e**(-0.5*np.dot(np.dot(P,np.linalg.inv(sigma)),P.T))
    return G  

#read img
im = np.array(Image.open('test.bmp').convert('L')).astype(float)

#center of saturated part
y,x = np.where(im==255)#.astype(np.float)

x=map(float,x)
y=map(float,y)
y_avg = sum(y)/len(y)
x_avg = sum(x)/len(x)


R_s = (x-x_avg)**2+(y-y_avg)**2


#np.where(R_s>19.0)


y2,x2 = np.where(im!=255)
L = np.array([y2-y_avg,x2-x_avg])



A = np.array([ np.ones(len(x2)),-0.5*(x2-x_avg)**2,-(x2-x_avg)*(y2-y_avg),-0.5*(y2-y_avg)**2 ]).T

#D_L = np.ones(len(x2))  #initail D_L
#for i in range(0,len(x2)):
#    D_L[i]=math.log(im[y2[i],x2[i]])

#np.log faster

D_L = np.log(im[y2,x2]-im.min()+np.spacing(1))
 

# least square
C,a,b,c = np.linalg.lstsq(A,D_L)[0]    



sigma = np.linalg.inv(np.array([[a,b],[b,c]]))
amp = math.e**(C)*2*np.pi*(det(sigma))**0.5


G=np.array([G[:] for G in [[1]*im.shape[1]]*im.shape[0]]) #initial an array G
#plot
for ii in range(0,im.shape[1]):
    for jj in range(0,im.shape[0]):
        G[jj,ii] = Gaussian_2d(ii,jj,x_avg,y_avg,sigma,amp)
    
x = np.arange(0,41,1)   
y = np.arange(0,41,1)
x, y = np.meshgrid(x, y)
fig = mpl.pyplot.figure()
ax = fig.gca(projection='3d')
ax.plot_surface(x,y,G)     


mpl.pyplot.show()

mpl.pyplot.plot(x,y)
mpl.pyplot.show()




