type state = {
  flag1 : bool;        (* Näitab, kas lõim 1 soovib siseneda kriitilisse sektsiooni *)
  flag2 : bool;        (* Näitab, kas lõim 2 soovib siseneda kriitilisse sektsiooni *)
  turn : int;          (* Näitab, kummal lõimel on eesõigus siseneda kriitilisse sektsiooni *)
  critical1 : bool;    (* Näitab, kas lõim 1 on kriitilises sektsioonis *)
  critical2 : bool;    (* Näitab, kas lõim 2 on kriitilises sektsioonis *)
}

(* Funktsioon lõime sammu simuleerimiseks *)
let step state thread =
  match thread with
  | 1 ->
    if not state.flag1 then
      (* Lõim 1 soovib siseneda kriitilisse sektsiooni *)
      { state with flag1 = true; turn = 2 }
    else if state.flag2 && state.turn = 2 then
      (* Lõim 2 kord, lõim 1 ootab *)
      state
    else
      (* Lõim 1 siseneb kriitilisse sektsiooni *)
      { state with critical1 = true }
  | 2 ->
    if not state.flag2 then
      (* Lõim 2 soovib siseneda kriitilisse sektsiooni *)
      { state with flag2 = true; turn = 1 }
    else if state.flag1 && state.turn = 1 then
      (* Lõim 1 kord, lõim 2 ootab *)
      state
    else
      (* Lõim 2 siseneb kriitilisse sektsiooni *)
      { state with critical2 = true }
  | _ -> failwith "Invalid thread number"

(* Funktsioon lõime lahkumise/väljumise simuleerimiseks kriitilisest sektsioonist *)
let leave_critical state thread =
  match thread with
  | 1 -> { state with critical1 = false; flag1 = false }
  | 2 -> { state with critical2 = false; flag2 = false }
  | _ -> failwith "Invalid thread number"

(* Funktsioon kontrollimaks, kas mõlemad lõimed on samaaegselt kriitilises sektsioonis *)
let is_error state =
  state.critical1 && state.critical2

(* Rekursiivne funktsioon süsteemi seisundi üleminekute kontrollimiseks *)
let rec model_check state steps =
  if steps = 0 then
    false
  else if is_error state then
    true
  else
    let state1 = step state 1 in
    let state1 = if state1.critical1 then leave_critical state1 1 else state1 in
    let state2 = step state 2 in
    let state2 = if state2.critical2 then leave_critical state2 2 else state2 in
    model_check state1 (steps - 1) || model_check state2 (steps - 1)

(* Süsteemi algseisund *)
let initial_state = {
  flag1 = false;
  flag2 = false;
  turn = 1;
  critical1 = false;
  critical2 = false;
}
