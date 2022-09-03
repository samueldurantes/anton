type term =
  | Var of { name : string; }
  | Lam of { param : string; body : term }
  | App of { func : term; arg : term; }
  | Let of { name : string; body : term; expr : term; }

type hterm =
  | HVar of { name : string; }
  | HLam of { f : hterm -> hterm; }
  | HApp of { func : hterm; arg : hterm; }

let rec term_to_string t =
  match t with
  | Var { name } -> name
  | Lam { param; body } -> "λ" ^ param ^ "." ^ term_to_string body
  | App { func; arg } -> "(" ^ term_to_string func ^ " " ^ term_to_string arg ^ ")"
  | Let { name; body; expr } ->
    "let " ^ name ^ " = " ^ term_to_string body ^ " in " ^ term_to_string expr