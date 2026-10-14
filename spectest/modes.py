"""Public execution presets and aliases for existing jobs/executors."""

EXECUTION_MODES = ("entry-exit", "all-boundaries")
MODE_ALIASES = {"expand": "entry-exit", "no-expand": "all-boundaries"}


def normalize_execution_mode(value: str) -> str:
    if not isinstance(value, str):
        raise ValueError("execution mode must be entry-exit or all-boundaries")
    value = MODE_ALIASES.get(value, value)
    if value not in EXECUTION_MODES:
        raise ValueError("execution mode must be entry-exit or all-boundaries")
    return value
