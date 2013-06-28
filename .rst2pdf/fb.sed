  #This sed file adds in FrameBreak pdf options so that when pdfs are generated,
  #it headings won't start towards the bottom of pages
  #Usage: cat rst | sed -nr -f ~/.rst2pdf/fb.sed | rst2pdf > rst.pdf

  #Skip a few lines so we exclude the title
  N;N;N
:skip
  #Did we get the title yet?
  /=+\n.*\n=+/{p;b start}
  N
  b skip

:start
  n;h
:rep
  n
  # Should always have one line in holding and ready to test the next line

  
  # H1 
  /^=+/{
    i\
\
.. raw:: pdf\
\
  FrameBreak 250\

    # print header
    x;p;
    # print underline
    x;p;
    b start
  }

  # H2 
  /^-+/{
    i\
\
.. raw:: pdf\
\
  FrameBreak 200\

    # print header
    x;p;
    # print underline
    x;p;
    b start
  }

  # No headings
  # print non-header
  x;p;
  # put eval line back in hold
  x;
  # if it's the last line, print it
  $p
  # else put it in the hold buffer and go back through
  $!{h;b rep}
