message(STATUS "Prime elliptic curve arithmetic configuration (EP module):\n")

message("   ** Options for the prime elliptic curve module (default = all on):\n")

message("      EP_PLAIN=[off|on] Support for ordinary curves without endomorphisms.")
message("      EP_SUPER=[off|on] Support for supersingular curves.")
message("      EP_ENDOM=[off|on] Support for ordinary curves with endomorphisms.")
message("      EP_MIXED=[off|on] Use mixed coordinates.")
message("      EP_CTMAP=[off|on] Use contant-time SSWU and isogeny map for hashing.\n")

message("      EP_PRECO=[off|on] Build precomputation table for generator.")
message("      RLC_DEPTH=w        Width w in [2,8] of precomputation table for fixed point methods.")

message("   ** Available prime elliptic curve methods (default = PROJC;LWNAF;COMBS;INTER;SSWUM):\n")

message("      Point representation:")
message("      EP_METHD=BASIC    Affine coordinates.")
message("      EP_METHD=PROJC    Homogeneous projective coordinates (complete formula).")
message("      EP_METHD=JACOB    Jacobian projective coordinates.\n")

message("      Variable-base scalar multiplication:")
message("      EB_METHD=BASIC    Binary double-and-add method.")
message("      EP_METHD=SLIDE    Sliding window method.")
message("      EP_METHD=MONTY    Montgomery ladder method.")
message("      EP_METHD=LWNAF    Left-to-right window NAF method.")
message("      EP_METHD=LWREG    Left-to-right regular recoding method (GLV for curves with endomorphisms).\n")

message("      Fixed-base scalar multiplication:")
message("      EP_METHD=BASIC    Binary method for fixed point multiplication.")
message("      EP_METHD=COMBS    Single-table Comb method for fixed point multiplication.")
message("      EP_METHD=COMBD    Double-table Comb method for fixed point multiplication.")
message("      EP_METHD=LWNAF    Left-to-right window NAF method (GLV for curves with endomorphisms).\n")

message("      Variable-base simultaneous scalar multiplication:")
message("      EP_METHD=BASIC    Multiplication-and-addition simultaneous multiplication.")
message("      EP_METHD=TRICK    Shamir's trick for simultaneous multiplication.")
message("      EP_METHD=INTER    Interleaving of window NAFs (GLV for Koblitz curves).")
message("      EP_METHD=JOINT    Joint sparse form.\n")

message("      Hash to point on the elliptic curve:")
message("      EP_METHD=BASIC    Hash to x-coordinate and increment.")
message("      EP_METHD=SSWUM    Simplified Shallue-van de Woestijne-Ulas method.")
message("      EP_METHD=SWIFT    SwiftEC hashing method.\n")

option(EP_PLAIN "Support for ordinary curves without endomorphisms" on)
option(EP_SUPER "Support for supersingular curves" on)
option(EP_MIXED "Use mixed coordinates" on)
option(EP_ENDOM "Support for ordinary curves with endomorphisms" on)
option(EP_PRECO "Build precomputation table for generator" on)
option(EP_CTMAP "Use contant-time SSWU and isogeny map for hashing" on)

# Choose the arithmetic methods.
if (NOT EP_METHD)
	set(EP_METHD "PROJC;LWNAF;COMBS;INTER;SSWUM")
endif(NOT EP_METHD)
list(LENGTH EP_METHD EP_LEN)
if (EP_LEN LESS 5)
	message(FATAL_ERROR "Incomplete EP_METHD specification: ${EP_METHD}")
endif(EP_LEN LESS 5)

list(GET EP_METHD 0 EP_ADD)
list(GET EP_METHD 1 EP_MUL)
list(GET EP_METHD 2 EP_FIX)
list(GET EP_METHD 3 EP_SIM)
list(GET EP_METHD 4 EP_MAP)
set(EP_METHD ${EP_METHD} CACHE STRING "Method for prime elliptic curve arithmetic.")
