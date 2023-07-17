# Basic playground for OCaml
<p align="center">
<a target="_blank" href="https://ocaml.org"><img src="https://img.shields.io/badge/language-OCaml-orange"/></a> 
<a target="_blank" href="https://archlinux.org"><img src="https://img.shields.io/badge/os-Archlinux-blue"/></a>
</p>

## Install the tools 
### Install opam 
#### Archlinux 
```sh
pacman -S opam

eval $(opam env)

opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release
```

#### Ubuntu
```sh
add-apt-repository ppa:avsm/ppa
apt update
apt install opam

eval $(opam env)

opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release
```

## It's simple ! 
- Compile with `make`
- Test with `make test`

## Test your code in Utop !
When working on x.ml you can use the command:
```sh 
make test TEST=x
```

You can also specify the librairies you need:
```sh 
make test LIB=x y z TEST=playground
```

By default, the file to test is `playground.ml` and there is no librairies needed. 

### Useful commands in Utop
- `#directory "_build";;` &rarr; sets working directory to _build
- `#load "ast.cmo";;` &rarr; load a librairy
- `#use "calc.ml";;` &rarr; to load calc.ml in utop,when working on a single file that doesn't have dependencies, it's enough
- `#quit;;` &rarr; to leave utop


## Add unit tests !
The file `tests.ml` is reserved for unit testing. You can add tests in the list `tests`:
```ocaml
let tests = [
    test (vars (EBop(BAdd, EVar "x", EInt 3))) ["x"];
    test 3 2;
    test (floor (VFloat 3.14)) (VFloat 3.);
    test_message 3 4 "This message will be printed";
    test_message 3 3 "This message won't, because 3 = 3, wow"
]
```

You can then run the tests by typing `make unit`.

> ⚠️ Don't forget to open all the needed modules at the beginning of `tests.ml`.

## Future work 
Dune
