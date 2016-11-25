#Setup Script
[![Build Status](https://travis-ci.org/joedaniels29/setup_script.svg?branch=master)](https://travis-ci.org/joedaniels29/setup_script)


## Usage

This is a set of scripts that I use to set a computer up for development. My goal is a
setup script that can bootstrap itsself up from a single  `curl <url> | sh` and
entirely set itsself, and then the computer up.

This is a heavily customized fork of [ThoughtBot's ](https://thoughtbot.com)  [Laptop](https://github.com/thoughtbot/laptop)  script.
This script, however is much more opinionated and intends to install substantially more than thoughtbot.

##Tested ✅

The beauty of this script is that despite the fact that we rarely setup new laptops,
CI servers can help us reason about how successful this script will be year over year.
Therefore, this script is intended to be well tested. (WIP.)
Travis-ci is testing this script make sure that everything installs.

## Contributing

For now, the script is hardwired to put all my configs and personal env. in place. you probs. dont want that for yourself. (Maybe you do?)

But if you want to help out, travis still needs some configuring to confirm that each thing builds.

##Install
Download, review, then execute the script:

```sh
curl --remote-name https://raw.githubusercontent.com/joedaniels29/setup_script/master/bootstrap.sh
less bootstrap.sh
sh bootstrap.sh 2>&1 | tee ~/bootstrap.log
```

## Debugging
#### FUTURE! (WIP.)

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/thoughtbot/laptop/issues/new) for us.
Or, attach the whole log file as an attachment.



## License

The MIT License (MIT)
Copyright (c) 2016 Joseph Daniels

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
