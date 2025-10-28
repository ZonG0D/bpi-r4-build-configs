# Hardened TF-A defaults for the Banana Pi R4.
# Use '?=' assignments so downstream build scripts can override any option.

RESET_TO_BL31            ?= 1
PROGRAMMABLE_RESET_ADDRESS ?= 0

# Enable secure-boot plumbing.  Keys must still be provided by the integrator.
TRUSTED_BOARD_BOOT       ?= 1
MEASURED_BOOT            ?= 0
GENERATE_COT             ?= 1

# Instrumentation and profiling support help catch regressions early.
ENABLE_PMF               ?= 1
ENABLE_RUNTIME_INSTRUMENTATION ?= 1

# Harden the firmware image itself.
ENABLE_ASSERTIONS        ?= 0
ENABLE_STACK_PROTECTOR   ?= strong
ENABLE_SVE_FOR_NS        ?= 0
CTX_INCLUDE_AARCH32_REGS ?= 0
