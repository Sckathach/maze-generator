open Playground;;

let test_message x y m i =
    if x = y then
        (Printf.sprintf "TEST %i : Pass" i, true)
    else
        (Printf.sprintf "TEST %i : Fail %s" i m, false);;

let test x y i = test_message x y " " i;;

let tests = [
    test (f 1) 2;
    test (f 1) 3;
]

let () =
    let rec aux b i = function
        [] ->
            if b then
                print_endline "*** FINISHED : OK ***"
            else
                print_endline "*** FINISHED : FAIL ***"
        | x :: q ->
            begin
                match x i with
                    y, z -> print_endline y; aux (z && b) (i + 1) q
            end
    in
        print_endline "*** START ***";
        aux true 0 tests;;
