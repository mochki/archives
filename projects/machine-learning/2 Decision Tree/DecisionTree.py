import numpy as np
import Node

class DecisionTree(object):
    """ Really thin abstraction here """

    def __init__(self, dataset):
        self.dataset = dataset

        self.classes = dataset.target_count
        self.cols = list(range(0, len(dataset.data[0])))

        self.tree = Node.Node(self.dataset.training_data, self.dataset.training_targets, self.cols, root=True)

    # pass in array, number of nodes for each layer
    def create_tree(self):
        self.tree.create_next_node()

    def predict_numeric(self):
        predicted_targets = []
        for row in self.dataset.test_data:
            predicted_targets.append(self.evaluate_numeric_node(row, self.tree))

        return predicted_targets

    def evaluate_numeric_node(self, row, node):
        if node.value:
            return node.value
        else:
            upper_bound = 0
            for i in reversed(self.dataset.rules[node.feature]):
                if row[node.feature] > i:
                    break
                elif upper_bound == len(node.nodes) - 1:
                    break
                upper_bound += 1
            return self.evaluate_numeric_node(row, node.nodes[len(node.nodes) - (1 + upper_bound)])

    def predict_nominal(self):
        predicted_targets = []
        for row in self.dataset.test_data:
            predicted_targets.append(self.evaluate_nominal_node(row, self.tree))

        return predicted_targets

    def evaluate_nominal_node(self, row, node):
        if node.value != None:
            return node.value
        else:
            value_set = np.unique(self.dataset.training_data[:, node.feature]).tolist()
            indexOfNode = value_set.index(row[node.feature])
            return self.evaluate_nominal_node(row, node.nodes[indexOfNode])

    def print_tree(self):
        print("root split on feature {}".format(self.tree.feature))
        for node in self.tree.nodes:
            self.node_to_string(node)

    def node_to_string(self, node):
        """ This looks terrible but my brain hurts """
        print("    ", end='')
        if node.value is not None:
            print("|___{}".format(node.value))
        else:
            print("Node split on feature {}".format(node.feature))
            for node in node.nodes:
                self.node_to_string(node)

