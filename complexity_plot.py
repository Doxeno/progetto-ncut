#!/bin/python3
from enum import auto
import matplotlib.pyplot as plt

x = [1000 * i for i in range(1, 11)]
autovettore = [
    1.9158,
    12.2039,
    29.6770,
    81.1914,
    113.6006,
    204.6602,
    258.9942,
    382.5929,
    463.1287,
    734.7514,
]
greedy = [
    0.0034,
    0.0129,
    0.0296,
    0.0513,
    0.0819,
    0.1241,
    0.1817,
    0.2507,
    0.3266,
    0.4146,
]
random = [
    1.0782,
    4.3516,
    9.7834,
    17.1442,
    26.8064,
    38.4848,
    55.3734,
    73.9880,
    103.0638,
    128.3895,
]
for i in range(10):
    autovettore[i] /= (x[i]*x[i])
    greedy[i] /= (x[i]*x[i])
    random[i] /= (x[i]*x[i])

fig, ax = plt.subplots()
ax.plot(x, autovettore)
ax.plot(x, greedy)
ax.plot(x, random)
ax.legend(["Autovettore", "Greedy", "Random"])
plt.savefig("complexity_plot.pdf")
