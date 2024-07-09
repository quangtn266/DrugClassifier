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
	#git config --global user.name $(USER_NAME)
	#git config --global user.email $(USER_EMAIL)
	git config user.name "${{ github.actor }}"
	git config user.email "${{ github.actor_id }}+${{ github.actor }}@users.noreply.github.com"
	git commit -am "Update with new results"
	git push --force origin HEAD:update
