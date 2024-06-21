open Peterson

(* Peamine funktsioon Petersoni algoritmi implementatsiooni kontrollimiseks *)
let () =
  if model_check initial_state 10 then
    print_endline "Viga: Mõlemad lõimed on samaaegselt kriitilises sektsioonis."
  else
    print_endline "Viga ei tuvastatud."
