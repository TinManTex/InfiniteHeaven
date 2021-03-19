# lua-resty-tsort

Performs a topological sort on input data.

## Synopsis

```lua
local dump  = require "pl.pretty".dump
local tsort = require "resty.tsort"

local graph = tsort.new()

graph:add('a', 'b')
graph:add('b', 'c')
graph:add('0', 'a')

dump(graph:sort())

-- Output:
-- {
--   "0",
--   "a",
--   "b",
--   "c"
-- }

graph:add('1', '2', '3', 'a');

dump(graph:sort())

-- Output:
-- {
--   "0",
--   "1",
--   "2",
--   "3",
--   "a",
--   "b",
--   "c"
-- }

graph:add{'1', '1.5'};
graph:add{'1.5', 'a'};

dump(graph:sort())

-- Output:
-- {
--   "0",
--   "1",
--   "2",
--   "3",
--   "1.5",
--   "a",
--   "b",
--   "c"
-- }

graph:add('first', 'second');
graph:add('second', 'third', 'first');

local sorted, err = graph:sort()

-- Returns:
-- sorted = nil
-- err = "There is a circular dependency in the graph. It is not possible to derive a topological sort."
```

## Alternatives

Before developing this library, I asked on #lua channel on Freenode if anyone knows a library that does
topological sort. I also tried to search for a library. Unfortunately I didn't find anything. But, there
was already a library from the great [@starius](https://github.com/starius) called [toposort](https://github.com/starius/toposort/).
`toposort` looks really nice and it has a lot more features compared to `lua-resty-tsort` (also code, 245 lines vs. 58 lines).
So you may want to take a look to that as well especially if you are looking for a more full featured library.
I have not benchmarked these libs or compared them to C-implementation of tsort or other alternatives. If your graph
is not too big, say you use these to sort Javascript / CSS files or something similar, I think the performance
is not an issue.

## License

`lua-resty-tsort` uses two clause BSD license.

```
Copyright (c) 2016, Aapo Talvensaari
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```
