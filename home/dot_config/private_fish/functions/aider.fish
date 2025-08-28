function aider
    set aider_bin (which aider 2>/dev/null)
    set -x DEEPSEEK_API_KEY (rbw get deepseek_api_key 2>/dev/null)
    set -x GEMINI_API_KEY (rbw get gemini_api_key 2>/dev/null)
    set -x OPENAI_API_KEY (rbw get openai_api_key 2>/dev/null)
    set -x MISTRAL_API_KEY (rbw get mistral_api_key 2>/dev/null)
    set -x OPENROUTER_API_KEY (rbw get openrouter_api_key 2>/dev/null)
    $aider_bin $argv
end
