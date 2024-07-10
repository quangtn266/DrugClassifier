# DrugClassifier
A machine learning pipeline (CI/CD pipeline)

## Steps (Local env)

1. Training model (train.py)

```
python train.py
```

2. Running app (App/app)

```
streamlit run ./App/app.py
```

## CI/ CD

### Settings
Configure secrets environment variables.
- TOKEN (github token)
- HF_TOKEN (huggingface token access)
- USER_NAME
- USER_EMAIL

### CI/ CD running
There are 2 parts for workflow, you can create .yaml files in "Actions" of Github bar fpr running:
- CI
- CD

### Huggingface
https://huggingface.co/spaces/quangtn266/Drug-Classification
