.PHONY: default all opt doc install uninstall clean test
default: all opt
utf8uni.ml: urange.ml
	ocamlc -o urange urange.ml
	./urange > utf8uni.ml
all: utf8uni.ml
	ocamlc -c -g utf8uni.mli
	ocamlc -c -g utf8uni.ml
	ocamlc -c -g utf8val.mli
	ocamlc -c -g utf8val.ml
	ocamlc -a -g -o libutf8val.cma utf8uni.cmo utf8val.cmo
opt:
	ocamlc -c -g utf8uni.mli
	ocamlopt -c -g utf8uni.ml
	ocamlc -c -g utf8val.mli
	ocamlopt -c -g utf8val.ml
	ocamlopt -a -g -o libutf8val.cmxa utf8uni.cmx utf8val.cmx
doc:
	mkdir -p html
	ocamldoc -html -d html utf8uni.mli utf8val.mli

libutf8val.cmxa: opt

test: libutf8val.cmxa
	ocamlopt -o test_utf8val libutf8val.cmxa test_utf8val.ml
	./test_utf8val
install:
	ocamlfind install utf8val META \
          $$(ls utf*.mli utf*.cm[iox] utf*.o libutf* 2>/dev/null)
uninstall:
	ocamlfind remove utf8val
clean:
	rm -f *.cm[ioxa] *.o *.cmxa *.a *~
	rm -rf html
	rm -f urange utf8uni.ml test_utf8val
