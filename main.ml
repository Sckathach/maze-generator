open Random;;
open Unix;;

Random.init (int_of_float (Unix.time ()))

type surrounding = Right | Left | Up | Down

type cell = {
    position: int * int;
    mutable walls: bool array;
    mutable neighbours: surrounding list    (* Unvisited neighbours *)
}

type stack = (int * int) list

let init_check x y n = let a = Array.make_matrix n n true in a.(x).(y) <- false ; a

let n = ref 10
let x_start = ref 0
let y_start = ref 0

let () =
    try n := int_of_string (Sys.argv.(1)) with Invalid_argument _ -> () ;
    try x_start := int_of_string (Sys.argv.(2)) with Invalid_argument _ -> () ;
    try y_start := int_of_string (Sys.argv.(3)) with Invalid_argument _ -> ()


let init n =
    let a = Array.make_matrix n n {position = (0, 0); walls = [|true; true; true; true |]; neighbours = []} in
        for x = 0 to n - 1 do
            for y = 0 to n - 1 do
                let c = { position = (x, y); walls = [|true; true; true; true |]; neighbours = [] } in
                    if x != 0 then
                        c.neighbours <- Left :: c.neighbours;
                    if x != n - 1 then
                        c.neighbours <- Right :: c.neighbours;
                    if y != 0 then
                        c.neighbours <- Up :: c.neighbours;
                    if y != n - 1 then
                        c.neighbours <- Down :: c.neighbours;
                    a.(x).(y) <- c
            done;
        done;
    a

let plateau = init !n
let start = (!x_start, !y_start)
let check = init_check (fst start) (snd start) !n
let stack : stack = start :: []

let fill = "  "

let w = function
    Right -> 0
    | Left -> 1
    | Up -> 2
    | Down -> 3

let print_plateau a =
    let n = Array.length a in
        let lh = ref " " in
            let lv = ref " " in
                for y = 0 to n - 1 do
                    lh := "* ";
                    lv := "| ";
                    for x = 0 to n - 1 do
                        let c = a.(x).(y) in
                            if c.walls.(w Right) then
                                lv := !lv ^ fill ^ " | "
                            else
                                lv := !lv ^ fill ^ "   ";
                            if c.walls.(w Up) then
                                lh := !lh ^ "-- * "
                            else
                                lh := !lh ^ "   * ";
                    done;
                    print_string (!lh ^ "\n");
                    print_string (!lv ^ "\n");
                done;
                lh := "* ";
                for i = 0 to n - 1 do
                    lh := !lh ^ "-- * "
                done;
                print_string (!lh ^ "\n")




let get_random_neighbour l =
    let a = Array.of_list l in
        let n = Array.length a in
            if n = 0 then
                None
            else
                Some a.(Random.int n)

let filter_check l =
    let rec aux acc = function
        [] -> acc
        | (x, y) :: q -> if check.(x).(y) then aux ((x, y) :: acc) q else aux acc q
    in aux [] l

let coord_of_surroundings x y =
    let rec aux acc = function
        | [] -> acc
        | Up :: q -> aux ((x, y-1) :: acc) q
        | Down :: q -> aux ((x, y+1) :: acc) q
        | Right :: q -> aux ((x+1, y) :: acc) q
        | Left :: q -> aux ((x-1, y) :: acc) q
    in aux [] plateau.(x).(y).neighbours



let print_stack (s : stack) =
    let rec aux = function
        [] -> print_string "]\n"
        | (x, y) :: q -> print_string "(" ; print_int x ; print_string "; " ; print_int y ; print_string "); " ; aux q
    in print_string "[" ; aux s

let print_tuple = function
    (x, y) -> print_string "(" ; print_int x ; print_string ", " ; print_int y ; print_string ")"

let rec create_maze = function
    [] -> ()
    | (x, y) :: q as z ->
        begin
            match coord_of_surroundings x y |> filter_check |> get_random_neighbour with
                None -> create_maze q
                | Some (a, b) ->
                    begin
                        check.(a).(b) <- false;
                        begin
                            match (x-a, y-b) with
                                (0, -1) -> plateau.(a).(b).walls.(w Up) <- false
                                | (0, 1) -> plateau.(x).(y).walls.(w Up) <- false
                                | (1, 0) -> plateau.(a).(b).walls.(w Right) <- false
                                | (-1, 0) -> plateau.(x).(y).walls.(w Right) <- false
                        end;
                        create_maze ((a, b) :: z);
                    end;
        end;;


create_maze stack;
print_plateau plateau
