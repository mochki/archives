import numpy as np


class Dataset(object):
    """ Skeletons of a dataset """

    def __init__(self):
        self.DESCR = ""
        self.data = np.array([])
        self.target = np.array([])
        self.input_count = 0
        self.target_count = 0
        self.training_data = np.array([])
        self.test_data = np.array([])
        self.training_targets = np.array([])
        self.test_targets = np.array([])
        self.predicted_targets = np.array([])
        self.means = np.array([])
        self.standard_devs = np.array([])

    def load_from_txts(self, names_file, data_file):
        with open(names_file) as f:
            self.DESCR = f.readlines()

        raw_data = np.genfromtxt(data_file, dtype=str, delimiter=',')

        self.data = raw_data[:, :len(raw_data[0]) - 1].astype(np.float)

        raw_targets = raw_data[:, len(raw_data[0]) - 1:]
        target_key = {}
        target_num = 0
        for nd_target in np.unique(raw_targets):
            target_key[str(nd_target)] = target_num
            target_num += 1

        for x in range(len(raw_targets)):
            raw_targets[x] = target_key[raw_targets[x][0]]

        self.target = raw_targets.astype(np.float).flatten()

    def load_car(self, names_file, data_file):
        with open(names_file) as f:
            self.DESCR = f.readlines()

        # I transpose completely for my ease of thinking
        raw_data = np.genfromtxt(data_file, dtype=str, delimiter=',').T

        # This makes me sad. Hahaha
        for y in range(7):
            if y == 0 or y == 1:
                for x in range(len(raw_data[y])):
                    if raw_data[y][x] == 'low':
                        raw_data[y][x] = 0
                    elif raw_data[y][x] == 'med':
                        raw_data[y][x] = 1
                    elif raw_data[y][x] == 'high':
                        raw_data[y][x] = 2
                    else:
                        raw_data[y][x] = 3
            elif y == 2:
                for x in range(len(raw_data[y])):
                    if raw_data[y][x] == '2':
                        raw_data[y][x] = 0
                    elif raw_data[y][x] == '3':
                        raw_data[y][x] = 1
                    elif raw_data[y][x] == '4':
                        raw_data[y][x] = 2
                    else:
                        raw_data[y][x] = 3
            elif y == 3:
                for x in range(len(raw_data[y])):
                    if raw_data[y][x] == '2':
                        raw_data[y][x] = 0
                    elif raw_data[y][x] == '4':
                        raw_data[y][x] = 1
                    else:
                        raw_data[y][x] = 2
            elif y == 4:
                for x in range(len(raw_data[y])):
                    if raw_data[y][x] == 'small':
                        raw_data[y][x] = 0
                    elif raw_data[y][x] == 'med':
                        raw_data[y][x] = 1
                    else:
                        raw_data[y][x] = 2
            elif y == 5:
                for x in range(len(raw_data[y])):
                    if raw_data[y][x] == 'low':
                        raw_data[y][x] = 0
                    elif raw_data[y][x] == 'med':
                        raw_data[y][x] = 1
                    else:
                        raw_data[y][x] = 2
            elif y == 6:
                for x in range(len(raw_data[y])):
                    if raw_data[y][x] == 'unacc':
                        raw_data[y][x] = 0
                    elif raw_data[y][x] == 'acc':
                        raw_data[y][x] = 1
                    elif raw_data[y][x] == 'good':
                        raw_data[y][x] = 2
                    else:
                        raw_data[y][x] = 3

        self.data = raw_data[:len(raw_data) - 1].T.astype(np.float)
        self.target = raw_data[len(raw_data) - 1:].T.astype(np.float).flatten()

    def randomize_data(self):
        reorder = np.random.permutation(len(self.data))
        self.data = self.data[reorder]
        self.target = self.target[reorder]

    def split_data(self, training_percent=70):
        # Default 70/30, can change
        training_size = round(len(self.data) * (training_percent / 100))
        self.training_data, self.test_data = np.split(self.data, [training_size])
        self.training_targets, self.test_targets = np.split(self.target, [training_size])

    def standardize_data(self):
        standardized_data = self.training_data.T
        standardized_test_data = self.test_data.T
        col_means = []
        col_stds = []

        for x in range(len(standardized_data)):
            col_means.append(np.mean(standardized_data[x]))
            col_stds.append(np.std(standardized_data[x]))
            standardized_data[x] = [(el - col_means[x]) / col_stds[x] for el in standardized_data[x]]

        for x in range(len(standardized_test_data)):
            standardized_test_data[x] = [(el - col_means[x]) / col_stds[x] for el in standardized_test_data[x]]

        self.training_data = standardized_data.T
        self.test_data = standardized_test_data.T
        self.means = np.array(col_means)
        self.standard_devs = np.array(col_stds)
        self.input_count = self.training_data.shape[1]
        self.target_count = len(np.unique(self.training_targets))

    def report_accuracy(self):
        correct = 0
        for i in range(len(self.test_targets)):
            if self.test_targets[i] == self.predicted_targets[i]:
                correct += 1
        percentage = round(correct / len(self.test_targets), 2) * 100
        print("Predicting targets at {}% accuracy".format(percentage))