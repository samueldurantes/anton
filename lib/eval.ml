open Tree

type context = (string * hterm) list

let rec lookup k ctx =
  match ctx with
  | [] -> Option.none
  | (x :: xs) -> if k == (fst x)
    then Option.some (snd x)
    else lookup k xs

let find_variable name ctx =
  match lookup name ctx with
  | None -> failwith ("Unbound variable: '" ^ name ^ "'")
  | Some v -> v

let app func arg =
  match func with
  | HLam { f } -> f arg
  | _ -> HApp { func; arg }

let rec eval term (ctx : context) =
  match term with
  | Var { name } -> find_variable name ctx
  | Lam { param; body } ->
    let f = fun x -> eval body ((param, x) :: ctx) in
    HLam { f }
  | App { func; arg } ->
    let func = eval func ctx in
    let arg = eval arg ctx in
    app func arg
  | Let { name; body; expr } ->
    eval expr ((name, (eval body ctx)) :: ctx)

let rec quote_aux h depth =
  match h with
  | HVar { name } -> Var { name }
  | HLam { f } ->
    let param = "x" ^ string_of_int depth in
    let body = quote_aux (f (HVar { name = param })) (depth + 1) in
    Lam { param; body }
  | HApp { func; arg } ->
    let func = quote_aux func depth in
    let arg = quote_aux arg depth in
    App { func; arg }

let quote h = quote_aux h 0
