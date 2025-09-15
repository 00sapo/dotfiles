function nvim
    set keys deepseek_api_key gemini_api_key openai_api_key mistral_api_key openrouter_api_key tavily_api_key brave_api_key
    set nvim_bin (which nvim 2>/dev/null)

    if contains -- -k $argv
        set start_time (date +%s%3N) # milliseconds

        rbw unlock

        set tempdir (mktemp -d)
        set pids

        for key in $keys
            set -l varname (string upper $key)
            if not set -q $varname
                rbw get $key 2>/dev/null >$tempdir/$varname &
                set -a pids $last_pid
            end
        end

        for pid in $pids
            wait $pid
        end

        for key in $keys
            set -l varname (string upper $key)
            if test -f $tempdir/$varname
                set -x $varname (cat $tempdir/$varname)
            end
        end

        rm -rf $tempdir

        set end_time (date +%s%3N)
        set elapsed (math "$end_time - $start_time")
        echo "Key setup took $elapsed ms"

        # Remove -k from argv
        set new_argv
        for arg in $argv
            if test $arg != -k
                set new_argv $new_argv $arg
            end
        end
        set argv $new_argv
    end

    $nvim_bin $argv
end
