open Peterson

let () =
  if model_check initial_state 10 then
    print_endline "Error: Both threads are in the critical section simultaneously."
  else
    print_endline "No error detected."
