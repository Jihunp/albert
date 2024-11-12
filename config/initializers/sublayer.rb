require_relative "../../lib/sublayer/providers/gpt_with_images"
Sublayer.configuration.ai_provider = Sublayer::Providers::GptWithImages
Sublayer.configuration.ai_model = "gpt-4o-2024-08-06"