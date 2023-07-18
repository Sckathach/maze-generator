# Simple CLI maze generator in OCaml
<p align="center">
<a target="_blank" href="https://ocaml.org"><img src="https://img.shields.io/badge/language-OCaml-orange"/></a> 
<a target="_blank" href="https://archlinux.org"><img src="https://img.shields.io/badge/os-Archlinux-blue"/></a>
</p>

## Use 
Directly use the `maze` executable or build it from `main.ml` with the ocamlc:
```sh 
ocamlc -o maze unix.cma main.ml -I +unix
```

```sh 
./maze [length] 
* -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * 
|    |         |              |                   | 
*    *    *    * -- *    *    *    * -- * -- *    * 
|         |              |         |              | 
* -- * -- * -- * -- * -- * -- * -- *    * -- * -- * 
|         |                        |              | 
*    * -- *    * -- * -- *    * -- * -- * -- *    * 
|         |    |         |                   |    | 
* -- *    *    *    *    * -- *    * -- * -- *    * 
|         |    |    |         |         |         | 
*    * -- *    *    *    * -- * -- *    *    * -- * 
|    |         |    |              |         |    | 
*    *    * -- * -- * -- *    *    * -- * -- *    * 
|    |    |                   |    |              | 
*    *    * -- *    * -- * -- *    *    * -- *    * 
|    |         |    |    |         |         |    | 
*    * -- *    *    *    *    * -- * -- *    *    * 
|         |         |    |    |              |    | 
*    * -- * -- * -- *    *    * -- *    * -- *    * 
|                                       |         | 
* -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * 
```

## Install the tools to compile/ debug OCaml code
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

