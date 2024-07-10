
def predict_drug(age, sex, blood_pressure, cholesterol, na_to_k_ratio, pipe):
    """
        Predict drugs based on patient features.

    :param age:
    :param sex:
    :param blood_pressure:
    :param cholesterol:
    :param na_to_k_ratio:
    :return: str: Predicted drug label.

    """

    features = [age, sex, blood_pressure, cholesterol, na_to_k_ratio]
    predicted_drug = pipe.predict([features])[0]

    label = f"Predicted Drug: {predicted_drug}"
    return label