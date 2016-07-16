## ruby_app

A ruby script that receives a log as an argument e.g.
`$ ./parser.rb webserver.log`

b. Returns the following:

  > list of webpages with most page views ordered from most pages views to less page views
     e.g.:
         /home 90 visits
         /index 80 visits
         etc...

## installation

```
$ git clone https://github.com/genzade/ruby_app
$ cd ruby_app
$ bundle
```

## usage

After installation, type `./lib/parser.rb` in your commnd line with a log as your argument. Remember that this is a ruby script so prefix with ruby.

e.g. if you want to check someFileName.log

```
$ cd ruby_app
$ ruby lib/parser.rb path_to_target_file/someFileName.log
```
## TODOS

> list of webpages with most unique page views also ordered
     e.g.:
         /about/2   8 unique views
         /index     5 unique views
         etc...
