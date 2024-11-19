import sys
import math
import numpy as np
from sklearn.datasets import load_digits
from sklearn.datasets import load_breast_cancer
from sklearn.preprocessing import scale
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from sklearn.model_selection import cross_val_score
from sklearn.ensemble import BaggingClassifier
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import RandomForestClassifier


def report_accuracy(predicted, actual):
    correct = 0
    for i in range(len(predicted)):
        if predicted[i] == actual[i]:
            correct += 1
    percentage = round(correct / len(predicted), 2) * 100
    print("Predicting targets at {}% accuracy".format(percentage))

class ds(object):
    pass


def read_haberman():
    raw_data = np.genfromtxt("data/haberman.data.txt", dtype=str, delimiter=',')

    dts = ds()
    dts.data = raw_data[:, :len(raw_data[0]) - 1].astype(np.float)
    dts.target = raw_data[:, len(raw_data[0]) - 1:].astype(np.float).flatten()
    return dts


def main(argv):
    # dataset = load_digits()
    # dataset = load_breast_cancer()
    dataset = read_haberman()

    dataset.data = scale(dataset.data)
    rows = len(dataset.data)
    test_items = math.floor(rows * 0.3)
    indices = np.random.permutation(rows)
    training_data = dataset.data[indices[:-test_items]]
    training_targets = dataset.target[indices[:-test_items]]
    test_data = dataset.data[indices[-test_items:]]
    test_targets = dataset.target[indices[-test_items:]]

    max_bag_samples = 0.7
    max_bag_features = 0.7

    # kNN
    knn_clf = KNeighborsClassifier()
    knn_clf.fit(training_data, training_targets)
    print("kNN accuracy:")
    report_accuracy(knn_clf.predict(test_data), test_targets)

    bagging_knn = BaggingClassifier(KNeighborsClassifier(), max_samples=max_bag_samples, max_features=max_bag_features)
    bagging_knn.fit(training_data, training_targets)
    print("kNN bagged accuracy:")
    report_accuracy(bagging_knn.predict(test_data), test_targets)
    print()

    # SVM
    svm_clf = SVC()
    svm_clf.fit(training_data, training_targets)
    print("SVM accuracy:")
    report_accuracy(svm_clf.predict(test_data), test_targets)

    bagging_svm = BaggingClassifier(SVC(), max_samples=max_bag_samples, max_features=max_bag_features)
    bagging_svm.fit(training_data, training_targets)
    print("kNN bagged accuracy:")
    report_accuracy(bagging_svm.predict(test_data), test_targets)
    print()

    # Naive Bayes
    nb_clf = GaussianNB()
    nb_clf.fit(training_data, training_targets)
    print("Naive Bayes accuracy:")
    report_accuracy(nb_clf.predict(test_data), test_targets)

    bagging_nb = BaggingClassifier(GaussianNB(), max_samples=max_bag_samples, max_features=max_bag_features)
    bagging_nb.fit(training_data, training_targets)
    print("kNN bagged accuracy:")
    report_accuracy(bagging_nb.predict(test_data), test_targets)
    print()

    # AdaBoost
    boost_clf = AdaBoostClassifier(n_estimators=200)
    scores = cross_val_score(boost_clf, dataset.data, dataset.target)
    print("AdaBoost accuracy:")
    print(scores.mean())
    print()

    # Random Forest
    forest_clf = RandomForestClassifier(n_estimators=20)
    scores = cross_val_score(forest_clf, dataset.data, dataset.target)
    print("Random Forest accuracy:")
    print(scores.mean())

    return 0


if __name__ == "__main__":
    main(sys.argv)
