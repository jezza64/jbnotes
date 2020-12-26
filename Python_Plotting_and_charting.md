<LINK href="jb1.css" rel="stylesheet" type="text/css">

#### [Back to index](index.html)

# Plotting and charting

- [Plotting and charting](#plotting-and-charting)
  - [Design](#design)
    - [Edward Turfe: heuristics for the data-ink ratio and chart junk.](#edward-turfe-heuristics-for-the-data-ink-ratio-and-chart-junk)
    - [Alberto Cairo book on The Truthful art](#alberto-cairo-book-on-the-truthful-art)
  - [Matplotlib](#matplotlib)
    - [Notes on Juptyer notebook "basic matplotlib plotting lesson"](#notes-on-juptyer-notebook-basic-matplotlib-plotting-lesson)
    - [Zip](#zip)

## Design

Trade off between

- Abstraction: picture or abstract representation

- Multidimensional: denser information is less clear

- Dimension: multi dimensions with more data

- Familiarity: bar charts familiar, others not.

- Novelty:

Differences between engineers / scientists and artists / jorunalists

Wheel for quanifying the trade off.

### Edward Turfe: heuristics for the data-ink ratio and chart junk. 

Increase data / ink ratio: Remove elements which don't add information
to the graphic.

Chart junk: e.g. patterning, grid. The duck: Non data creative graphics.
But debatable because graphics make this more memorable.

Lie factor: e.g. oil barrel chart

Spark lines: tiny graphs embedded in spreadsheet or text.

### Alberto Cairo book on The Truthful art

- Truthful: don't mislead yourself / audience

- Functional: e.g. direct labelling not grid.

- Beauty

- Insightful

Article on application of these ideas:
<https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1003833>

---

## Matplotlib

**Figure** is the overall window or page containing the drawing. Top level object. Has title, legend, colour bar etc.
Has multiple Axes objects.

**Axes** is the area in which something is plotted, using functions like plot() and scatter(). Has x-axis, y-axis, major and minor ticklines, labels. Axes labels, title, legend.

All methods on Axes exist as a function in the pyplot module. With simple plots use the functions as then dont need to worry about multiple axes, cleaner.  

Pylab is deprecated.

use **%matplotlib inline** in Jupyter for static images.
use **%matplotlib notebook** in Jupyter for interactive images.

### Notes on Juptyer notebook "basic matplotlib plotting lesson"

### Zip

Generally parameters are separate lists of x, y, colours, features in
same size arrays. Use list comprehensions and zip.

Zip takes 2 lists, and creates tuples with e.g. first element from each,
2^nd^ elements etc.

Zip has lazy evaluation, so can store in a zip generator and then turn
into a list.

```Python
# convert the two lists into a list of pairwise tuples  
zip_generator = zip([1,2,3,4,5], [6,7,8,9,10]) 
print(list(zip_generator)) 
# the above prints: 
# [(1, 6), (2, 7), (3, 8), (4, 9), (5, 10)]
zip_generator = zip([1,2,3,4,5], [6,7,8,9,10])
# The single star * unpacks a collection into positional arguments
print(*zip_generator)
# the above prints:
# (1, 6) (2, 7) (3, 8) (4, 9) (5, 10)
```
