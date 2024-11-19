import numpy as np


class Node(object):

    def __init__(self, data, targets, cols, root=False):
        self.nodes = []
        self.feature = None
        self.value = None
        self.data = data
        self.targets = targets
        self.cols = cols
        self.entropy = self.calculate_entropy()

    def create_next_node(self):

        # Set value at end conditions and return
        target_set = np.unique(self.targets)
        if len(target_set) == 1:
            self.value = target_set[0]
            return
        elif len(self.cols) == 0:
            tar_freq = []
            for tar in target_set:
                tar_freq.append(self.targets.tolist().count(tar))
            self.value = target_set[tar_freq.index(max(tar_freq))]
            return

        # Calculate information gain!
        row_count = len(self.data[:, 0])
        information_gain = []
        category_nodes = []
        for feature in self.cols:
            gain = self.entropy
            temp_nodes = []
            for pos_values in np.unique(self.data[:, feature]):
                prob = self.data[:, feature].tolist().count(pos_values) / row_count

                temp_data = np.append(self.data, np.reshape(self.targets, (-1, 1)), 1).T
                temp_data = temp_data[:, temp_data[feature] == pos_values].T
                temp_cols = self.cols[:]
                temp_cols.remove(feature)

                temp_node = Node(temp_data[:, :len(temp_data[0]) - 1], temp_data[:, len(temp_data[0]) - 1:].astype(np.float), temp_cols)

                gain -= prob * temp_node.entropy
                temp_nodes.append(temp_node)
            category_nodes.append(temp_nodes)
            information_gain.append(gain)

        index_of_next_feature = information_gain.index(max(information_gain))
        self.feature = self.cols[index_of_next_feature]
        self.nodes = category_nodes[index_of_next_feature]

        # Recurse
        for node in self.nodes:
            node.create_next_node()

        return

    def calculate_entropy(self):
        sum = 0
        for x in np.unique(self.targets):
            prob = self.targets.tolist().count(x) / len(self.targets)
            sum += -1 * prob * np.log2(prob)
        return sum
