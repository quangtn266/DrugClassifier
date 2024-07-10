import streamlit as st
import numpy as np
import pickle
from utils.prediction import predict_drug


# Loading the model
filename = "./model/drug_pipeline.sav"
pipe = pickle.load(open(filename, "rb"))


# Web interface section
st.title("Drug Classifier")

# Singular prediction
with st.sidebar.expander("Single Prediction"):
    with st.form(key="drug_form", clear_on_submit=True):
        st.title("Drug Information Form")
        age = st.number_input(label="Age", min_value=15, step=1, max_value=74)

        gender_list = np.array(["Male", "Female"])
        gender = st.radio("Select your Gender", gender_list)

        blood_pressure_list = np.array(["HIGH", "LOW", "NORMAL"])
        blood_pressure = st.radio("Select your Blood pressure", blood_pressure_list)

        cholesterol_list = np.array(["HIGH", "NORMAL"])
        cholesterol = st.radio("Select your Cholesterol", cholesterol_list)

        Na_to_k = st.number_input(
            label="NA_to_K", min_value=6.2, step=0.1, max_value=38.2
        )
        submit_button = st.form_submit_button(label="Predict")

if submit_button:
    prediction = predict_drug(
        age, gender[0], blood_pressure, cholesterol, Na_to_k, pipe
    )

    if prediction is None:
        st.error("An error occurred while getting the prediction!")

    message = f"The Drug is {prediction}!"
    message_color = "red" if prediction == 1 else "green"
    st.markdown(
        f"<h3 style='text-align: left;color:{message_color}'> {(message)} </h3>",
        unsafe_allow_html=True,
    )
