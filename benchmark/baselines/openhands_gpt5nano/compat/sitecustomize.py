"""Process-local OpenHands compatibility switches for OpenAI-compatible gateways."""

from __future__ import annotations

import os


if os.environ.get("OPENHANDS_FORCE_CHAT_COMPLETIONS") == "1":
    from openhands.sdk.llm.utils import model_features

    model_features.RESPONSES_API_MODELS[:] = [
        pattern for pattern in model_features.RESPONSES_API_MODELS if pattern != "gpt-5"
    ]
