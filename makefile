all: main

main: src/ touhouML.cabal
	cabal build  2> errors.txt


.PHONY: clean
clean:
	rm -f src/a.out
	rm -f src/main
	rm -f src/screenshot
	rm -f src/*.png
	rm -f src/*.jpeg
	rm -f src/*.hi
	rm -f src/*.o
	rm -f src/*.i
