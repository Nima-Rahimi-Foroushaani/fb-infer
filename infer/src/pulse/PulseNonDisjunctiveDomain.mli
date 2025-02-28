(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd
module BaseMemory = PulseBaseMemory

type copy_spec_t = Copied of {typ: Typ.t; location: Location.t; heap: BaseMemory.t} | Modified

include AbstractDomain.WithBottom

val add : Var.t -> source_addr_opt:PulseAbstractValue.t option -> copy_spec_t -> t -> t

val checked_via_dtor : Var.t -> t -> t

val mark_copy_as_modified :
     is_modified:(BaseMemory.t -> bool)
  -> copied_var:Var.t
  -> source_addr_opt:PulseAbstractValue.t option
  -> t
  -> t

val get_copied : t -> (Var.t * Typ.t * Location.t) list

val is_checked_via_dtor : Var.t -> t -> bool

val set_captured_variables : Exp.t -> t -> t
