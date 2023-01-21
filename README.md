## JRubyArt.

As RubyProcessing is now deprecated this a home for JRubyArt.

JRubyArt relies on `jruby-9.1.12.0`
and uses the `k9 -r` or `k9 -w` commands.

Decent documentation live here:<p>
[JRubyArt Setup](https://github.com/ruby-processing/JRubyArt#jrubyart).<p>
[Mac Documentation](http://ruby-processing.github.io/JRubyArt/mac_start/).<p>
[Differences with RubyProcessing](http://ruby-processing.github.io/JRubyArt/jruby_art/update/2015/09/28/comparison.html).<p>

Some java jdk will likely need to be installed, with a pointer to:
1. `https://www.oracle.com/java/technologies/downloads/#jdk17-mac`
2. `export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home`

Note: installation may require sudo in number of places:
  1. gem install jruby_art
  2. sudo k9 --install
  3. etc...

further,

size, smooth and many other setup methods are no longer<p>
supported in the `setup` method. JRubyArt now has a `settings` method.
  
  
Much of the Code in this Repo will need to be updated,<p>
especially wrt the `settings` conversion.
  
```
  # Add the following method to any Ruby Processing file without it.
  # Remove size(displayWidth, displayHeight) from setup.
  def settings ; size(displayWidth, displayHeight) ; end
```
