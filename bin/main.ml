open Anton.Cli

let file = "
  let exp = m => n => (n m) in
  let two = f => x => f (f x) in

  (exp two two)
"

let () =
  print_endline (run_cli file)
