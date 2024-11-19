import numpy as np
import NodeLayer as nl


class NeuralNetwork(object):
    """ Hold All The Things! Nodes & Weights & Bros """

    def __init__(self):
        self.network = []

    # pass in array, number of nodes for each layer
    def create_network(self, dataset, hidden_layers_data=[]):
        """ All nodes will be added to our network. +1 will be added for a bias node """

        # +1 for the bias nodes
        if len(hidden_layers_data) == 0:
            self.network.append(nl.NodeLayer(dataset.target_count, dataset.input_count + 1))
            return

        for x in range(len(hidden_layers_data)):
            if x == 0:
                self.network.append(nl.NodeLayer(hidden_layers_data[x], dataset.input_count + 1))
            else:
                self.network.append(nl.NodeLayer(hidden_layers_data[x], len(self.network[x - 1].nodes) + 1))

        self.network.append(nl.NodeLayer(dataset.target_count, len(self.network[len(self.network) - 1].nodes) + 1))

    # We're enforcing a bias -1 input --- Have to call this with each data item
    def compute_results(self, inputs):
        working_inputs = []
        for layer in range(len(self.network)):
            for node in self.network[layer].nodes:
                if layer == 0:
                    node.calculate_output([-1] + inputs.tolist())
                else:
                    node.calculate_output([-1] + working_inputs)

            working_inputs.clear()
            for node in self.network[layer].nodes:
                working_inputs.append(node.value)

    def update_nodes(self, inputs, target, learning_rate, momentum):
        first = True
        layer_avg_error = 0
        for layer in range(len(self.network)-1, -1, -1):
            avg_error = 0
            if first and layer == 0:
                for node in range(len(self.network[layer].nodes)):
                    self.network[layer].nodes[node].update_weights([-1] + inputs.tolist(), learning_rate, momentum,
                                                                   output_target=target[node])
                    avg_error += self.network[layer].nodes[node].node_j_error
                first = False
                avg_error /= len(self.network[layer].nodes)
            elif first:
                for node in range(len(self.network[layer].nodes)):
                    self.network[layer].nodes[node].update_weights(
                        [-1] + [node.value for node in self.network[layer - 1].nodes], learning_rate, momentum,
                        output_target=target[node])
                    avg_error += self.network[layer].nodes[node].node_j_error
                first = False
                avg_error /= len(self.network[layer].nodes)
            elif layer == 0:
                for node in range(len(self.network[layer].nodes)):
                    self.network[layer].nodes[node].update_weights([-1] + inputs.tolist(), learning_rate, momentum,
                                                                   next_layer=self.network[layer+1].nodes,
                                                                   current_node_index=node+1, hidden_layer=True)
            else:
                for node in range(len(self.network[layer].nodes)):
                    self.network[layer].nodes[node].update_weights(
                        [-1] + [node.value for node in self.network[layer - 1].nodes], learning_rate, momentum,
                        next_layer=self.network[layer+1].nodes, current_node_index=node+1, hidden_layer=True)

            layer_avg_error += avg_error
        layer_avg_error /= len(self.network)
        return layer_avg_error

    def fit(self, dataset, learning_rate=0.3, momentum=0.9, error_change_percent=0.1, epoch_iterations=250):
        error_data = []
        first = True
        alive = True
        limit = epoch_iterations
        while alive and limit:
            instance_avg_error = 0
            for row in range(len(dataset.training_data)):
                self.compute_results(dataset.training_data[row])
                target_array = [1 if x == dataset.training_targets[row] else 0 for x in range(dataset.target_count)]
                instance_avg_error += self.update_nodes(dataset.training_data[row], target_array,
                                                        learning_rate, momentum)
            instance_avg_error /= len(dataset.training_data)
            error_data.append(abs(instance_avg_error))

            if first:
                first = False
                continue
            else:
                per = error_data[len(error_data) - 1] / error_data[len(error_data) - 2]
                if per < error_change_percent:
                    alive = False

            limit -= 1
        return error_data


    def predict(self, dataset):
        output = []
        predicted_target = []

        for row in dataset.test_data:
            self.compute_results(row)

            for node in self.network[len(self.network) - 1].nodes:
                output.append(node.value)

            predicted_target.append(output.index(max(output)))
            output.clear()

        dataset.predicted_targets = np.array(predicted_target)