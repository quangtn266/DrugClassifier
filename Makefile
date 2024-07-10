install:
	pip install --upgrade pip && pip install -r requirements.txt

format:
	black *.py

train:
	python train.py

eval:
	echo 'Model metrics' > report.md
	cat ./results/metrics.txt >> report.md

	echo '\n Confusion Matrix Plot' >> report.md
	echo '![Confusion Matrix](./results/model_result.png)' >> report.md

	cml comment create --publish report.md

update-branch:
	git config --global user.name $(USER_NAME)
	git config --global user.email $(USER_EMAIL)
	git commit -am "Update with new results"
	git push --force origin HEAD:update

hf-login:
	git pull origin update
	git switch update
	pip install -U "huggingface_hub[cli]"
	huggingface-cli login --token $(HF_TOKEN) --add-to-git-credential

push-hub:
	huggingface-cli upload quangtn266/Drug-Classification ./app.py --repo-type=space --commit-message="Sync App files"
	huggingface-cli upload quangtn266/Drug-Classification ./model /model --repo-type=space --commit-message="Sync model"
	huggingface-cli upload quangtn266/Drug-Classification ./results /metrics --repo-type=space --commit-message="Sync model"
	huggingface-cli upload quangtn266/Drug-Classification ./utils /utils --repo-type=space --commit-message="Sync model"
	huggingface-cli upload quangtn266/Drug-Classification ./requirements.txt /requirements.txt --repo-type=space --commit-message="Sync requirements"

deploy: hf-login push-hub

#all: install format train eval update-branch deploy
