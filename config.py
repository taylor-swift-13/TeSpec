from dataclasses import dataclass

@dataclass
class LLMConfig:
    """LLM API configuration"""
    use_api_model: bool = True  # Control whether to use API model or local Transformers model
    api_model: str = "gpt-5-nano"  # Default API model
    api_key: str = "sk-afVplv2oRlR8SnMlC3K0ndGKOIsaBN5O3zxrD1B7zWzgNWGA"
    base_url: str = "https://yunwu.ai/v1"
    api_temperature: float = 0.7  # Temperature parameter for API calls
