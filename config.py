from dataclasses import dataclass

@dataclass
class LLMConfig:
    """LLM API configuration"""
    use_api_model: bool = True  # Control whether to use API model or local Transformers model
    api_model: str = "claude-sonnet-4-6"  # Default API model
    api_key: str = "sk-531Gm6lDz4TntanpSd8Pp8BYzUNGqQ90XukBrw4Xxo1eI4SQ"
    base_url: str = "https://yunwu.ai/v1"
    api_temperature: float = 0.7  # Temperature parameter for API calls
