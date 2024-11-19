import numpy as np


class Node(object):
    """ Node and Co. """

    def __init__(self, w_counts):
        self.value = 0
        self.w_counts = w_counts
        self.weights = [np.random.uniform(-1.0) for x in range(w_counts)]
        self.old_weights = [0 for x in range(w_counts + 1)]
        self.delta_weights = [0 for x in range(w_counts + 1)]
        self.node_j_error = 0

    def calculate_output(self, inputs):
        """ Uses a sigmoid function - f(x) = 1 / (1 + e^-x) """
        if len(inputs) != len(self.weights):
            raise IndexError("The number of weights does not match the number of inputs")

        self.value = 1 / (1 + np.e**(-np.dot(self.weights, inputs)))

    # This function seems overbloated :/
    def update_weights(self, previous_layer, learning_rate, momentum, output_target=None,
                       next_layer=None, current_node_index=None, hidden_layer=False):

        self.old_weights = self.weights

        # we set up little error
        if hidden_layer:
            temp_sum = 0
            for node in next_layer:
                temp_sum += node.node_j_error * node.old_weights[current_node_index]
            self.node_j_error = self.value * (1 - self.value) * temp_sum
        else:
            self.node_j_error = self.value * (1 - self.value) * (self.value - output_target)

        # each weight...
        for x in range(self.w_counts):
            self.delta_weights[x] = learning_rate * self.node_j_error * previous_layer[x] + momentum * self.delta_weights[x]
            self.weights[x] -= self.delta_weights[x]