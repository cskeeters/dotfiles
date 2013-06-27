  #Skip a few lines so we exclude the title
  N;N;N
:skip
  #Did we get the title yet?
  /=+\n.*\n=+/{p;b s}
  N
  b skip

:s
  n;h
:r
  n
  # Should always have one line in holding and ready to test the next line

  
  # H1 
  /^=+/{
    i\

    i\
.. raw:: pdf
    i\

    i\
  FrameBreak 250
    i\

    # print header
    x;p;
    # print underline
    x;p;
    b s
  }

  # H2 
  /^-+/{
    i\

    i\
.. raw:: pdf
    i\

    i\
  FrameBreak 200
    i\

    # print header
    x;p;
    # print underline
    x;p;
    b s
  }

  # No headings
  # print non-header
  x;p;
  # put eval line back in hold
  x;h;
  b r
