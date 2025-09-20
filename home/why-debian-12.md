1. torchaudio needs ffmpeg<7 (trixie ships 7.*)
2. sfizz provides binaries for debian 12, not 13 (but they probably work)
3. plugdata provides binaries for debian 12, not 13 (but they probably work)
4. sfizz, plugdata, and bespokesynth use the old keyring format, which will be unsupported in a
   while in debian 13
