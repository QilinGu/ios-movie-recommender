#!/usr/bin/env python

import sys
import itertools
from math import sqrt
from operator import add
from os.path import join, isfile, dirname
from pyspark import SparkConf, SparkContext
from pyspark.mllib.recommendation import ALS
import pickle

def parseRating(line):
    fields = line.strip().split("::")
    return long(fields[3]) % 10, (int(fields[0]), int(fields[1]), float(fields[2]))

if __name__ == "__main__":
    conf = SparkConf().setAppName("MovieLensALS").set("spark.executor.memory", "5g")
    sc = SparkContext(conf=conf)
    
    ratings = sc.textFile('ratings.dat').map(parseRating)

    numRatings = ratings.count()
    numUsers = ratings.values().map(lambda r: r[0]).distinct().count()
    numMovies = ratings.values().map(lambda r: r[1]).distinct().count()
    print "Got %d ratings from %d users on %d movies." % (numRatings, numUsers, numMovies)

    rank = 12
    lmbda = 0.1
    numIter = 20

    print('starting to build model')
    ratings = ratings.values().cache()
    model = ALS.train(ratings, rank, numIter, lmbda)

    print('recommending for users')
    recs = model.recommendProductsForUsers(10)

    print('collecting items')
    recs = recs.collect()

    print('starting dump')
    pickle.dump(recs, open( "outfile.p", "wb" ))
        
    sc.stop()
    
    print('done')
