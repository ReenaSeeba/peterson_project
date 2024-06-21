open Peterson

(* Peamine funktsioon Petersoni algoritmi implementatsiooni kontrollimiseks *)
let () =
  if model_check initial_state 10 then
    print_endline "Error: Both threads are in the critical section simultaneously."
  else
    print_endline "No error detected."
