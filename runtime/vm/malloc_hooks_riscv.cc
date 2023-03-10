// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#include "vm/malloc_hooks.h"

#include "vm/globals.h"

#if defined(HOST_ARCH_RISCV32) || defined(HOST_ARCH_RISCV64)

namespace dart {

const intptr_t kSkipCount = 5;

}  // namespace dart

#endif  // defined(HOST_ARCH_RISCV32) || defined(HOST_ARCH_RISCV64)
