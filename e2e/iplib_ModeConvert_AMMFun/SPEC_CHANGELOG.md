# Specification changelog

## v001

- Added a QCP footprint for the seven fields read or written by
  `ModeConvert_AMMFun`.
- Specified the sequential precedence of orbit injection, next-mode 2, and
  next-mode 1 updates.
- Added 30 concrete binds covering all feasible state transitions and their
  comparison boundaries.

## final_spec.c (frozen; formerly v002)

- Restored two Chinese comments from the decoded GB18030 reference body.
- The QCP annotation and executable statements are unchanged from v001.
- Confirmed that the decoded function body is text-identical to the reference.
- Re-ran the complete reference, refinement-mutant, and held-out-mutant
  matrices.
- Removed the byte-identical `versions/v002.c` copy; `final_spec.c` is the
  canonical frozen artifact.
