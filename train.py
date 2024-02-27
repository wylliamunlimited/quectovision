import os
import argparse
import pandas as pd
import mlflow
import mlflow.sklearn
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import log_loss
from azure.ai.ml import Input

def main():
    """Main function of the script."""

    # input and output arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("--data", type=str, help="path to input data")
    parser.add_argument("--registered_model_name", type=str, help="model name")
    args = parser.parse_args()
   
    # Start Logging
    mlflow.start_run()

    # enable autologging
    mlflow.sklearn.autolog()

    ###################
    #<prepare the data>
    ###################
    print(" ".join(f"{k}={v}" for k, v in vars(args).items()))

    print("input data:", args.data)
    
    data = pd.read_csv(args.data)
    print(data.columns)

    # Load the dataset (replace with your actual dataset)
    # Assume the dataset has columns 'symptom1', 'symptom2', ..., 'disease'

    # Preprocessing: Encode disease labels
    label_encoder = LabelEncoder()
    data['disease_encoded'] = label_encoder.fit_transform(data['diseases'])

    # Split data into train and test sets
    X = data.drop(columns=['diseases', 'disease_encoded'])
    y = data['disease_encoded']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Train a logistic regression model
    soft_classifier = LogisticRegression(multi_class='multinomial', solver='lbfgs', max_iter=1000)
    soft_classifier.fit(X, y)
    ###################
    #</train the model>
    ###################

    ##########################
    #<save and register model>
    ##########################
    # Registering the model to the workspace
    print("Registering the model via MLFlow")
    mlflow.sklearn.log_model(
        sk_model=soft_classifier,
        registered_model_name=args.registered_model_name,
        artifact_path=args.registered_model_name,
    )

    # Saving the model to a file
    mlflow.sklearn.save_model(
        sk_model=soft_classifier,
        path=os.path.join(args.registered_model_name, "trained_model"),
    )
    ###########################
    #</save and register model>
    ###########################
    
    # Stop Logging
    mlflow.end_run()

if __name__ == "__main__":
    main()