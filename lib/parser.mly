%{
  open Tree
%}

%token <string> NAME

%token ARROW
%token LET IN
%token EQUAL
%token LPAREN RPAREN
%token EOF

%start <term option> main

%%

main:
  | term EOF { Option.some $1 }
  | EOF { Option.none }

term:
  | NAME ARROW term { Lam { param = $1; body = $3; } }
  | LET NAME EQUAL term IN term { Let { name = $2; body = $4; expr = $6 } }
  | call { $1 }

atom:
  | NAME { Var { name = $1 } }
  | LPAREN term RPAREN { $2 }

call:
  | atom { $1 }
  | call atom { App { func = $1; arg = $2 } }