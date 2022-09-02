open Anton.Tree
open Anton.Eval

let two =
  Lam {
    param = "f";
    body = Lam {
      param = "x";
      body = App {
        func = Var { name = "f" };
        arg = App {
          func = Var { name = "f" };
          arg = Var { name = "x" }
        }
      }
    }
  }

let exp =
  Lam {
   param = "m";
   body = Lam {
      param = "n";
      body = App {
        func = Var { name = "n" };
        arg = Var { name = "m" }
      }
    }
  }

let four = 
  App {
    func = exp;
    arg = App {
      func = two;
      arg = two;
    }
  }

let app = 
  App {
    func = exp;
    arg = App {
      func = four;
      arg = two;
    }
  }

let () = print_endline (term_to_string (quote (eval app [])))
