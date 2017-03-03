# nagel_schreckenberg_model

Simulation code of Nagel-Schreckenberg model written in Ruby.
https://en.wikipedia.org/wiki/Nagel%E2%80%93Schreckenberg_model

## Prerequisites

Install ruby 1.9 or later and [bundler](http://bundler.io/) gem.
To install bundler gem, run the following command

```
gem install bundler
```

After you installed bundler, then run `bundle` command to install the dependent library.

```
bundle
```

## Usage

Inpur for this simulator is the following.

- lane length (integer)
- maximum velocity (integer)
- car density (float)
- deceleration probability (float)
- initial thermalization step (integer)
- measurement step (integer)
- random number seed (integer)

To run the simulator, give the above parameters as arguments of `run.sh`.

```
./run.sh 100 5 0.3 0.1 100 100 1234
```

After the simulation finished, you will find two files `traffic.png` and `_output.json`.
The png file shows the network snapshot as shown in the following.
The json file has the average velocity and the amount of flow calculated during the measurement steps.

```json:_output.json
{
  "velocity": 1.902000000000001,
  "flow": 0.5706
}
```

## Snapshot

The horizontal and vertical axis indicate space and time, respectively. Colored squares are cars, moving to the right direction.
The colors of the cars denote the velocity of the cars. Green cars moves fast while red cars moves slowly so the red cars are in a traffic jam.

![snapshot](https://raw.githubusercontent.com/yohm/nagel_schreckenberg_model/master/sample.png)

## Using with OACIS

To register this simulation code to OACIS, run the following code. It will run `bundle` and registers the simulator on OACIS.

```sh
./install_on_oacis.sh
```

## License

The MIT License (MIT)

Copyright (c) 2015 Yohsuke Murase

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
