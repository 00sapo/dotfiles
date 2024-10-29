# function fish_command_not_found
#    # "In a container" check
#     if test ! -e /run/.containerenv -a ! -e /.dockerenv
#         if distrobox-enter debian-nvidia -- which $argv
#             echo "Command exists in debian-nvidia"
#             read -l -P "Export command to host? [y/N] " export
#             if test "$export" = y
#                 distrobox-enter debian-nvidia -- distrobox-export -b (distrobox-enter debian-nvidia -- which $argv)
#             end
#         end
#     else
#         __fish_default_command_not_found_handler $argv
#     end
# end
