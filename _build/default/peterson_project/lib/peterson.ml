(* Define the state of the system *)
type state = {
  flag1 : bool;        (* Indicates if thread 1 wants to enter critical section *)
  flag2 : bool;        (* Indicates if thread 2 wants to enter critical section *)
  turn : int;          (* Indicates whose turn it is to enter critical section *)
  critical1 : bool;    (* Indicates if thread 1 is in critical section *)
  critical2 : bool;    (* Indicates if thread 2 is in critical section *)
}

(* Function to simulate a step taken by a thread *)
let step state thread =
  match thread with
  | 1 ->
    if not state.flag1 then
      (* Thread 1 wants to enter critical section *)
      { state with flag1 = true; turn = 2 }
    else if state.flag2 && state.turn = 2 then
      (* Thread 2's turn, Thread 1 waits *)
      state
    else
      (* Thread 1 enters critical section *)
      { state with critical1 = true }
  | 2 ->
    if not state.flag2 then
      (* Thread 2 wants to enter critical section *)
      { state with flag2 = true; turn = 1 }
    else if state.flag1 && state.turn = 1 then
      (* Thread 1's turn, Thread 2 waits *)
      state
    else
      (* Thread 2 enters critical section *)
      { state with critical2 = true }
  | _ -> failwith "Invalid thread number"

(* Function to simulate a thread leaving the critical section *)
let leave_critical state thread =
  match thread with
  | 1 -> { state with critical1 = false; flag1 = false }
  | 2 -> { state with critical2 = false; flag2 = false }
  | _ -> failwith "Invalid thread number"

(* Function to check if both threads are in the critical section simultaneously *)
let is_error state =
  state.critical1 && state.critical2

(* Recursive function to model check the system's state transitions *)
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

(* Initial state of the system *)
let initial_state = {
  flag1 = false;
  flag2 = false;
  turn = 1;
  critical1 = false;
  critical2 = false;
}
