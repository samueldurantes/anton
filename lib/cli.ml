open Tree
open Eval

let e file = Lexing.from_string file |> Parser.main (Lexer.main)

let run_cli (s : string) =
  match s with
  | "repl" -> failwith "repl"
  | file ->
    (match e file with
    | Some t -> term_to_string (quote (eval t []))
    | None -> failwith "error")
