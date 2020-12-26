<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Similarity, Neighbors, Clusters

## approaches

### To find similar items

With a new sample, calculate the distance from other points, find the most similar items from the full population. 

### For predictive modelling

scan population for nearest neighbors, select N, combine these with an average, max etc. Use a combining function. For classification, could be a vote between classes, with a probability estimation. For regression, can take average, or weighted average.  

## Distance functions

- **Euclidean** is just the root of the differences of the squares. When 3 values, square of the difference between each pair. L2 norm.

- **Manhattan distance** is L1 norm, just the sum of the linear differences. Taxicab distance in a grid.

- **Jaccard distance** treats as features as sets, calculate the intersection of features vs the union of features. Good when many features, e.g. lots of categories. Possession of a common characteristic is important, absence of a characteristic is not important.  

- **Distance weighted, similarity weighted voting**: weight based on e.g. 1/r^2, multiply by the value, divide by sum of the weights. THis means can use e.g. all data points, and scale.  

- **Cosine distance** is used in text classification to find similarity of 2 docs. Get a vector count of features, e.g. word count in document dictionary. Matrix product over magnitude of vectors. Gives zero distance when one vector a multiple of the other.

- **edit distance** number of edits to transpose one string into another.

## Combining functions

- majority vote classification
- majority scoring function
- similarity weighted classification
- for regression, multiply by weights, divide by sum of wights.

## How many neighbors?

Use odd for majority. Knn. When k = full data set, you get the average of the dataset. k is complexity parameter, so usual overfitting issues.

## issues with Knn

1. knn is not very intelligible in terms of model, and ay not be easy to justify why being like another point means the same outcome.

2. Knn is the distance function, the combining unction and the dataset.

3. Fast for training (no training) but slow for prediction.

4. Where using distance function, features need to be normalized. Categories need to be hot one encoded.

## Clustering

### Heirarchical clustering

use distance function, start with one cluster, then remove one point and find the new cluster for n-1 points. Get a dendogram showing the distance between clusters, and which points are in each cluster. Good for e.g. gene clusters.

### Clustering around centriods

k-means clustering starts with desired number, and choose starting points. Each data item assigned to nearest point, then average of points for each cluster taken to get the new centroid for the cluster. Then repeat, gradually stabilising.

### Interpretation

can be tricky: being in a group says something, but the list is maybe the answer to domain experts. Or explain with the item nearest the centre.
