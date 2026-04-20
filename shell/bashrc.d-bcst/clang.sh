# Required for building/compiling tree-sitter (rust)
# Needs /usr/lib64/clang-private/libclangAST.so.7
#
#   cargo install tree-sitter-cli

export LIBCLANG_PATH=/usr/lib64/clang-private
export LD_LIBRARY_PATH=/usr/lib64/clang-private:$LD_LIBRARY_PATH
