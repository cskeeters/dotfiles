from ranger.api.commands import *

class customexample(Command):
    def execute(self):
        # if not self.arg(1):
        #     self.fm.notify('Wrong number of arguments', bad=True)
        #     return

        # First argument. 0 is the command name.
        # self.fm.notify(self.arg(1))

        # Current directory to status line.
        # self.fm.notify(self.fm.thistab.thisdir.path)

        self.fm.run(['echo', self.fm.thistab.thisdir.path])
        self.fm.run(['sleep', '2'])

class opendirvim(Command):
    def execute(self):
        self.fm.run(['nvim', self.fm.thistab.thisdir.path])

class opendirfinder(Command):
    def execute(self):
        self.fm.run(['open', self.fm.thistab.thisdir.path])

class fzfvim(Command):
    def execute(self):
        self.fm.run(['bash', '-c', 'nvim $(fd -type f | fzf)'])
