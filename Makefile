init:
	brew update
	brew bundle
	rbenv install --skip-existing
	rbenv exec gem install bundler
	rbenv exec bundle update

build:
	sass --update css
	rbenv exec bundle exec jekyll build

serve:
	cd _site && python3 -m http.server 4000 --bind localhost &
	echo "Loading site..."
	sleep 3
	open http://localhost:4000

endserve:
	killall Python

publish:
	./scripts/publish

bust-cache:
	aws --profile hivefbx cloudfront create-invalidation --distribution-id EZEUY9RAFTGQL --paths "$(HIVE_PATHS)"

check-cache-invalidations:
	aws --profile hivefbx cloudfront list-invalidations --distribution-id EZEUY9RAFTGQL | jq '.InvalidationList.Items[].Status'
