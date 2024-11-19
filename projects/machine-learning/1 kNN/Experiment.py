import sys
import numpy as np
import kNN as clsfr
import Dataset as ds


# IDEAS: split 3 way, add the validation thing?

def randomize_dataset(dataset):
    # This syntax is off the internet, I've no idea what the sytnax
    reorder = np.random.permutation(len(dataset.data))
    dataset.data = dataset.data[reorder]
    dataset.target = dataset.target[reorder]


def split_dataset(dataset):
    # We're doing 70/30 here
    training_size = round(len(dataset.data) * .7)
    training_data, test_data = np.split(dataset.data, [training_size])
    training_targets, test_targets = np.split(dataset.target, [training_size])
    # Is this ugly? I don't know. Probably.
    return training_data, test_data, training_targets, test_targets


def report_accuracy(test_results, test_targets):
    correct = 0
    for i in range(len(test_results)):
        if test_results[i] == test_targets[i]:
            correct += 1
    percentage = round(correct / len(test_results), 2) * 100
    print("Predicting targets at {}% accuracy".format(percentage))


def main(argv):
    # Load
    dataset = ds.Dataset()
    # dataset.load_dataset_from_iris_csv('data/iris.csv')
    dataset.load_from_txts_if_categorical('data/car.names.txt', 'data/car.data.txt')
    # dataset.load_from_txts_if_numerical('data/iris.names.txt', 'data/iris.data.txt')

    randomize_dataset(dataset)
    training_data, test_data, training_targets, test_targets = split_dataset(dataset)

    # Train, predict
    classifier = clsfr.kNN()
    classifier.train(training_data, training_targets)

    # I tried lots of k's.
    test_results = classifier.predict(test_data, k=4)

    # How did we do?
    report_accuracy(test_results, test_targets)

    return 0


if __name__ == "__main__":
    main(sys.argv)
