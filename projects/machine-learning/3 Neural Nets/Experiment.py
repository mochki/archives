import sys
import NeuralNetwork as net
import Dataset as ds
import matplotlib.pyplot as plt


def main(argv):
    # Load, randomize, set
    dataset = ds.Dataset()
    # dataset.load_from_txts('data/iris.names.txt', 'data/iris.data.txt')
    # dataset.load_from_txts('data/pima-indians-diabetes.names.txt', 'data/pima-indians-diabetes.data.txt')
    dataset.load_car('data/car.names.txt', 'data/car.data.txt')
    dataset.randomize_data()
    dataset.split_data()
    dataset.standardize_data()

    # Train, predict
    neural_net = net.NeuralNetwork()

    # Optional array for hidden nodes. Putting a number in the array means we want a
    # hidden layer there. The number we put in is the number of nodes in that layer
    # neural_net.create_network(dataset)
    neural_net.create_network(dataset, [2, 2, 2])

    # We just need to edit these values :D
    error_data = neural_net.fit(dataset, learning_rate=0.4, momentum=0.9,
                                error_change_percent=0.01, epoch_iterations=200)
    neural_net.predict(dataset)

    # Plot the data
    plt.figure()
    plt.title("Average Error per Epoch")
    plt.xlabel("Epcoh Instance")
    plt.ylabel("Average Error")
    plt.plot([x + 1 for x in range(len(error_data))], error_data)
    plt.savefig("error_graph.png")

    # How did we do?
    dataset.report_accuracy()

    return 0


if __name__ == "__main__":
    main(sys.argv)
