function nvim
    set keys deepseek_api_key gemini_api_key openai_api_key mistral_api_key openrouter_api_key tavily_api_key brave_api_key
    set nvim_bin (which nvim 2>/dev/null)

    for key in $keys
        set varname (string upper $key)
        if not set -q $varname
            # Run rbw in background and export the variable
            begin
                set -x $varname (rbw get $key 2>/dev/null)
            end &
        end
    end

    $nvim_bin $argv
end
