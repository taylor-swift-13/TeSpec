import openai
import re
from config import LLMConfig
from abc import ABC, abstractmethod


# Abstract base class defining unified interface
class BaseChatModel(ABC):
    def __init__(self, config: LLMConfig):
        self.config = config
        # Message history for maintaining conversation context
        self.messages = [{"role": "system", "content": "You are a helpful assistant."}]

    @abstractmethod
    def generate_response(self, user_input: str) -> str:
        """
        Generate response based on user input.
        Subclasses must implement this method.
        """
        pass



# LLM class using OpenAI-compatible API
class OpenAILLM(BaseChatModel):
    def __init__(self, config: LLMConfig):
        super().__init__(config)
        self.client = openai.OpenAI(
            base_url=self.config.base_url,
            api_key=self.config.api_key
        )
        # Use specific model name and temperature for OpenAI API
        self.model_name = self.config.api_model
        self.temperature = self.config.api_temperature

    def generate_response(self, user_input: str) -> str:
        try:
            # Add user input to message history
            self.messages.append({"role": "user", "content": user_input})

            # Call OpenAI API
            response = self.client.chat.completions.create(
                model=self.model_name,
                messages=self.messages,
                temperature=self.temperature,
            )

            assistant_response = response.choices[0].message.content
            
            self.messages.append({"role": "assistant", "content": assistant_response})  # Add original response to history to maintain complete context

            return assistant_response

        except Exception as e:
            # Remove failed user input from history to avoid resending next time
            if self.messages and self.messages[-1]["role"] == "user":
                self.messages.pop()
            raise RuntimeError(f"OpenAI API call failed: {e}") from e


# Main control class that selects LLM implementation based on configuration
class Chatbot:
    def __init__(self, config: LLMConfig):
        self.config = config
        if self.config.use_api_model:
            self.llm_instance = OpenAILLM(config)
        else:
            print("Warning: use_api_model is False, no LLM instance created")
            self.llm_instance = None

    def chat(self, user_input: str) -> str:
        if self.llm_instance is None:
            print("Error: LLM instance is None, cannot generate response")
            return "Error: LLM instance not initialized"
        response = self.llm_instance.generate_response(user_input)
        return response

    def new_chat(self, user_input: str) -> str:
        self.llm_instance = OpenAILLM(self.config)
        response = self.llm_instance.generate_response(user_input)
        return response


# 示例用法
if __name__ == "__main__":
    # --- 示例 1: 使用 API 模型 ---
    print("--- 示例 1: 使用 API 模型 ---")
    api_config = LLMConfig()
    api_config.use_api_model = True 
    api_bot = Chatbot(api_config)

    user_input_api_1 = "你好，你是一个什么样的助手？"
    print(f"User: {user_input_api_1}")
    response_api_1 = api_bot.chat(user_input_api_1)
    print(f"Bot: {response_api_1}")
    print("----------------------")

    user_input_api_2 = "请问草莓(strawberries)里有多少个字母 'r'？"
    print(f"User: {user_input_api_2}")
    response_api_2 = api_bot.chat(user_input_api_2)
    print(f"Bot: {response_api_2}")
    print("----------------------")
