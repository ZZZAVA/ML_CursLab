import numpy as np
import pandas as pd
import sns
from matplotlib import pyplot as plt
from plotly import plot
from sklearn.decomposition import PCA
from sklearn.manifold import TSNE
from sklearn.metrics import accuracy_score

pd.set_option('display.max_columns', None)

import plotly.offline as py

py.init_notebook_mode(connected=True)

from sklearn.model_selection import train_test_split

from xgboost import XGBClassifier

import pandas as pd
from sklearn.preprocessing import MinMaxScaler

import warnings
warnings.filterwarnings('ignore')

df = pd.read_csv('parkinsons.data')
df.tail()

df.describe()

df.info()

df.shape


features = df.loc[:, df.columns != 'status'].values[:, 1:] # values use for array format

labels = df.loc[:, 'status'].values

df['status'].value_counts()

scaler = MinMaxScaler((-1, 1))

X = scaler.fit_transform(features)
y = labels


x_train, x_test, y_train, y_test=train_test_split(X, y, test_size=0.3)

print(X,y)
print(x_train, y_train)

model = XGBClassifier()
model.fit(x_train, y_train) # fit with x and y train



y_prediction = model.predict(x_test)

print('\n\n\n' , y_prediction)

print('\n\n\n' , y_test)

print("Error : ", 1 - accuracy_score(y_test, y_prediction))

from sklearn.manifold import TSNE
import pandas as pd
import seaborn as sns
n_components = 2
tsne = TSNE(n_components)
tsne_result = tsne.fit_transform(X)
tsne_result.shape

tsne_result_df = pd.DataFrame({'tsne_1': tsne_result[:,0], 'tsne_2': tsne_result[:,1], 'label': y})
fig, ax = plt.subplots(1)
sns.scatterplot(x='tsne_1', y='tsne_2', hue='label', data=tsne_result_df, ax=ax,s=120)
lim = (tsne_result.min()-5, tsne_result.max()+5)
ax.set_xlim(lim)
ax.set_ylim(lim)
ax.set_aspect('equal')
ax.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.0)



tsne_text = TSNE(n_components=2, perplexity=30)
reduced_tsne_text = tsne_text.fit_transform(X)

plt.figure(figsize=(10, 6))
plt.scatter(reduced_tsne_text[:, 0], reduced_tsne_text[:, 1], alpha=0.5)
plt.title('t-SNE Visualization of Text Data')
plt.xlabel('t-SNE Component 1')
plt.ylabel('t-SNE Component 2')
plt.show()
