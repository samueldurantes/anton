{
  open Parser
}

let digit = ['0'-'9']
let identifier = [^ '\n' '\r' '\t' ' ' '(' ')']
let num = digit+
let new_line = ['\r' '\n']
let whitespace = [' ' '\t']

rule main = parse
  | whitespace+ { main lexbuf }
  | new_line+ { main lexbuf }
  | "let" { LET }
  | "=" { EQUAL }
  | "in" { IN }
  | "=>" { ARROW }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | identifier+ as id { NAME id }
  | eof { EOF }
  | _ as c { failwith(Printf.sprintf "Unexpected char '%c'" c) }