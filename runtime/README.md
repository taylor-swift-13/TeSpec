# Bundled runtime resources

`qcip/` contains the QCP/QCIP resources needed by `qcp-spectest` at runtime:

- `SeparationLogic`: Coq sources and compiled libraries used to check residual VCs;
- `QCP_examples`: reusable QCP headers and strategy files.

Domain-specific C sources, headers, strategies, and Coq `.v` modules are not
global runtime resources. Each regression under `cases/` owns its dependencies.
Case-local Coq modules use
`cases/CASE/dependencies/coq/LOGICAL/MODULE.v`; they are staged recursively
under the same logical module path when a residual VC is checked.

The modified concrete symbolic executor is stored separately at
`../bin/qcp-symexec`.

System dependencies are not copied here: Linux/glibc and Python are required
to run the tool; Coq 8.20 is required only when a residual VC must be compiled.
