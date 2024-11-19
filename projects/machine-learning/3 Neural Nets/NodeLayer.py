import Node


class NodeLayer(object):
    """ Node Layer - A single perceptron """

    def __init__(self, n_count, in_count):
        self.nodes = [Node.Node(in_count) for x in range(n_count)]

    # I had such big dreams for this class
