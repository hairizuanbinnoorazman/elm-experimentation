server:
	cd ./backend && pipenv run server
build:
	elm make src/main.elm --output=main.html
format:
	elm-format src/main.elm --yes