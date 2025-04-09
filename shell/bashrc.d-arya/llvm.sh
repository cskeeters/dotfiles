#### LLVM
# required when llvm installed via brew
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L$BREW_PREFIX/opt/llvm/lib/c++ -Wl,-rpath,$BREW_PREFIX/opt/llvm/lib/c++"
export CPPFLAGS="-I$BREW_PREFIX/opt/llvm/include"

# LDFLAGS="-L/opt/homebrew/opt/llvm/lib/unwind -lunwind"

# To use the bundled libc++ please use the following LDFLAGS:
# LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/llvm/lib/unwind -lunwind"

# NOTE: You probably want to use the libunwind and libc++ provided by macOS unless you know what you're doing.

# llvm is keg-only, which means it was not symlinked into /opt/homebrew,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.

# If you need to have llvm first in your PATH, run:
#  echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> /Users/chad/.bash_profile

# For compilers to find llvm you may need to set:
#  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
#  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
