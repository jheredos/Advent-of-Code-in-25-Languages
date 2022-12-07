let file = "input.txt";;

let str_to_list s = s |> String.to_seq |> List.of_seq;;

(* Part 1 (didn't scale well for part 2!) *)
let search1 s =
  let rec f (a,b,c) s i =
    match s with
    | [] -> -1
    | h :: t when 
        h<>a && 
        h<>b && 
        h<>c && 
        a<>b && 
        b<>c && 
        a<>c -> i + 1
    | h :: t -> f (b,c,h) t (i+1)
  in
  f (String.get s 0,String.get s 1,String.get s 2) (str_to_list s) 0;;

(* Part 2 *)
let rec uniq xs =
  let rec check n ys =
    match ys with
    | [] -> true
    | h :: t when h = n -> false
    | h :: t -> check n t
  in
  match xs with
  | [] -> true
  | h :: t -> check h t && uniq t;;

let search2 n s =
  let rec f q xs i = 
    match xs with
    | [] -> -1
    | h :: t when List.length q < n -> f (q @ [h]) t (i+1)
    | h :: t when uniq q -> i
    | h :: t -> f ((List.tl q) @ [h]) t (i+1)
  in
  f [] (str_to_list s) 0;;


let ic = open_in file in
  let line = input_line ic in
    (* Part 1 *)
    print_int (search1 line);
    print_newline ();
    (* Part 2 *)
    print_int (search2 14 line);
    print_newline ();

    flush stdout;
    close_in ic;;
