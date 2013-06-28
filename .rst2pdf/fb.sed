#Skip a few lines so we exclude the title
:skip
#title in pattern buffer?
/==*\n.*\n==*/{
  p;x;N;b rep
}
N
b skip

:rep
N
# Need to have 2 lines in pattern space
/\n==*/i\
\
.. raw:: pdf\
\
\  FrameBreak 250\
\

/\n--*/i\
\
.. raw:: pdf\
\
\  FrameBreak 200\
\

${p;n;}
P;s/.*\n\([.\n]*\)/\1/;b rep
