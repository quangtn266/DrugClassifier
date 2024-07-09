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
	echo '![Confusion Matrix](./results/model_results.png)' >> report.md

	cml comment create --publish report.md

update-branch:
	git config --global user.name "$(git log -n 1 --pretty=format:%an)" # $(USER_NAME)
	git config --global user.email "$(git log -n 1 --pretty=format:%ae)" # $(USER_EMAIL)
	git commit -am "Update with new results"
	git push --force origin HEAD:update
