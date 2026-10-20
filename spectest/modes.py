"""Public execution presets and aliases for existing jobs/executors."""

EXECUTION_MODES = ("entry-exit", "all-boundaries")
EXECUTION_STRATEGIES = ("inline", "modular")
EXECUTION_SEMANTICS = {"inline": "inline-preserve/v1", "modular": "modular-hybrid/v2"}
def execution_semantics(strategy: str, modular_instantiation: str = "on") -> str:
    if strategy == "modular" and modular_instantiation == "off":
        return "modular-symbolic/v1"
    return EXECUTION_SEMANTICS[strategy]


MODE_ALIASES = {"expand": "entry-exit", "no-expand": "all-boundaries"}


def normalize_execution_mode(value: str) -> str:
    if not isinstance(value, str):
        raise ValueError("execution mode must be entry-exit or all-boundaries")
    value = MODE_ALIASES.get(value, value)
    if value not in EXECUTION_MODES:
        raise ValueError("execution mode must be entry-exit or all-boundaries")
    return value


def normalize_execution_strategy(value: str) -> str:
    if not isinstance(value, str) or value not in EXECUTION_STRATEGIES:
        raise ValueError("execution strategy must be inline or modular")
    return value
