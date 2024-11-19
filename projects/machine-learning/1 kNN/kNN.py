import numpy as np


class kNN(object):
    """ Find the neighbors! """

    # Let's explicitly 'train' our classifier
    def train(self, training_data, training_targets):
        print("Standardizing & training on {} items".format(len(training_data)))

        # we're going to standardize our data here
        standardized_data = training_data.T
        col_means = []
        col_stds = []

        # that would be really embarrassing it this math was wrong
        for x in range(len(standardized_data)):
            col_means.append(np.mean(standardized_data[x]))
            col_stds.append(np.std(standardized_data[x]))
            standardized_data[x] = [(el - col_means[x]) / col_stds[x] for el in standardized_data[x]]

        self.training_data = standardized_data.T
        self.training_targets = training_targets
        self.means = np.array(col_means)
        self.stds = np.array(col_stds)

    # k is arbitrarily set here if not provided
    def predict(self, test_data, k=3):
        # Setup
        # standardize test data based off of training means and stdevs
        standardized_test_data = np.array([(x - self.means) / self.stds for x in test_data])
        test_results = []
        print("Predicting targets on {} items using kNN with k at {}".format(len(test_data), k))

        for test_item in standardized_test_data:
            NN_sums = []
            for training_row in self.training_data:
                sum = np.sum((training_row - test_item) ** 2)
                NN_sums.append(sum)

            NN_sums_sorted = np.array(NN_sums).argsort()
            NN_results = self.training_targets[NN_sums_sorted[:k]]
            # apparently only works with ints, but I'll format results to ints
            items, freq = np.unique(NN_results, return_counts=True)
            NN_freq = np.asarray((items, freq))  # Tranpose?

            # simplest case first
            if len(NN_freq[0]) == 1:
                test_results.append(NN_freq[0][0])
            else:
                # this will stay a 2D array, man this is ugly
                sort = NN_freq[1].argsort()[-(len(NN_freq) - 1):]
                NN_freq[0] = NN_freq[0][sort]
                NN_freq[1] = NN_freq[1][sort]

                mxidx = len(NN_freq[1]) - 1
                if NN_freq[1][mxidx] > NN_freq[1][mxidx - 1]:
                    test_results.append(NN_freq[0][mxidx])
                else:
                    test_results.append(self.predict_one(test_item, NN_sums_sorted, k - 1))

        return np.array(test_results)

    # Recursive decreasing k algorithm
    def predict_one(self, test_item, sums, k):
        NN_results = self.training_targets[sums[:k]]
        items, freq = np.unique(NN_results, return_counts=True)
        NN_freq = np.asarray((items, freq))

        if k == 1 or len(NN_freq[0]) == 1:
            return NN_results[0]

        sort = NN_freq[1].argsort()[-(len(NN_freq) - 1):]
        NN_freq[0] = NN_freq[0][sort]
        NN_freq[1] = NN_freq[1][sort]
        mxidx = len(NN_freq[1]) - 1

        if NN_freq[1][mxidx] > NN_freq[1][mxidx - 1]:
            return NN_freq[0][mxidx]
        else:
            return self.predict_one(test_item, sums, k - 1)
