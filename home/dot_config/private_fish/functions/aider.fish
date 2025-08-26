function aider
    set aider_bin (which aider 2>/dev/null)
    DEEPSEEK_API_KEY=(rbw get deepseek_api_key 2>/dev/null) $aider_bin $argv
end
