#!/usr/bin/env python

# Copyright (C) 2019 The SpaceXpanse developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

from spacexpansegametest.testcase import SpaceXpanseGameTest

import os
import os.path

class HelloWorldTest (SpaceXpanseGameTest):
  """A very simple integration test for the HelloWorld game."""

  def __init__ (self):
    super (HelloWorldTest, self).__init__ ("helloworld", "hello")

  def run (self):
    self.generate (101)
    self.expectGameState ({})

    self.sendMove ("bar", 42)
    self.sendMove ("foo", "Hello World!")
    self.generate (1)
    self.expectGameState ({
      "foo": "Hello World!",
    })

    self.sendMove ("bar", "Also hello from me!")
    self.sendMove ("foo", "Another message")
    self.generate (1)
    self.expectGameState ({
      "bar": "Also hello from me!",
      "foo": "Another message",
    })

    bestBlock = self.rpc.spacexpanse.getbestblockhash ()
    self.rpc.spacexpanse.invalidateblock (bestBlock)
    self.expectGameState ({
      "foo": "Hello World!",
    })

if __name__ == "__main__":
  HelloWorldTest ().main ()
