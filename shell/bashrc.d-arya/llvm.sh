#### LLVM
# required when llvm installed via brew
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L$BREW_PREFIX/opt/llvm/lib/c++ -Wl,-rpath,$BREW_PREFIX/opt/llvm/lib/c++"
export CPPFLAGS="-I$BREW_PREFIX/opt/llvm/include"
