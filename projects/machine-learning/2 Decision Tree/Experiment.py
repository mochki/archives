import sys
import Dataset as ds
import DecisionTree as dt


def main(argv):
    # Load & Prep
    dataset = ds.Dataset()
    # dataset.load_iris()
    dataset.load_lenses()
    # dataset.load_voting()

    # Create Tree & Predict
    ID3 = dt.DecisionTree(dataset)
    ID3.create_tree()
    # dataset.predicted_targets = ID3.predict_numeric()
    dataset.predicted_targets = ID3.predict_nominal()

    # How did we do?
    dataset.report_accuracy()
    ID3.print_tree()

    return 0


if __name__ == "__main__":
    main(sys.argv)
