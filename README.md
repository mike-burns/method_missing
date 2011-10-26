method\_missing
==============

The Method gem you've been waiting for.

The method\_missing gem brings the functional tools you need to Ruby: method composition, sequencing, and repeating. These are useful for when you must combine methods, apply different methods to the same argument, or "grow" a method.

I'll explain, but first:

Installing
----------

    gem install method_missing

Usage: Composing
----------------

This is the classic. In algebra class you learned that `f(g(x))` can also be written `(f . g)(x)`. This is handy because now you have this `(f . g)` object that you can pass to integrals and whatnot.

So in Ruby, using the method\_missing gem:

    def escape_everything(text)
      everything_ecaper.call(text)
    end

    def everything_ecaper
      method(:html_escape) * method(:escape_javascript) * method(:json_escape)
    end

And more algebraically:

    (f * g).call(x) == f.call(g.call(x))

Usage: Sequencing
-----------------

This doesn't come up as often but when it does, oh boy, does it ever! This is useful for when you have a bunch of methods to apply to the same argument. For example, using the method\_missing gem:

    def valid_options?(options_checker, options)
      options_checker.at_most_one(
        (method(:sort_mod_time) / method(:sort_access_time)).call(options)) &&
      options_checker.at_most_one(
        (method(:sort_file_size) / method(:sort_mod_time)).call(options))
     end
      
Again, more algebraically:

    (f / g / h).call(x) == [f.call(x), g.call(x), h.call(x)]

Usage: Repeating
----------------

This one comes up the least in most people's day-to-day life. It's the concept of applying a method to its output, repeatedly. Here's a contrived example, using the method\_missing gem:

    def church_encoding(n)
      if n.zero?
        lambda{|f,x| x}
      else
        lambda{|f,x| (f ^ n).call(x)}
      end
    end

Algebraically:

    (f ^ 3).call(4) == f.call(f.call(f.call(4)))

Usage: Combining
----------------

These are objects which can be combined! Here's an example, also contrived, that turns an object into a number, *n*, then adds four to *n* and multiplies *n* by six, then sums those results, using primitive methods that add one to a number and multiply a number by two:

    def interesting_math(o)
      four_and_six.call(o).sum
    end

    def four_and_six
      ((add1 ^ 4) / (mul2 ^ 3)) * method(:to_i)
    end

To show this algebraically:

    (((add1 ^ 4) / (mul2 ^ 3)) * method(:to_i)).call(o) == [
      add1.call(add1.call(add1.call(add1.call(o.to_i)))),
      mul2.call(mul2.call(mul2.call(o.to_i)))
    ]

Copyright
---------
Copyright 2011 Mike Burns
