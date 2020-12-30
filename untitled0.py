## clustering part 2: hierarchical clustering 

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


## dataset 
dataset_mall = pd.read_csv("Mall_Customers.csv")
dataset_mall.describe()
dataset_mall.info()

## subset the X variables 
X1 = dataset_mall.iloc[:, [3,4]]
X = dataset_mall.iloc[:, [3,4]].values

print(str(type(X1)) + "\n" + str(type(X))) ## importance of using .values after iloc to get nparray


## dendrogram 
import scipy.cluster.hierarchy as sch
dendrogram = sch.dendrogram(sch.linkage(X, method= "ward"))
plt.title("dendrogram -- get optimal k")
plt.xlabel("customers")
plt.ylabel("euclidean distance")
plt.show()


## fitting data to the model now with desired (optimal) no. of clusters
from sklearn.cluster import AgglomerativeClustering
hc = AgglomerativeClustering(n_clusters= 5, affinity = "euclidean", linkage= "ward") ## ward minimises variance
y_hc = hc.fit_predict(X) ## output vector of the different clsuters each obs belongs to

hc.affinity

## visualisation of clusters 
# same as kmeans 
## visualising the results 
plt.scatter(X[y_hc == 0, 0], X[y_hc == 0, 1], s = 100, c = "red", label = "cluster 1")
plt.scatter(X[y_hc == 1, 0], X[y_hc == 1, 1], s = 100, c = "blue", label = "cluster 2")
plt.scatter(X[y_hc == 2, 0], X[y_hc == 2, 1], s = 100, c = "yellow", label = "cluster 3")
plt.scatter(X[y_hc == 3, 0], X[y_hc == 3, 1], s = 100, c = "green", label = "cluster 4")
plt.scatter(X[y_hc == 4, 0], X[y_hc == 4, 1], s = 100, c = "purple", label = "cluster 5")

plt.title("clusters of customers")
plt.xlabel("annual income")
plt.ylabel("spending score")
plt.legend()
plt.show()
