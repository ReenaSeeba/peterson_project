open Peterson
open Alcotest

(* Testib süsteemi algseisundit *)
let test_initial_state () =
  let state = initial_state in
  check bool "initial critical1" false state.critical1;
  check bool "initial critical2" false state.critical2;
  check bool "initial flag1" false state.flag1;
  check bool "initial flag2" false state.flag2;
  check int "initial turn" 1 state.turn

(* Testib step funktsiooni *)
let test_step () =
  let state = step initial_state 1 in
  check bool "flag1 set" true state.flag1;
  check int "turn set to 2" 2 state.turn;
  let state = step state 2 in
  check bool "flag2 set" true state.flag2;
  check int "turn set to 1" 1 state.turn

(* Testib model check funktsiooni, et ei toimuks samaaegset kriitilisse sektsiooni sisenemist *)
let test_model_check () =
  let state = initial_state in
  let state = step state 1 in
  let state = step state 2 in
  let state = leave_critical state 1 in
  let state = leave_critical state 2 in
  let no_error = not (is_error state) in
  check bool "model check no error" true no_error

let () =
  let open Alcotest in
  run "Peterson's Algorithm Tests" [
    "initial state", [
      test_case "initial state" `Quick test_initial_state;
    ];
    "step", [
      test_case "step" `Quick test_step;
    ];
    "model check", [
      test_case "model check" `Quick test_model_check;
    ];
  ]
